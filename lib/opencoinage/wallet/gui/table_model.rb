module OpenCoinage::Wallet
  module GUI
    ##
    # A base class for table models.
    #
    # @see http://doc.qt.nokia.com/4.6/qabstracttablemodel.html
    class TableModel < Qt::AbstractTableModel
      ##
      # Initializes the table model.
      #
      # @yield  [model]
      # @yieldparam [TableModel] model
      # @see    http://doc.qt.nokia.com/4.6/qabstracttablemodel.html#QAbstractTableModel
      def initialize(*args, &block)
        super
      end

      ##
      # Returns the list of columns.
      #
      # @return [Array<String>]
      # @abstract
      def columns
        raise NotImplementedError, "#{self.class}#columns"
      end

      ##
      # Returns the list of rows.
      #
      # @return [Array<Array>]
      # @abstract
      def rows
        raise NotImplementedError, "#{self.class}#rows"
      end

      ##
      # Returns the data at the intersection of `row` and `column`.
      #
      # @param  [Integer] row
      # @param  [Integer] column
      # @return [String]
      # @abstract
      def [](row, column)
        raise NotImplementedError, "#{self.class}#[]"
      end

      ##
      # Returns the number of rows under the given `parent`.
      #
      # @param  [Qt::ModelIndex] parent
      # @return [Integer]
      # @see    http://doc.qt.nokia.com/4.6/qabstractitemmodel.html#rowCount
      def row_count(parent = Qt::ModelIndex.new)
        parent.valid? ? 0 : rows.count
      end
      alias_method :rowCount, :row_count

      ##
      # Returns the number of columns for the children of the given
      # `parent`.
      #
      # @param  [Qt::ModelIndex] parent
      # @return [Integer]
      # @see    http://doc.qt.nokia.com/4.6/qabstractitemmodel.html#columnCount
      def column_count(parent = Qt::ModelIndex.new)
        parent.valid? ? 0 : columns.count
      end
      alias_method :columnCount, :column_count

      ##
      # Returns the data for the given `role` and `section` in the header
      # with the specified `orientation`.
      #
      # @param  [Integer] section
      # @param  [Qt::Orientation] orientation
      # @param  [Integer] role
      # @return [Qt::Variant]
      # @see    http://doc.qt.nokia.com/4.6/qabstractitemmodel.html#headerData
      def header_data(section, orientation, role = Qt::DisplayRole)
        return super unless role == Qt::DisplayRole
        return super unless orientation == Qt::Horizontal
        return super unless (0...columns.count).include?(section)
        Qt::Variant.new(columns[section])
      end
      alias_method :headerData, :header_data

      ##
      # Returns the data stored under the given `role` for the item referred
      # to by the `index`.
      #
      # @param  [Qt::ModelIndex] index
      # @param  [Integer] role
      # @return [Qt::Variant]
      # @see    http://doc.qt.nokia.com/4.6/qabstractitemmodel.html#data
      def data(index, role = Qt::DisplayRole)
        return invalid unless role == Qt::DisplayRole
        return invalid unless (0...rows.count).include?(index.row)
        return invalid unless (0...columns.count).include?(index.column)
        Qt::Variant.new(self[index.row, index.column])
      end

    protected

      ##
      # Returns an invalid variant.
      #
      # @return [Qt::Variant]
      # @see    http://doc.qt.nokia.com/4.6/qvariant.html#QVariant
      def invalid
        Qt::Variant.new
      end
    end # TableModel
  end # GUI
end # OpenCoinage::Wallet
