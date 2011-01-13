Filters
=======

Sobel Operator
--------------

### X-Gradient

![Sobel x-gradient](images/sobelx.png)

This is an example on how to compute the Sobel x-gradient. A correlation of the input image with the following separable filter is performed.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubyte 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/grey.png'
    img.sobel( 0 ).normalise.show

### Y-Gradient

![Sobel y-gradient](images/sobely.png)

This is an example on how to compute the Sobel y-gradient. A correlation of the input image with the following separable filter is performed.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubyte 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/grey.png'
    img.sobel( 1 ).normalise.show

Gaussian Blur
-------------

![Gaussian blur](images/gaussblur.jpg)

This is an example on how to apply a Gauss blur filter.  The filter can be applied to colour images as well.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubytergb 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/lena.jpg'
    img.gauss_blur( 3.0 ).show

Van Cittert Deconvolution
-------------------------

Wiener Filter
-------------

Gauss Gradient
--------------

### X-Gradient

### Y-Gradient

Custom Filters
--------------

Connected Components Labeling
-----------------------------

See Also
--------

* {Hornetseye::Operations#convolve}
* {Hornetseye::Operations#sobel}

External Links
--------------

* [Sobel operator](http://en.wikipedia.org/wiki/Sobel_operator)

