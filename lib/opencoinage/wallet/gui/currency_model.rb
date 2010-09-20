module OpenCoinage::Wallet
  module GUI
    ##
    # The currency model.
    class CurrencyModel < TableModel
      COLUMNS = [tr("Issuer"), tr("Asset"), tr("Unit"), tr("Total")]

      ##
      # The list of currencies.
      #
      # @return [Array<Currency>]
      attr_reader :currencies

      ##
      # Initializes the currency model.
      #
      # @param  [Array<Currency>] currencies
      # @yield  [model]
      # @yieldparam [CurrencyModel] model
      def initialize(currencies, &block)
        super(&block)
        @currencies = currencies
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
        currencies
      end

      ##
      # Returns the data at the intersection of `row` and `column`.
      #
      # @param  [Integer] row
      # @param  [Integer] column
      # @return [String]
      def [](row, column)
        currency = currencies[row]
        data = case column
          when 0 then currency[:issuer]
          when 1 then currency[:asset]
          when 2 then currency[:unit]
          when 3 then currency[:total] || '0.00' # FIXME
          else tr('N/A')
        end
      end
    end # CurrencyModel
  end # GUI
end # OpenCoinage::Wallet
