module OpenCoinage::Wallet
  module GUI
    ##
    # A base class for table views.
    class TableView < Qt::TableView
      ##
      # Initializes the table view with the given `model`.
      #
      # @param  [Object] model
      # @yield  [view]
      # @yieldparam [TableView] view
      def initialize(model = nil, &block)
        super(&block)
        self.model = model if model
        self.vertical_header.hide
        self.horizontal_header.stretch_last_section = true
        self.selection_behavior = Qt::AbstractItemView::SelectRows
      end
    end # TableView
  end # GUI
end # OpenCoinage::Wallet
