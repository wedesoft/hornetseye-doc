Loading and Saving Image Files
===============================

**HornetsEye** makes use of [RMagick](http://rmagick.rubyforge.org/). RMagick supports virtually any image file format.

Read Grey Scale Image
---------------------

![Grey scale image](images/grey.png)

This example shows how to load and display a grey scale image. If the image is a colour image, it is converted to grey scale on-the-fly.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubyte 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/grey.png'
    img.show

Read Colour Image
-----------------

![Colour image](images/colour.png)

This example shows how to load and display a colour image. If the image is a grey scale image, the different colour channels will have the same values.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubytergb 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/colour.png'
    img.show

See Also
--------

* {Hornetseye::MultiArray.load_ubyte}
* {Hornetseye::MultiArray.load_ubytergb}
* {Hornetseye::Node#save_ubyte}
* {Hornetseye::Node#save_ubytergb}

External Links
--------------

* [RMagick](http://rmagick.rubyforge.org/)

