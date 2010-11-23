require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require 'lib/flare/tools'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

$hoe = Hoe.spec 'flare-tools' do
  self.version = FlareTools::VERSION
  self.developer 'kgws', 'dev.kgws@gmail.com'
  self.post_install_message = 'PostInstall.txt'
  self.url = 'http://github.com/kgws/flare-tools'
  self.summary = "Management Tools for Flare"
  self.description = "Flare is a collection of tools for management."
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => [:spec, :features]
