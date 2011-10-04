#!/usr/bin/env ruby
require 'rubygems'
require 'matrix'
require 'linalg'
require 'hornetseye_rmagick'
require 'hornetseye_ffmpeg'
require 'hornetseye_xorg'
require 'hornetseye_v4l2'
include Linalg
include Hornetseye
class Matrix
  def to_dmatrix
    DMatrix[*to_a]
  end
  def svd
    to_dmatrix.svd.collect { |m| m.to_matrix }
  end
end
class Vector
  def norm
    Math.sqrt inner_product(self)
  end
  def normalise
    self * (1.0 / norm)
  end
  def reshape( *shape )
    Matrix[*MultiArray[*self].reshape(*shape).to_a]
  end
  def x( other )
    Vector[self[1] * other[2] - self[2] * other[1],
           self[2] * other[0] - self[0] * other[2],
           self[0] * other[1] - self[1] * other[0]] *
      (2.0 / (norm + other.norm))
  end
end
class DMatrix
  def to_matrix
    Matrix[*to_a]
  end
end
class Node
  def nms(threshold)
    self >= dilate.major(threshold)
  end
  def have(n, corners)
    hist = mask(corners).histogram max + 1
    msk = hist.eq n
    if msk.inject :or
      id = argmax { |i| msk.to_ubyte[i] }.first
      eq id
    else
      nil
    end
  end
  def abs2
    real * real + imag * imag
  end
  def largest
    hist = histogram max + 1
    msk = hist.eq hist.max
    id = argmax { |i| msk.to_ubyte[i] }.first
    eq id
  end
  def otsu(hist_size = 256)
    hist = histogram hist_size
    idx = lazy(hist_size) { |i| i }
    w1 = hist.integral
    w2 = w1[w1.size - 1] - w1
    s1 = (hist * idx).integral
    s2 = to_int.sum - s1
    u1 = (w1 > 0).conditional s1.to_sfloat / w1, 0
    u2 = (w2 > 0).conditional s2.to_sfloat / w2, 0
    between_variance = (u1 - u2) ** 2 * w1 * w2
    max_between_variance = between_variance.max
    self > argmax { |i| between_variance[i] }.first
  end
end
def homography(m, ms)
  constraints = []
  m.to_a.flatten.zip(ms.to_a.flatten).each do |p,ps|
    constraints.push [p.real, p.imag, 1.0, 0.0, 0.0, 0.0,
                      -ps.real * p.real, -ps.real * p.imag, -ps.real]
    constraints.push [0.0, 0.0, 0.0, p.real, p.imag, 1.0,
                      -ps.imag * p.real, -ps.imag * p.imag, -ps.imag]
  end
  Matrix[*constraints].svd[2].row(8).reshape 3, 3
end
CORNERS = 0.3
W, H = ARGV[1].to_i, ARGV[2].to_i
W2, H2 = 0.5 * (W - 1), 0.5 * (H - 1)
N = W * H
SIZE = 21
GRID = 7
BOUNDARY = 19
SIZE2 = SIZE.div 2
f1, f2 = *(0 ... 2).collect do |k|
  finalise(SIZE,SIZE) do |i,j|
    a = Math::PI / 4.0 * k
    x = Math.cos(a) * (i - SIZE2) - Math.sin(a) * (j - SIZE2)
    y = Math.sin(a) * (i - SIZE2) + Math.cos(a) * (j - SIZE2)
    x * y * Math.exp( -(x**2+y**2) / 5.0 ** 2)
  end.normalise -1.0 / SIZE ** 2 .. 1.0 / SIZE ** 2
