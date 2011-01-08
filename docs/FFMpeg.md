Reading and Writing Video Files
===============================

Read Video Files
----------------

![Read video files](images/sintel.jpg)

The class {Hornetseye::AVInput} allows you to capture frames from videos using the [FFMpeg library](http://www.ffmpeg.org/). The example program shows how to display a video.

    require 'rubygems'
    require 'hornetseye_ffmpeg'
    require 'hornetseye_xorg'
    include Hornetseye
    input = AVInput.new 'http://ftp.halifax.rwth-aachen.de/blender/movies/sintel-1024-stereo.mp4'
    w, h = ( input.width * input.aspect_ratio ).to_i, input.height
    X11Display.show( w, h, :frame_rate => input.frame_rate ) { input.read }

See also
--------

* {Hornetseye::AVInput}
* {Hornetseye::AVOutput}

External Links
--------------

* [FFMpeg audio/video codec library](http://www.ffmpeg.org/)
* [Sintel, the Durian Open Movie Project](http://sintel.org/)

