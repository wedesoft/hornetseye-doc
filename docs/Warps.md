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

See Also
--------

* {Hornetseye::Operations#integral}

External Links
--------------

* [Histogram equalisation](http://en.wikipedia.org/wiki/Histogram_Equalization)

