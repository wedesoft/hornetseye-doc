Read Colour Image
=====================

![Colour image](images/colour.png)

This example shows how to load and display a colour image.  HornetsEye makes use of [RMagick](http://rmagick.rubyforge.org/). RMagick supports virtually any image file format. If the image is a greyscale image, the different colour channels will have the same values.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubytergb 'colour.png'
    img.show

