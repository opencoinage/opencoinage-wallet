module OpenCoinage::Wallet
  module GUI
    ##
    # The currency view.
    class CurrencyView < TableView
      ##
      # Initializes the currency view.
      #
      # @param  [Array<Currency>] currencies
      # @yield  [view]
      # @yieldparam [CurrencyView] view
      def initialize(currencies = OpenCoinage::Wallet.currencies, &block)
        super(CurrencyModel.new(currencies), &block)
      end
    end # CurrencyView
  end # GUI
end # OpenCoinage::Wallet
