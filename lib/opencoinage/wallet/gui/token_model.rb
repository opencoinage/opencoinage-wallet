module OpenCoinage::Wallet
  module GUI
    ##
    # The currency tokens model.
    class TokenModel < TableModel
      COLUMNS = [] # TODO

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
        super(&block)
        @tokens = tokens
      end

      ##
      # Returns the list of columns.
      #
      # @return [Array<String>]
      def columns
        COLUMNS
      end

      ##
      # Returns the list of rows.
      #
      # @return [Array<Array>]
      def rows
        tokens
      end

      ##
      # Returns the data at the intersection of `row` and `column`.
      #
      # @param  [Integer] row
      # @param  [Integer] column
      # @return [String]
      def [](row, column)
        super # TODO
      end
    end # TokenModel
  end # GUI
end # OpenCoinage::Wallet
