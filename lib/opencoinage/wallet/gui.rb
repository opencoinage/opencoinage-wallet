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
      ORGANIZATION_NAME = tr('OpenCoinage.org')
      APPLICATION_NAME  = tr('OpenCoinage Wallet')

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
      # Initializes the application.
      #
      # @param  [Array<String>] argv
      # @yield  [app]
      # @yieldparam [Application] app
      def initialize(argv, &block)
        super
        self.organization_name = ORGANIZATION_NAME
        self.application_name  = APPLICATION_NAME
        MainWindow.new.show
      end
    end

    ##
    # The application's main window.
    class MainWindow < Qt::MainWindow
      ##
      # Initializes the main window.
      #
      # @yield  [window]
      # @yieldparam [MainWindow] window
      def initialize(&block)
        super
        self.window_title   = Application::APPLICATION_NAME
        self.central_widget = CurrencyView.new
        create_actions
        create_menus
        create_toolbars
        create_status_bar
        resize(640, 480)
      end

    protected

      ##
      # @return [void]
      def create_actions
        # TODO
      end

      ##
      # @return [void]
      def create_menus
        # TODO
      end

      ##
      # @return [void]
      def create_toolbars
        # TODO
      end

      ##
      # @return [void]
      def create_status_bar
        # TODO
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
