module OpenCoinage::Wallet
  module GUI
    ##
    # The currency tokens view.
    class TokenView < Qt::GroupBox
      TITLE = tr("Tokens")

      ##
      # Initializes the token view.
      #
      # @param  [Array<Token>] tokens
      # @yield  [view]
      # @yieldparam [TokenView] view
      def initialize(tokens = [], &block)
        super()
        self.title  = TITLE
        self.layout = Qt::VBoxLayout.new do |inner|
          inner.margin  = 9
          inner.spacing = 6
          inner.add_widget(TableView.new(TokenModel.new(tokens)))
          inner.add_stretch(1)
        end
      end
    end # TokenView
  end # GUI
end # OpenCoinage::Wallet
