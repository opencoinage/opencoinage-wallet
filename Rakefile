#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
require 'rubygems'
begin
  require 'rakefile' # http://github.com/bendiken/rakefile
rescue LoadError => e
end
require 'opencoinage/wallet'

GEM_VERSION = OpenCoinage::Wallet::VERSION.to_s

desc "Unpacks all non-native gem dependencies into the tmp/lib/ directory"
task :unpack => 'tmp/lib'
file 'tmp/lib' do
  sh "mkdir -p tmp/lib"
  %w(addressable/uri rdf macaddr uuid opencoinage).each do |gem|
    unless (libpath = `gem which #{gem}`).empty?
      libpath = File.dirname(libpath.chomp)
      libpath = File.join(libpath, '..') if gem =~ /addressable/ # requires special handling
      libpath = File.expand_path(libpath)
      sh "cp -Rp #{libpath} tmp/"
    end
  end
end

namespace :build do
  desc "Builds the opencoinage-wallet-#{File.read('VERSION').chomp}.gem file"
  task :gem do
    sh "gem build .gemspec"
  end

  desc "Builds the Mac OS X application bundle"
  task :mac do
    sh "rm -rf pkg/OpenCoinage.app"
    sh "cp -Rp res/OpenCoinage.app pkg/"
    sh "sed -i '' s/0.0.0/#{GEM_VERSION}/ pkg/OpenCoinage.app/Contents/Info.plist"
    sh "cp -Rp bin pkg/OpenCoinage.app/Contents/MacOS/"
    sh "cp -Rp tmp/lib pkg/OpenCoinage.app/Contents/MacOS/" if File.exists?('tmp/lib')
    sh "cp -Rp lib pkg/OpenCoinage.app/Contents/MacOS/"
    sh "chmod 755 pkg/OpenCoinage.app"
  end
end

task :build => %w(build:mac)
