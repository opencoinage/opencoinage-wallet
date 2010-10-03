begin
  require 'opencoinage' # @see http://rubygems.org/gems/opencoinage
rescue LoadError
  abort "OpenCoinage Wallet requires the OpenCoinage gem (hint: `gem install opencoinage')."
end

begin
  require 'sqlite3'     # @see http://rubygems.org/gems/sqlite3-ruby
rescue LoadError
  abort "OpenCoinage Wallet requires the SQLite3/Ruby gem (hint: `gem install sqlite3-ruby')."
end

module OpenCoinage
  module Wallet
    autoload :Database, 'opencoinage/wallet/database'
    autoload :CLI,      'opencoinage/wallet/cli'
    autoload :GUI,      'opencoinage/wallet/gui'
    autoload :VERSION,  'opencoinage/wallet/version'

    HOME = File.expand_path(ENV['OPENCOINAGE_HOME'] || '~/.opencoinage')

    CURRENCIES = [
      {
        :issuer => 'OpenCoinage.org',
        :asset  => 'cows',
        :unit   => 'cow',
      },
    ]

    ##
    # Returns the list of known currencies.
    #
    # @return [Array<Currency>]
    def self.currencies
      CURRENCIES # FIXME
    end
  end # Wallet
end # OpenCoinage
