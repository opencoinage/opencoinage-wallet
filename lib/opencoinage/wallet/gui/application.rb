module OpenCoinage::Wallet
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
  end # GUI
end # OpenCoinage::Wallet
