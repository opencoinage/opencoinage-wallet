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

    protected

      ##
      # Creates the main window's actions.
      #
      # @return [void]
      def create_actions
        # About box
        @about_action = Qt::Action.new(tr("&About..."), self) do
          self.status_tip = tr("Show information about the application.")
          connect(SIGNAL(:triggered)) do
            Qt::MessageBox.about(nil,
              tr("About the OpenCoinage Wallet"),
              tr("Visit <a href='http://opencoinage.org/'>OpenCoinage.org</a> for more information."))
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
    # The currency view.
    class CurrencyView < Qt::TableView
      # TODO
    end # CurrencyView

    ##
    # The currency-specific tokens view.
    class TokenView < Qt::TableView
      # TODO
    end # TokenView
  end # GUI
end # OpenCoinage::Wallet
