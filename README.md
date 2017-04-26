HornetsEye - Computer Vision for the Robotic Age
================================================

**HornetsEye** is a **real-time computer vision library** for the **Ruby programming language**. HornetsEye is maybe the first free software project providing a **solid platform for implementing real-time computer vision software** in a scripting language. The platform potentially could be used in **industrial automation**, **robotic applications**, and **human computer interfaces**.

HornetsEye is free software. Developers and users are given the full freedom to study the source code, run, modify, and redistribute the software as they wish.

![Screenshot of video player below](images/sintel.jpg)

    require 'rubygems'
    require 'hornetseye_ffmpeg'
    require 'hornetseye_xorg'
    include Hornetseye
    input = AVInput.new 'http://peach.themazzone.com/durian/movies/sintel-1024-surround.mp4'
    w, h = (input.width * input.aspect_ratio).to_i, input.height
    X11Display.show(w, h, :frame_rate => input.frame_rate) { input.read }

Demo Videos
-----------

<table>
  <tr>
    <td><p><span class="center"><object data="http://www.youtube.com/v/5xJa2ytsE7I" height="344" type="application/x-shockwave-flash" width="508"><param name="movie" value="http://www.youtube.com/v/5xJa2ytsE7I" /></object></span></p></td>
    <td><p><span class="center"><object data="http://www.youtube.com/v/wNFr7RNWeCs" height="344" type="application/x-shockwave-flash" width="508"><param name="movie" value="http://www.youtube.com/v/wNFr7RNWeCs" /></object></span></p></td>
  </tr>
</table>

Example Programs
----------------

### Basic I/O

* {file:docs/IRB.md Interactive Ruby session}
* {file:docs/XOrg.md Displaying images}
* {file:docs/RMagick.md Loading and saving image files}
* {file:docs/FFMpeg.md Reading and writing video files}
* {file:docs/Camera.md Capturing frames from a camera}
* {file:docs/ALSA.md Recording and playing audio}

### Manipulating images

* {file:docs/Pixel.md Element-wise operations}
* {file:docs/Warps.md Histograms and warps}
* {file:docs/Filters.md Filters}
* {file:docs/Extraction.md Feature extraction}
* {file:docs/Applications.md Applications}
* {file:docs/3DVision.md 3D Vision}

Copyright
---------

Copyright © 2006, .., 2017 Jan Wedekind, Eastleigh, United Kingdom. See {file:docs/License.md License} for details.

See also
--------

* {file:docs/Features.md Features}
* {file:docs/License.md License}
* {file:docs/Installation.md Installation}
* {file:docs/FAQ.md FAQ}
* {file:docs/Contact.md Contact}
* {file:docs/Publications.md Publications}
* {file:docs/Credits.md Credits}

External Links
--------------

* [Try Ruby](http://tryruby.org/)
* [RubyForge page](http://rubyforge.org/projects/hornetseye/)

