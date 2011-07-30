Reading and Writing Video Files
===============================

![Read video files](images/sintel.jpg)

Read Video Data
----------------

The class {Hornetseye::AVInput} allows you to capture frames from videos using the [FFMpeg library](http://www.ffmpeg.org/). The example program shows how to display a video.

    require 'rubygems'
    require 'hornetseye_ffmpeg'
    require 'hornetseye_xorg'
    include Hornetseye
    input = AVInput.new 'http://mirrorblender.top-ix.org/movies/sintel-1024-surround.mp4'
    w, h = ( input.width * input.aspect_ratio ).to_i, input.height
    X11Display.show( w, h, :frame_rate => input.frame_rate ) { input.read }

Read Video and Audio Data
-------------------------

It is also possible to retrieve audio frames if the video file offers an audio stream. The audio frames are two-dimensional arrays with the first dimension indicating the number of audio channels (*i.e.* 1=mono, 2=stereo). The following example plays synchronised video and audio.

    require 'rubygems'
    require 'hornetseye_ffmpeg'
    require 'hornetseye_xorg'
    require 'hornetseye_alsa'
    include Hornetseye
    input = AVInput.new 'http://mirrorblender.top-ix.org/movies/sintel-1024-surround.mp4'
    w, h = ( input.width * input.aspect_ratio ).to_i, input.height
    alsa = AlsaOutput.new 'default:0', input.sample_rate, input.channels
    audio_frame = input.read_audio
    X11Display.show( w, h, :title => 'FFMpeg', :output => XVideoOutput ) do |display|
      video_frame = input.read_video
      while alsa.avail >= audio_frame.shape[1]
        alsa.write audio_frame
        audio_frame = input.read_audio
      end
      t = input.audio_pos - (alsa.delay + audio_frame.shape[1]).quo( alsa.rate )
      display.event_loop [ input.video_pos - t, 0 ].max
      video_frame
    end

See also
--------

* {Hornetseye::AVInput}
* {Hornetseye::AVOutput}

External Links
--------------

* [FFMpeg audio/video codec library](http://www.ffmpeg.org/)
* [Sintel, the Durian Open Movie Project](http://sintel.org/)

