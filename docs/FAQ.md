Frequently Asked Questions
==========================

Compilation FAQ
---------------

### Problems with detection of OpenGL/GL/GLU (GNU+Linux)

Probably your OpenGL installation is not complete or broken. Try to download and compile a small OpenGL example program. Usually the error-message is conclusive. For example download [cube.c](http://www.sgi.com/products/software/opengl/examples/glut/examples/source/cube.c) and try to compile it like this:

    gcc -o cube cube.c -lGL -lGLU -lglut

Also see [http://ubuntuforums.org/showthread.php?p=2362003#post2362003](http://ubuntuforums.org/showthread.php?p=2362003#post2362003).

Execution FAQ
-------------

### Tips on using Interactive Ruby Bash

Install Wirble for Ruby and RubyGems. Then create an *.irbrc* file with the following content

    require 'rubygems'
    require 'irb/completion'
    require 'wirble'
    Wirble.init( { :skip_prompt => true } )
    Wirble.colorize

When running *irb* you will now have command line completion, output highlighting, and command line history.

You can download *wirble* at [https://github.com/wedesoft/wirble](https://github.com/wedesoft/wirble).

### Methods for adjusting margins not defined

The error occurs when loading user interface files generated with rbuic4.

    undefined method `setLeftMargin' for
    #<Qt::GridLayout:0xb530d904 objectName="qgridLayout">

The reason is that rbuic4 generates method calls to methods which are not supported by the version of Qt4-QtRuby. The easiest solution is to remove all calls to setLeftMargin, setRightMargin, setTopMargin, and setBottomMargin in the ui_\*.rb files after they have been generated. However the best solution is to compile a newer version of Qt4-QtRuby or to upgrade the distribution.

### What is the meaning of the HornetsEye logo?

The logo was created using GIMP and it shows a honeycomb structure as you would find on an insect's compound eye. A hornet is capable of navigating and detecting objects with the limited resolution of its compound eyes.  Incidentially you will see a similar structure if you don't correct TEM images for the fiber-optical coupling between the scintillator and the digital camera.

### Does HornetsEye have security or reliability issues?

You should read this if you intend to use HornetsEye in a security critical application.

* The GNU C compiler API of HornetsEye allows pointer manipulation and unrestricted memory access. This could be fixed by making use of Ruby's tainting mechanism.
* The range checks for the index manipulations in histograms, warps (except clipped warps), maps, and unmasking are optional (opt-out). Omitting this checks allows for high performance.

Furthermore HornetsEye uses native datatypes which are subject to underflow and overflow. Omitting this checks allows for high performance. However this can lead to numerical errors.

### Problem with IRB completion and Qt4-QtRuby

When using Qt4-QtRuby, IRB completion may abort with the following bug:

    /usr/local/lib/site_ruby/1.8/Qt/qtruby4.rb:2899:in `name': wrong number of arguments (0 for 1) (ArgumentError)

You can solve the problem by adding two checks in the file where the error occurs

    loop do
      break if klass.method( :name ).arity > 0
      break unless klass.name
      classid = Qt::Internal::find_pclassid(klass.name)
      break if classid > 0

### Problem with accessing IIDC/DCAM firewire camera (GNU+Linux)

If the IIDC/DCAM-compatible firewire camera does not work, this can be for several reasons.

First of all the modules need to be loaded. You can load the firewire modules as follows

    sudo modprobe raw1394
    sudo modprobe video1394

It may also be necessary to allow read/write-access to the devices

    sudo chmod a+rw /dev/raw1394
    sudo chmod a+rw /dev/video1394-0

If the device name is '/dev/video1394-0' instead of '/dev/video1394/0', you can create a shortcut for convencience

    sudo mkdir -p /dev/video1394
    sudo ln -s /dev/video1394-0 /dev/video1394/0

### Problems with using RMagick

The following error occurs when using RMagick under (K)ubuntu 10.04

    This installation of RMagick was configured with ImageMagick 6.5.5 but ImageMagick 6.5.7-8 is in use. (RuntimeError)

This is a problem with the RMagick package. See URLs below for bug report and fixes.

Also see

* [https://bugs.launchpad.net/ubuntu/+source/librmagick-ruby/+bug/518122](https://bugs.launchpad.net/ubuntu/+source/librmagick-ruby/+bug/518122)
* [https://bugs.launchpad.net/ubuntu/+source/librmagick-ruby/+bug/518122/comments/17](https://bugs.launchpad.net/ubuntu/+source/librmagick-ruby/+bug/518122/comments/17)
* [http://rubyforge.org/tracker/index.php?func=detail&aid=23229&group_id=2714&atid=10404](http://rubyforge.org/tracker/index.php?func=detail&aid=23229&group_id=2714&atid=10404)

License FAQ
-----------

### Why are you using the GPL license?

Here are some reasons to use the GPL

* Other software developers and companies will only help to grow this project if they see their valuable contributions protected by a free software license.
* Industrial partners need a reliable promise that vendor lock-in will not become an issue in the future.
* There should not be an incentive to fork the project merely for economic gain.
* HornetsEye must be released under GPL because the software builds on top of other software packages released under GPL.
* All participating users and developers should have the possibility to innovate.

I.e. if you decide to distribute this software, you have to grant your users the same rights which were given to you.

### How can I be competitive without proprietary software?

If you develop software, you have a competitive advantage if you don't have to depend on proprietary software of third parties. You can make use of the large pool of existing software which is developed by people who share. If you develop hardware, you can offer customers unlimited freedom in using your device and doing innovation in the field.

For a detailed discussion about enabling technologies and business differentiation in the context of free software I recommend to read Ron Goldman's and Dick Gabriel's book [Innovation Happens Elsewhere](http://dreamsongs.com/IHE/IHE.html).

If you are developing distinguishing software to be used solely within your company (i.e. you are not distributing the software), you can choose to keep your work (source-code as well as binaries) for yourself.

### Where can I find more information about free software development?

Here is a small collection of links with further information about free software development:

* [The GPL license](http://www.gnu.org/licenses/gpl.html)
* [GPL frequently asked questions](http://www.gnu.org/licenses/gpl-faq.html)
* [Video of open source panel discussion at WSIS](http://video.google.com/videoplay?docid=-694927630239078625)
* [Video of lecture by Eben Moglen on intellectual property law](http://video.google.co.uk/videoplay?docid=6345039926759549406)
* Bruce Perens article ["The Emerging Economic Paradigm of Open Source"](http://perens.com/works/articles/Economic.html)