end
input = AVInput.new ARGV.first
width, height = input.width, input.height
coords = finalise(width, height) { |i,j| i - width / 2 + Complex::I * (j - height / 2) }
pattern = Sequence[*(([1] + [0] * (W - 2) + [1] + [0] * (H - 2)) * 2)]
o = Vector[]
d = Matrix[]
X11Display.show do
  img = input.read_ubytergb
  grey = img.to_ubyte
  corner_image = grey.convolve f1 + f2 * Complex::I
  abs2 = corner_image.abs2
  corners = abs2.nms CORNERS * abs2.max
  otsu = grey.otsu
  edges = otsu.dilate(GRID).and otsu.not.dilate(GRID)
  components = edges.components
  grid = components.have N, corners
  result = img
  if grid
    centre = coords.mask(grid.and(corners)).sum / N.to_f
    boundary = grid.not.components.largest.dilate BOUNDARY
    outer = grid.and(boundary).and corners
    vectors = (coords.mask(outer) - centre).to_a.sort_by { |c| c.arg }
    if vectors.size == pattern.size
      mask = Sequence[*(vectors * 2)].shift(vectors.size / 2).abs.nms(0.0)
      mask[0] = mask[mask.size-1] = false
      conv = lazy(mask.size) { |i| i }.mask(mask.to_ubyte.convolve(pattern.flip(0)).eq(4))
      if conv.size > 0
        offset = conv[0] - (pattern.size - 1) / 2
        m = Sequence[Complex(-W2, -H2), Complex(W2, -H2),
                     Complex(W2, H2), Complex(-W2, H2)]
        rect = Sequence[*vectors].shift(-offset)[0 ... vectors.size].mask(pattern) + centre
        h = homography m, rect
        v = h.inv * Vector[coords.real, coords.imag, 1.0]
        points = coords.mask(grid.and(corners)) + Complex(width/2, height/2)
        sorted = (0 ... N).zip((v[0] / v[2]).warp(points.real, points.imag).to_a,
                               (v[1] / v[2]).warp(points.real, points.imag).to_a).
          sort_by { |a,b,c| [(c - H2).round,(b - W2).round] }.collect { |a,b,c| a }
        m = finalise(W, H) { |i,j| i - W2 + (j - H2) * Complex::I }
        h = homography(m, sorted.collect { |j| points[j] - Complex(width/2, height/2)})
        o = Vector[*(o.to_a + [-h[2, 0] * h[2, 1], h[2, 1] ** 2 - h[2, 0] ** 2])]
        d = Matrix[*(d.to_a + [[h[0, 0] * h[0, 1] + h[1, 0] * h[1, 1]],
                   [h[0, 0] ** 2 + h[1, 0] ** 2 - h[0, 1] ** 2 - h[1, 1] ** 2]])]
        fs = 1.0 / ((d.t * d).inv * d.t * o)[0]
        if fs > 0
          f = Math.sqrt fs
          # a = Matrix[[f, 0.0, 0.0], [0.0, f, 0.0], [0.0, 0.0, 1.0]]
          # r1, r2, t = *proc { |r| (0 .. 2).collect { |i| r.column i } }.call(a.inv * h)
          # s = (t[2] >= 0 ? 2.0 : -2.0) / (r1.norm + r2.norm)
          # q = Matrix[(r1 * s).to_a, (r2 * s).to_a, (r1 * s).x(r2 * s).to_a].t
          # r = proc { |u,l,vt| u * vt }.call *q.svd
          v = h.inv * Vector[coords.real, coords.imag, 1.0]
          result = (v[0] / v[2]).between?(-W2, W2).and((v[1] / v[2]).between?(-H2, H2)).
            conditional img * RGB(0, 1, 0), img
          gc = Magick::Draw.new
          gc.fill_color('red').stroke('red').stroke_width(1).pointsize 16
          for i in 0 ... N
            j = sorted[i]
            gc.circle points[j].real, points[j].imag, points[j].real + 2, points[j].imag
            gc.text points[j].real, points[j].imag, "#{i+1}"
          end
          gc.fill_color('black').stroke 'black'
          gc.text 30, 30, "f/ds = #{f}"
          result = result.to_ubytergb.to_magick
          gc.draw result
          result = result.to_ubytergb
        end
      end
    end
  end
  result
end

