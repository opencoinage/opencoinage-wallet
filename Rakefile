#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
require 'rubygems'
begin
  require 'rakefile' # http://github.com/bendiken/rakefile
rescue LoadError => e
end
require 'opencoinage/wallet'

VERSION = OpenCoinage::Wallet::VERSION.to_s

namespace :build do
  desc "Builds the opencoinage-wallet-#{File.read('VERSION').chomp}.gem file"
  task :gem do
    sh "gem build .gemspec"
  end

  desc "Builds the Mac OS X application bundle"
  task :mac do
    sh "rm -rf pkg/OpenCoinage.app"
    sh "cp -Rp res/OpenCoinage.app pkg/"
    sh "sed -i '' s/0.0.0/#{VERSION}/ pkg/OpenCoinage.app/Contents/Info.plist"
    sh "cp -Rp bin pkg/OpenCoinage.app/Contents/MacOS/"
    sh "cp -Rp lib pkg/OpenCoinage.app/Contents/MacOS/"
    sh "chmod 755 pkg/OpenCoinage.app"
  end
end

task :build => %w(build:mac)
