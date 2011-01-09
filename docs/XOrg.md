Displaying Images
=================

XImage display
--------------

![XImage display](images/colour.png)

Display using {Hornetseye::XImageOutput} should work any X.Org true colour display. This display mode is used by default.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubytergb 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/colour.png'
    img.show

OpenGL display
--------------

One can use {Hornetseye::OpenGLOutput} to use OpenGL hardware acceleration (*glDrawPixels* to be more exact). OpenGL also works on displays other than true colour. However OpenGL is not always supported and it can interfere with compositing window managers.

    require 'rubygems'
    require 'hornetseye_rmagick'
    require 'hornetseye_xorg'
    include Hornetseye
    img = MultiArray.load_ubytergb 'http://www.wedesoft.demon.co.uk/hornetseye-api/images/colour.png'
    img.show :output => OpenGLOutput

XVideo display
--------------

![XVideo display](images/xvideo.png)

{Hornetseye::XVideoOutput} provides hardware accelerated video display. Note that XVideo is not supported by some graphic cards. Usually it is not possible to have more than one window using XVideo display at the same time. XVideo is usually used to display videos.

    require 'rubygems'
    require 'hornetseye_ffmpeg'
    require 'hornetseye_xorg'
    include Hornetseye
    input = AVInput.new 'http://anon.nasa-global.edgesuite.net/anon.nasa-global/NASAHD/sts-116/STS-116_LaunchHD_480p.wmv'
    X11Display.show :frame_rate => input.frame_rate, :output => XVideoOutput do
      input.read
    end

See Also
--------

* {Hornetseye::XImageOutput}
* {Hornetseye::OpenGLOutput}
* {Hornetseye::XVideoOutput}

External Links
--------------

* [X.Org](http://www.x.org/)
* [Nasa High Definition videos](http://www.nasa.gov/multimedia/hd/)

