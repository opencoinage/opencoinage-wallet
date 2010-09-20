module OpenCoinage::Wallet
  module GUI
    ##
    # A base class for table models.
    #
    # @see http://doc.qt.nokia.com/4.6/qstandarditemmodel.html
    class GridModel < Qt::StandardItemModel
      ##
      # Initializes the grid model.
      #
      # @param  [Array<Hash>] items
      # @yield  [model]
      # @yieldparam [GridModel] model
      def initialize(items = [], &block)
        @items = items
        super(@row_count = items.count, @column_count = columns.count)

        self.horizontal_header_labels = headers

        items.each_with_index do |item, row|
          item = item.is_a?(Hash) ? item : item.to_hash
          columns.each_with_index do |name, column|
            self[row, column] = item[name] || '-'
          end
        end

        block.call(self) if block_given?
      end

      ##
      # Sets the text of the cell at the intersection of `row` and `column`.
      #
      # @param  [Integer, #to_i] row
      # @param  [Integer, #to_i] column
      # @param  [String, #to_s]  text
      # @return [String]
      # @see    http://doc.qt.nokia.com/4.6/qstandarditemmodel.html#setItem
      def []=(row, column, text)
        set_item(row.to_i, column.to_i, Qt::StandardItem.new(text.to_s))
        text
      end

      ##
      # Appends a new row to the model.
      #
      # @param  [Array<String, #to_s>] row
      # @return [void]
      # @see    http://doc.qt.nokia.com/4.6/qstandarditemmodel.html#appendRow
      def <<(item)
        append_row(item.map { |text| Qt::StandardItem.new(text.to_s) })
        @row_count += 1
        self
      end

      ##
      # Returns the list of column headers.
      #
      # @return [Array<String>]
      def headers
        self.class.const_get(:HEADERS) rescue []
      end

      ##
      # Returns the list of column names.
      #
      # @return [Array<Symbol>]
      def columns
        self.class.const_get(:COLUMNS) rescue []
      end
    end # GridModel
  end # GUI
end # OpenCoinage::Wallet
