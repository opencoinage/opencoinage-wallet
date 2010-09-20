module OpenCoinage::Wallet
  module GUI
    ##
    # The currency model.
    class CurrencyModel < GridModel
      HEADERS = [tr("Issuer"), tr("Asset"), tr("Unit"), tr("Total")]
      COLUMNS = [:issuer, :asset, :unit, :total]

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
        super(@currencies = currencies, &block)
      end
    end # CurrencyModel
  end # GUI
end # OpenCoinage::Wallet
