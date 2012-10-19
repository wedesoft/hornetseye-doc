Recording and playing audio
===========================

Playing sounds
--------------

The example opens the first sound device and plays a 400 Hz tone for the duration of 3 seconds. The last command waits for the audio output to finish.

    require 'rubygems'
    require 'hornetseye_alsa'
    include Hornetseye
    RATE = 44_100
    CHANNELS = 2
    LEN = 110 # Approx. 400 Hz
    output = AlsaOutput.new 'default', RATE, CHANNELS
    wave = lazy( CHANNELS, LEN ) { |j,i| Math.sin( 2 * Math::PI * i / LEN ) * 0x7FFF }.to_sint
    ( 3 * RATE / LEN ).times { output.write wave }
    output.drain

Recording sounds
----------------

It is also possible to record sounds. Note that the microphone of a USB webcam usually is the second sound device (*i.e.* **'default:1'**). The example below records 3 seconds of audio and then plays it back.

    require 'rubygems'
    require 'hornetseye_alsa'
    include Hornetseye
    RATE = 44_100
    CHANNELS = 2
    input = AlsaInput.new 'default', RATE, CHANNELS
    data = input.read RATE * 3
    output = AlsaOutput.new 'default', RATE, CHANNELS
    output.write data
    output.drain

See Also
--------

* {Hornetseye::AlsaInput}
* {Hornetseye::AlsaOutput}

External Links
--------------

* [ALSA project](http://www.alsa-project.org/)

