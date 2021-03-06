# -*- coding: utf-8; -*-
# Author::    kgws  (http://d.hatena.ne.jp/kgws/)
# Copyright:: Copyright (c) 2010- kgws.
# License::   This program is licenced under the same licence as kgws.
#
# $--- flare-tools - [ by Ruby ] $
# vim: foldmethod=marker tabstop=2 shiftwidth=2
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'optparse'
require 'socket'
require 'timeout'
require 'resolv'
require 'tools/core'
require 'tools/logger'

module FlareTools
  VERSION = '0.1.4'
end
