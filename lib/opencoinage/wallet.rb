require 'opencoinage' # @see http://rubygems.org/gems/opencoinage

begin
  require 'sqlite3'   # @see http://rubygems.org/gems/sqlite3-ruby
rescue LoadError
  abort "OpenCoinage requires the SQLite3/Ruby gem (hint: `gem install sqlite3-ruby')."
end

module OpenCoinage
  module Wallet
    autoload :CLI,     'opencoinage/wallet/cli'
    autoload :GUI,     'opencoinage/wallet/gui'
    autoload :VERSION, 'opencoinage/wallet/version'

    HOME = File.expand_path(ENV['OPENCOINAGE_HOME'] || '~/.opencoinage')
  end
end
