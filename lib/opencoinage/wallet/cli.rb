require 'optparse'

module OpenCoinage::Wallet
  ##
  # The command-line interface (CLI) wallet application.
  module CLI
    autoload :Command, 'opencoinage/wallet/cli/command'
  end # CLI
end # OpenCoinage::Wallet
