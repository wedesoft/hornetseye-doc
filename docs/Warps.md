Histograms and Warps
====================

Histogram Equalisation
----------------------

![Histogram equalisation](images/equalised.jpg)

Using integral arrays and element-wise lookup (map) one can implement histogram equalisation.

    require 'rubygems'
    require 'hornetseye_openexr'
    require 'hornetseye_xorg'
    include Hornetseye
    class Node
      def average
        sum / size
      end
      def equalise( n = 4096, c_max = 255 )
        if typecode < RGB_
          result = array_type.new
          max_average = [ r, g, b ].collect { |c| c.average }.max
          result.r, result.g, result.b = *[ r, g, b ].collect do |c|
            c.equalise n, c_max * c.average / max_average
          end
          result
        else
          quantised = normalise( 0 .. n - 1 ).to_int
          quantised.lut quantised.histogram( n ).integral.normalise( 0 .. c_max )
        end
      end
    end
    img = MultiArray.load_sfloatrgb 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/bmw.exr'
    img.equalise.show

Otsu Thresholding
-----------------

![Otsu thresholding](images/otsu.png)

The Otsu algorithm is an algorithm for automatic thresholding. The algorithm assumes that the image to be thresholded contains two classes of pixels and then chooses the threshold which minimizes the intra-class variance of the two classes defined by the resulting binary image. Otsu has reformulated this problem so that it can be computed efficiently with histograms.

    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    class Node
      def otsu( hist_size = 256 )
        h = histogram hist_size
        idx = lazy( hist_size ) { |i| i }
        w1 = h.integral
        w2 = w1[ w1.size - 1 ] - w1
        s1 = ( h * idx ).integral
        s2 = sum - s1
        m1 = w1 > 0
        u1 = ( s1.mask( m1 ).to_sfloat / w1.mask( m1 ) ).unmask m1
        m2 = w2 > 0
        u2 = ( s2.mask( m2 ).to_sfloat / w2.mask( m2 ) ).unmask m2
        between_variance = ( u1 - u2 ) ** 2 * w1 * w2
        max_between_variance = between_variance.max
        self > idx.mask( between_variance >= max_between_variance )[0]
      end
    end
    img = MultiArray.load_ubyte 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/lena.jpg'
    ( img.otsu.to_ubyte * 255 ).show

Compute Average
---------------

![Average](images/average.jpg)

This example shows how to compute the average of a series of frames. You can use a program like this to reduce noise by averaging a large number of frames.

    require 'rubygems'
    require 'hornetseye_v4l2'
    require 'hornetseye_xorg'
    include Hornetseye
    input = V4L2Input.new
    average = nil
    c = 0
    img = X11Display.show do
      img = input.read.to_ubytergb
      average = average.nil? ? img.to_uintrgb : average + img
      c += 1
      average / c
    end
    img.show

Bounding Box
------------

![Bounding box](images/bbox.jpg)

A mask which specifies pixel locations of interest is created. The mask then is applied to an x-ramp and a y-ramp to find the bounding box. The area outside the bounding box finally is highlighted.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubyte 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/viking.jpg'
    mask = img <= 50
    x = lazy( *img.shape ) { |i,j| i }
    y = lazy( *img.shape ) { |i,j| j }
    box = [ x.mask( mask ).range, y.mask( mask ).range ]
    img[ *box ] = img[ *box ] / 2 + 0x7F
    img.show

Warps
-----

![Image Warp](images/polar.jpg)

Images can be warped using vector fields. The warp vectors are indicating the location of the source pixel. The example warps an equirectangular projection to an azimuthal projection.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubytergb 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/world.jpg'
    w, h = *img.shape
    c = 0.5 * h
    x, y = lazy( h, h ) { |i,j| i - c }, lazy( h, h ) { |i,j| j - c }
    angle = ( Math.atan2( x, y ) / Math::PI + 1 ) * w / 2
    radius = Math.hypot( x, y )
    img.warp( angle.to_int, radius.to_int ).show

Colour Circle
-------------

![Colour circle](images/ccircle.jpg)

You can create images yourself.  In this example an image with different colours is generated and the result is mapped to a circle using a vector-field.

    require 'rubygems'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.ubytergb( 360, 128 ).fill!
    x, y = lazy( *img.shape ) { |i,j| i }, lazy( *img.shape ) { |i,j| j }
    img.r = ( ( ( x - 180 ).abs -  60 ).clip( 0..60 ) * y ).normalise
    img.g = ( ( 120 - ( x - 120 ).abs ).clip( 0..60 ) * y ).normalise
    img.b = ( ( 120 - ( x - 240 ).abs ).clip( 0..60 ) * y ).normalise
    w, h = 256, 256
    x, y = lazy( w, h ) { |i,j| i - 127.5 }, lazy( w, h ) { |i,j| j - 127.5 }
    angle = Math.atan2( y, x ) * 180.0 / Math::PI + 179.5
    radius = Math.hypot( y, x )
    img.warp( angle.to_int, radius.to_int ).show

See Also
--------

* {Hornetseye::Operations#lut}
* {Hornetseye::Operations#histogram}
* {Hornetseye::Operations#integral}
* {Hornetseye::Operations#mask}
* {Hornetseye::Operations#warp}

External Links
--------------

* [Histogram equalisation](http://en.wikipedia.org/wiki/Histogram_Equalization)

