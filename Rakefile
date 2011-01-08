#!/usr/bin/env ruby
require 'date'
require 'rake/clean'
require 'rake/packagetask'
require 'rbconfig'
require 'yard'

PKG_NAME = 'hornetseye-doc'
PKG_VERSION = '0.1.0'
RB_FILES = FileList[ 'samples/**/*.rb' ]
IMG_FILES = FileList[ 'docs/images/*' ]
PKG_FILES = [ 'Rakefile', 'README.md', 'COPYING', '.document' ] +
            RB_FILES + IMG_FILES
MODS = %w{malloc multiarray hornetseye-alsa hornetseye-dc1394 hornetseye-ffmpeg
          hornetseye-frame hornetseye-narray hornetseye-opencv hornetseye-openexr
          hornetseye-qt4 hornetseye-rmagick hornetseye-v4l hornetseye-v4l2
          hornetseye-xorg}

$SITELIBDIR = RbConfig::CONFIG[ 'sitelibdir' ]

task :default => :yard

YARD::Rake::YardocTask.new :yard do |y|
  y.files << RB_FILES
end

MODS.each do |f|
  task :yard => "docs/#{f}"
  file "docs/#{f}" => "../#{f}" do |t|
    FileUtils.ln_s "../../#{f}", t.name
  end
end

IMG_FILES.each do |f|
  task :yard => "doc/#{f[ 5 .. -1 ]}"
  file "doc/#{f[ 5 .. -1 ]}" => f do |t|
    FileUtils.mkdir_p 'doc/images'
    FileUtils.cp f, t.name
  end
end

Rake::PackageTask.new PKG_NAME, PKG_VERSION do |p|
  p.need_tar = true
  p.package_files = PKG_FILES
end

CLOBBER.include 'doc', '.yardoc', MODS.collect { |m| "docs/#{m}" }

