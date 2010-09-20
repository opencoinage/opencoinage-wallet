module OpenCoinage::Wallet
  module GUI
    ##
    # The currency tokens model.
    class TokenModel < GridModel
      HEADERS = [tr("Amount"), tr("Expires"), tr("ID")]
      COLUMNS = [:amount, :expires, :id]

      ##
      # The list of tokens.
      #
      # @return [Array<Token>]
      attr_reader :tokens

      ##
      # Initializes the token model.
      #
      # @param  [Array<Token>] tokens
      # @yield  [model]
      # @yieldparam [TokenModel] model
      def initialize(tokens, &block)
        super(@tokens = tokens, &block)
      end
    end # TokenModel
  end # GUI
end # OpenCoinage::Wallet
