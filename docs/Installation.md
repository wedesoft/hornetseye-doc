Installation
============

*HornetsEye* consists of several packages. Most of them rely on other free software since HornetsEye does not reinvent the wheel.

GNU/Linux
---------

First you need to install the build tools and Ruby 1.8 (or Ruby 1.9) with development headers. Under [Kubuntu](http://www.kubuntu.org/) or [Debian](http://www.debian.org/) you can do this using the following command:

    sudo aptitude install build-essential ruby1.8 ruby1.8-dev irb1.8

### malloc

**malloc** is part of the basis of *HornetsEye*. The following command will download and install this Ruby extension:

    sudo gem install malloc

Alternatively you can build the Ruby extension from source as follows:

    rake
    sudo rake install

### multiarray

**multiarray** provides the array operations of *HornetsEye*. The following command will download and install this Ruby extension:

    sudo gem install multiarray

Alternatively you can build the Ruby extension from source as follows:

    rake
    sudo rake install

### hornetseye-alsa

**hornetseye-alsa** provides an interface for playing audio data using the Advanced Linux Sound Architecture (ALSA). This Ruby extension requires the ALSA library. You can install it like this:

    sudo aptitude install libasound2-dev

To install the Ruby extension, use the following command:

    sudo gem install hornetseye-alsa

Alternatively you can build the Ruby extension from source as follows:

    rake
    sudo rake install

### hornetseye-dc1394

**hornetseye-dc1394** allows capturing video frames using a DC1394-compatible firewire camera. This Ruby extension requires the DC1394 development headers. You can install them as follows:

    sudo aptitude install libdc1394-22-dev

To install the Ruby extension, use the following command:

    sudo gem install hornetseye-dc1394

Alternatively you can build the Ruby extension from source as follows:

    rake
    sudo rake install

### hornetseye-ffmpeg

### hornetseye-frame

### hornetseye-narray

### hornetseye-opencv

### hornetseye-openexr

### hornetseye-qt4

### hornetseye-rmagick

### hornetseye-v4l

### hornetseye-v4l2

### hornetseye-xorg

Microsoft Windows
-----------------

HornetsEye for Microsoft Windows is not supported at the moment.

Mac OS
------

**malloc** and **multiarray** where tested successfully under Mac OS. However there is no active support for MaC OS at the moment.

External Links
--------------

* Ruby Gems
    * [malloc](http://rubygems.org/gems/malloc/)
    * [multiarray](http://rubygems.org/gems/multiarray/)
    * [hornetseye-alsa](http://rubygems.org/gems/hornetseye-alsa/)
    * [hornetseye-dc1394](http://rubygems.org/gems/hornetseye-dc1394/)
    * [hornetseye-ffmpeg](http://rubygems.org/gems/hornetseye-ffmpeg/)
    * [hornetseye-frame](http://rubygems.org/gems/hornetseye-frame/)
    * [hornetseye-narray](http://rubygems.org/gems/hornetseye-narray/)
    * [hornetseye-opencv](http://rubygems.org/gems/hornetseye-opencv/)
    * [hornetseye-openexr](http://rubygems.org/gems/hornetseye-openexr/)
    * [hornetseye-qt4](http://rubygems.org/gems/hornetseye-qt4/)
    * [hornetseye-rmagick](http://rubygems.org/gems/hornetseye-rmagick/)
    * [hornetseye-v4l](http://rubygems.org/gems/hornetseye-v4l/)
    * [hornetseye-v4l2](http://rubygems.org/gems/hornetseye-v4l2/)
    * [hornetseye-xorg](http://rubygems.org/gems/hornetseye-xorg/)

* Git repositories
    * [malloc](http://github.com/wedesoft/malloc/)
    * [multiarray](http://github.com/wedesoft/multiarray/)
    * [hornetseye-alsa](http://github.com/wedesoft/hornetseye-alsa/)
    * [hornetseye-dc1394](http://github.com/wedesoft/hornetseye-dc1394/)
    * [hornetseye-ffmpeg](http://github.com/wedesoft/hornetseye-ffmpeg/)
    * [hornetseye-frame](http://github.com/wedesoft/hornetseye-frame/)
    * [hornetseye-narray](http://github.com/wedesoft/hornetseye-narray/)
    * [hornetseye-opencv](http://github.com/wedesoft/hornetseye-opencv/)
    * [hornetseye-openexr](http://github.com/wedesoft/hornetseye-openexr/)
    * [hornetseye-qt4](http://github.com/wedesoft/hornetseye-qt4/)
    * [hornetseye-rmagick](http://github.com/wedesoft/hornetseye-rmagick/)
    * [hornetseye-v4l](http://github.com/wedesoft/hornetseye-v4l/)
    * [hornetseye-v4l2](http://github.com/wedesoft/hornetseye-v4l2/)
    * [hornetseye-xorg](http://github.com/wedesoft/hornetseye-xorg/)

