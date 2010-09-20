begin
  require 'Qt4' # @see http://rubygems.org/gems/qtbindings
rescue LoadError
  abort "OpenCoinage requires the QtRuby bindings (hint: `gem install qtbindings')."
end

module OpenCoinage::Wallet
  ##
  # The graphical user interface (GUI) wallet application.
  module GUI
    autoload :Application,   'opencoinage/wallet/gui/application'
    autoload :MainWindow,    'opencoinage/wallet/gui/main_window'
    autoload :TableModel,    'opencoinage/wallet/gui/table_model'
    autoload :TableView,     'opencoinage/wallet/gui/table_view'
    autoload :CurrencyModel, 'opencoinage/wallet/gui/currency_model'
    autoload :CurrencyView,  'opencoinage/wallet/gui/currency_view'
    autoload :TokenModel,    'opencoinage/wallet/gui/token_model'
    autoload :TokenView,     'opencoinage/wallet/gui/token_view'
  end # GUI
end # OpenCoinage::Wallet
