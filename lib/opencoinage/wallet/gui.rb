begin
  require 'Qt4' # @see http://rubygems.org/gems/qtbindings
rescue LoadError
  abort "OpenCoinage requires the QtRuby bindings (hint: `gem install qtbindings')."
end

module OpenCoinage::Wallet
  ##
  # The graphical user interface (GUI) wallet application.
  module GUI
    ##
    # The application.
    class Application < Qt::Application
      ORGANIZATION_DOMAIN = 'opencoinage.org'
      ORGANIZATION_NAME   = 'OpenCoinage.org'
      APPLICATION_NAME    = 'Wallet'

      ##
      # Executes the application using the given command-line arguments.
      #
      # @param  [Array<String>] argv
      # @yield  [app]
      # @yieldparam [Application] app
      # @return [void]
      def self.exec!(argv, &block)
        self.new(argv, &block).exec
      end

      ##
      # Returns the application settings.
      #
      # On Mac OS X, the application settings are stored in the plist file
      # `~/Library/Preferences/org.opencoinage.Wallet.plist`.
      #
      # @return [Qt::Settings]
      # @see    http://doc.qt.nokia.com/4.6/qsettings.html#platform-specific-notes
      def self.settings
        @settings ||= Qt::Settings.new
      end

      ##
      # Initializes the application.
      #
      # @param  [Array<String>] argv
      # @yield  [app]
      # @yieldparam [Application] app
      def initialize(argv, &block)
        super
        self.organization_name   = ORGANIZATION_NAME
        self.organization_domain = ORGANIZATION_DOMAIN
        self.application_name    = APPLICATION_NAME
        self.application_version = VERSION.to_s
        self.active_window       = MainWindow.new do
          self.show
          self.activate_window
        end
      end
    end

    ##
    # The application's main window.
    class MainWindow < Qt::MainWindow
      DEFAULT_POS  = [200, 200]
      DEFAULT_SIZE = [640, 480]
      WINDOW_TITLE = tr('OpenCoinage Wallet')

      ##
      # Initializes the main window.
      #
      # @yield  [window]
      # @yieldparam [MainWindow] window
      def initialize(&block)
        super
        self.window_title   = WINDOW_TITLE
        self.central_widget = Qt::Frame.new do
          Qt::HBoxLayout.new(self) do
            add_widget(CurrencyView.new)
          end
        end
        create_actions
        create_menus
        create_toolbars
        create_status_bar
        read_settings
      end

      ##
      # Prompts the user for text input.
      #
      # @param  [String] caption
      # @param  [String] prompt
      # @param  [Hash] options
      # @option options [String] :parent (nil)
      # @option options [String] :mode (Qt::LineEdit::Normal)
      # @option options [String] :text ('')
      # @return [String]
      # @see    http://doc.trolltech.com/4.6/qinputdialog.html#getText
      def get_text(caption, prompt, options = {})
        Qt::InputDialog.getText(options[:parent], caption, prompt,
          options[:mode] || Qt::LineEdit::Normal,
          options[:text] || '')
      end

      ##
      # Prompts the user for a file name.
      #
      # @param  [String] caption
      # @param  [String] dir
      # @param  [Hash] options
      # @option options [String] :parent (nil)
      # @option options [String] :filter ('')
      # @option options [String] :selected_filter ('')
      # @return [String]
      # @see    http://doc.trolltech.com/4.6/qfiledialog.html#getOpenFileName
      def open_file_dialog(caption, dir = '', options = {})
        Qt::FileDialog.getOpenFileName(options[:parent], caption, dir,
          options[:filter] || '',
          options[:selected_filter] || '')
      end

      ##
      # Displays a "not implemented yet" dialog box with the given
      # `caption`.
      #
      # @param  [String] caption
      # @return [void]
      def not_implemented_yet(caption)
        Qt::MessageBox.information(nil, caption, tr("This operation is not implemented yet."))
      end

    protected

      ##
      # Creates the main window's actions.
      #
      # @return [void]
      def create_actions
        app = self

        # Help > About box
        @about_action = Qt::Action.new(tr("&About..."), self) do
          self.status_tip = tr("Show information about the application.")
          connect(SIGNAL(:triggered)) do
            Qt::MessageBox.about(nil,
              tr("About the wallet"),
              tr("Visit <a href='http://opencoinage.org/'>OpenCoinage.org</a> for more information."))
          end
        end

        # Currency > Import file dialog
        @import_file_action = Qt::Action.new(tr("Import from &file..."), self) do
          self.status_tip = tr("Import a currency contract from a file.")
          connect(SIGNAL(:triggered)) do
            if file = app.open_file_dialog(caption = tr("Import currency"))
              app.not_implemented_yet(caption) # TODO
            end
          end
        end

        # Currency > Import URL dialog
        @import_url_action = Qt::Action.new(tr("Import from &URL..."), self) do
          self.status_tip = tr("Import a currency contract from a URL.")
          connect(SIGNAL(:triggered)) do
            if url = app.get_text(caption = tr("Import currency"), tr("Enter a currency URL:"), :text => "http://")
              app.not_implemented_yet(caption) # TODO
            end
          end
        end
     end


      ##
      # Creates the main window's menu bar.
      #
      # @return [void]
      def create_menus
        @file_menu     = menu_bar.add_menu(tr("&File"))
        @currency_menu = menu_bar.add_menu(tr("&Currency"))
        @currency_menu.add_action(@import_file_action)
        @currency_menu.add_action(@import_url_action)
        @token_menu    = menu_bar.add_menu(tr("&Token"))
        menu_bar.add_separator
        @help_menu     = menu_bar.add_menu(tr("&Help"))
        @help_menu.add_action(@about_action)
      end

      ##
      # Creates the main window's toolbar.
      #
      # @return [void]
      def create_toolbars
        # TODO
      end

      ##
      # Creates the main window's status bar.
      #
      # @return [void]
      def create_status_bar
        status_bar.show_message(tr("Ready"))
      end

      ##
      # Invoked when the main window is about to be closed.
      #
      # @param  [Qt::CloseEvent] event
      # @return [void]
      def close_event(event)
        write_settings
        event.accept
      end
      alias_method :closeEvent, :close_event

      ##
      # Restores the main window's position and size from the application
      # settings.
      #
      # @return [void]
      def read_settings
        move(Application.settings.value('pos', Qt::Variant.new(Qt::Point.new(*DEFAULT_POS))).to_point) # TODO: center on the screen
        resize(Application.settings.value('size', Qt::Variant.new(Qt::Size.new(*DEFAULT_SIZE))).to_size)
      end

      ##
      # Stores the main window's position and size in the application
      # settings.
      #
      # @return [void]
      def write_settings
        Application.settings.set_value('pos', Qt::Variant.new(pos))
        Application.settings.set_value('size', Qt::Variant.new(size))
        Application.settings.sync
      end
    end # MainWindow

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
    end

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

    ##
    # The currency model.
    class CurrencyModel < TableModel
      COLUMNS = [tr("Issuer"), tr("Asset"), tr("Unit"), tr("Total")]

      ##
      # The list of currencies.
      #
      # @return [Array]
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

    ##
    # The currency-specific tokens view.
    class TokenView < TableView
      # TODO
    end # TokenView
  end # GUI
end # OpenCoinage::Wallet
