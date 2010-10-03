module OpenCoinage::Wallet
  ##
  # A wallet database implementation based on SQLite.
  #
  # Wallet databases are implemented as SQLite database files. The database
  # file format is the current (as of 2010) format introduced in SQLite
  # 3.3.0. Legacy SQLite file formats and older SQLite engine versions are
  # not supported.
  #
  # @see http://opencoinage.org/apps/wallet/database
  class Database
    FILE_EXTENSION         = '.ocdb'
    CONTENT_TYPE           = 'application/vnd.opencoinage.database'
    DEFAULT_TABLE_PREFIX   = 'opencoinage_'
    DEFAULT_SCHEMA_VERSION = 0
    CURRENT_SCHEMA_VERSION = 0 # FIXME

    ##
    # Opens the database file designated by `filename`.
    #
    # @param  [String, #to_s] filename
    #   the file path to the database file
    # @param  [Hash{Symbol => Object}] options
    #   any additional database options
    # @option options [String] :password (nil)
    #   a password for encrypting and decrypting data
    # @option options [String] :prefix   (DEFAULT_TABLE_PREFIX)
    #   an SQLite table prefix
    def self.open(filename, options = {}, &block)
      self.new(options.merge(:filename => filename), &block)
    end

    ##
    # Initializes an in-memory database.
    #
    # @param  [Hash{Symbol => Object}] options
    #   any additional database options
    # @option options [String] :password (nil)
    #   a password for encrypting and decrypting data
    # @option options [String] :prefix   (DEFAULT_TABLE_PREFIX)
    #   an SQLite table prefix
    def initialize(options = {}, &block)
      @options = options.dup
      @options[:filename] ||= ':memory:'

      @db = SQLite3::Database.new(@options[:filename])
      execute(%q(PRAGMA encoding      = "UTF-8";))
      execute(%q(PRAGMA foreign_keys  = ON;))
      execute(%q(PRAGMA secure_delete = ON;))
      execute(%q(PRAGMA synchronous   = FULL;))
      Schema.create(self)

      block.call(self) if block_given?
    end

    ##
    # Any additional options for this database.
    #
    # @return [Hash]
    attr_reader :options

    ##
    # The file path to the database file.
    #
    # For transient in-memory databases, returns `nil`.
    #
    # @return [Pathname] a file path or `nil`
    attr_reader :filename
    def filename
      transient? ? nil : Pathname(options[:filename])
    end

    ##
    # Returns `true` if this is a persistent file-system database, `false`
    # otherwise.
    #
    # @return [Boolean] `true` or `false`
    # @see    #transient?
    def persistent?
      !transient?
    end

    ##
    # Returns `true` if this is a transient in-memory database, `false`
    # otherwise.
    #
    # @return [Boolean] `true` or `false`
    # @see    #persistent?
    def transient?
      options[:filename].to_s.eql?(':memory:')
    end

    ##
    # Returns `true` if the database file exists, `false` otherwise.
    #
    # For transient in-memory databases, returns `false`.
    #
    # @return [Boolean] `true` or `false`
    def exists?
      filename && filename.exist?
    end
    alias_method :exist?, :exists?

    ##
    # The database's schema version.
    #
    # @return [Integer] a positive integer
    attr_accessor :version

    ##
    # Returns the database schema version.
    #
    # @return [Integer] a positive integer
    def version
      @db.send(:get_int_pragma, 'user_version')
    end

    ##
    # Updates the database schema version.
    #
    # @param  [Integer, #to_i] value
    #   a positive integer
    # @return [Integer] a positive integer
    # @raise  [ArgumentError] if `value` is negative
    def version=(value)
      value = value.to_i
      raise ArgumentError, "expected a valid schema version, got #{value}" if value < 0
      @db.send(:set_int_pragma, 'user_version', value)
      value
    end

    ##
    # Executes an SQL query on this database.
    #
    # @param  [String] sql
    #   the SQL query string to execute
    # @return [void]
    # @see    http://rdoc.info/github/luislavena/sqlite3-ruby/master/SQLite3/Database#execute-instance_method
    def execute(sql, *args, &block)
      @db.execute(sql, *args, &block)
    end

    ##
    # Enumerates the issuers in this database.
    #
    # @param  [Hash{Symbol => Object}] options
    #   any additional filtering options
    # @yield  [issuer] each issuer
    # @yieldparam [Issuer] issuer
    # @return [Enumerator<Issuer>]
    def issuers(options = {}, &block)
      raise NotImplementedError, "#{self.class}#issuers" # TODO
      enum_for(:issuers, options)
    end

    ##
    # Enumerates the currencies in this database.
    #
    # @param  [Hash{Symbol => Object}] options
    #   any additional filtering options
    # @option options [Issuer] :issuer (nil)
    # @yield  [currency] each currency
    # @yieldparam [Currency] currency
    # @return [Enumerator<Currency>]
    def currencies(options = {}, &block)
      raise NotImplementedError, "#{self.class}#currencies" # TODO
      enum_for(:currencies, options)
    end

    ##
    # Enumerates the tokens in this database.
    #
    # @param  [Hash{Symbol => Object}] options
    #   any additional filtering options
    # @option options [Currency] :currency (nil)
    # @yield  [token] each token
    # @yieldparam [Token] token
    # @return [Enumerator<Token>]
    def tokens(options = {}, &block)
      raise NotImplementedError, "#{self.class}#tokens" # TODO
      enum_for(:tokens, options)
    end

    ##
    # Database schema migrations.
    module Schema
      ##
      # @param  [Database] db
      #   the database to operate upon
      # @return [void]
      def self.create(db)
        # TODO
      end

      ##
      # @param  [Database] db
      #   the database to operate upon
      # @param  [Integer]  from
      #   the minimum required schema version
      # @param  [Integer]  to
      #   the maximum targeted schema version
      # @return [void]
      def self.upgrade(db, from = 0, to = -1)
        # TODO
      end
    end # Schema
  end # Database
end # OpenCoinage::Wallet
