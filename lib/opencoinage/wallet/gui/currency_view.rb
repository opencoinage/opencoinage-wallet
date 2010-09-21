module OpenCoinage::Wallet
  module GUI
    ##
    # The currency view.
    class CurrencyView < Qt::GroupBox
      TITLE = tr("Currencies")

      ##
      # Initializes the currency view.
      #
      # @param  [Array<Currency>] currencies
      # @yield  [view]
      # @yieldparam [CurrencyView] view
      def initialize(currencies = OpenCoinage::Wallet.currencies, &block)
        super()
        self.title  = TITLE
        self.layout = Qt::VBoxLayout.new do |inner|
          inner.margin  = 9
          inner.spacing = 6
          inner.add_widget(TableView.new(CurrencyModel.new(currencies)))
          inner.add_stretch(1)
        end
      end
    end # CurrencyView
  end # GUI
end # OpenCoinage::Wallet
