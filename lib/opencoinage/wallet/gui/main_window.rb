module OpenCoinage::Wallet
  module GUI
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
        self.central_widget = Qt::Frame.new do |frame|
          frame.layout = Qt::VBoxLayout.new do |outer|
            outer.margin  = 9
            outer.spacing = 6
            outer.add_widget(Qt::GroupBox.new do |group|
              group.title  = tr("Currencies")
              group.layout = Qt::VBoxLayout.new do |inner|
                inner.margin  = 9
                inner.spacing = 6
                inner.add_widget(CurrencyView.new)
                inner.add_stretch(1)
              end
            end)
            outer.add_widget(Qt::GroupBox.new do |group|
              group.title  = tr("Tokens")
              group.layout = Qt::VBoxLayout.new do |inner|
                inner.margin  = 9
                inner.spacing = 6
                inner.add_widget(TokenView.new)
                inner.add_stretch(1)
              end
            end)
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
              tr("About the Wallet"),
              tr("Visit <a href='http://opencoinage.org/'>OpenCoinage.org</a> for more information."))
          end
        end

        # Currency > Import file dialog
        @import_file_action = Qt::Action.new(tr("Import from &File..."), self) do
          self.status_tip = tr("Import a currency contract from a file.")
          connect(SIGNAL(:triggered)) do
            if file = app.open_file_dialog(caption = tr("Import Currency"))
              app.not_implemented_yet(caption) # TODO
            end
          end
        end

        # Currency > Import URL dialog
        @import_url_action = Qt::Action.new(tr("Import from &URL..."), self) do
          self.status_tip = tr("Import a currency contract from a URL.")
          connect(SIGNAL(:triggered)) do
            if url = app.get_text(caption = tr("Import Currency"), tr("Enter a currency URL:"), :text => "http://")
              app.not_implemented_yet(caption) # TODO
            end
          end
        end

        # Token > Verify dialog
        @verify_action = Qt::Action.new(tr("&Verify..."), self) do
          self.status_tip = tr("Verify the selected tokens with the issuer.")
          connect(SIGNAL(:triggered)) do
            app.not_implemented_yet(caption = tr("Verifying Tokens")) # TODO: progress dialog
          end
        end

        # Token > Reissue dialog
        @reissue_action = Qt::Action.new(tr("&Reissue..."), self) do
          self.status_tip = tr("Reissue the selected tokens with the issuer.")
          connect(SIGNAL(:triggered)) do
            app.not_implemented_yet(caption = tr("Reissuing Tokens")) # TODO: progress dialog
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
        @token_menu.add_action(@verify_action)
        @token_menu.add_action(@reissue_action)
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
  end # GUI
end # OpenCoinage::Wallet
