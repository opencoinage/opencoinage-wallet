module OpenCoinage::Wallet::CLI
  ##
  # The base class for command-line interface (CLI) commands.
  class Command
    ##
    # Initializes this command.
    #
    # @param  [Hash{Symbol => Object}] options
    #   Any command-line options for this command.
    # @option options [Boolean] :verbose (nil)
    #   Whether verbose output is enabled.
    # @option options [Boolean] :debug   (nil)
    #   Whether debug output is enabled.
    def initialize(options = {})
      @options = options.dup
    end

    ##
    # Command-line options for this command.
    #
    # @return [Hash]
    attr_reader :options

    ##
    # Returns `true` if verbose output has been enabled.
    #
    # @return [Boolean]
    def verbose?
      !!options[:verbose]
    end

    ##
    # Returns `true` if debug output has been enabled.
    #
    # @return [Boolean]
    def debug?
      !!options[:debug]
    end
  end # Command
end # OpenCoinage::Wallet::CLI
