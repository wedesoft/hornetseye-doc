Feature Extraction
==================

Sobel Gradient Magnitude
------------------------

![Sobel gradient magnitude](images/sobelmag.png)

In the following example the sobel gradient magnitude is computed.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    class Node
      def sobel_mag
        Math.sqrt lazy { sobel( 0 ) ** 2 + sobel( 1 ) ** 2 }
      end
    end
    img = MultiArray.load_ubyte 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/grey.png'
    img.sobel_mag.normalise( 255 .. 0 ).show

Roberts Cross Edge Detector
---------------------------

![Roberts cross edge detector](images/roberts.png)

Roberts cross edge detector consists of two small filters. The image is correlated with both filters. The final edge image is computed by taking the sum of the two correlation results.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    class Node
      def roberts
        filter1 = MultiArray( SINT, 2, 2 )[ [ -1,  0 ], [ 0, 1 ] ]
        filter2 = MultiArray( SINT, 2, 2 )[ [  0, -1 ], [ 1, 0 ] ]
        finalise { convolve( filter1 ).abs + convolve( filter2 ).abs }
      end
    end
    img = MultiArray.load_ubyte 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/grey.png'
    img.roberts.normalise( 0xFF .. 0 ).show

Difference of Gaussian
----------------------

![Difference of Gaussian](images/dog.jpg)

The difference of Gaussian is simply the difference of two Gaussian filters of different size.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubytergb 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/colour.png'
    dog = img.gauss_blur( 1.5 ) - img.gauss_blur( 3.0 )
    dog.normalise.show

Laplacian of Gaussian
---------------------

Corner Strength by Yang et al.
------------------------------

Harris-Stephens Corner- and Edge-Detector
-----------------------------------------

Shi-Tomasi Corner-Detector
--------------------------

Feature Locations
-----------------

See Also
--------

External Links
--------------

* [Sobel operator](http://en.wikipedia.org/wiki/Sobel_operator)
* [Roberts cross edge detector](http://homepages.inf.ed.ac.uk/rbf/HIPR2/roberts.htm)
* [Difference of Gaussian](http://en.wikipedia.org/wiki/Difference_of_Gaussians)

