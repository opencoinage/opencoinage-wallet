require File.join(File.dirname(__FILE__), 'spec_helper')

describe OpenCoinage::Wallet::Database do
  before :all do
    @tmpfile = '/tmp/ocwallet.ocdb' # FIXME
  end

  context "Database.open" do
    # TODO
  end

  context "Database.new" do
    # TODO
  end

  context "Database#open?" do
    it "returns true for open databases" do
      Database.new do |db|
        db.open
        db.should be_open
      end
    end

    it "returns false for closed databases" do
      Database.new do |db|
        db.close
        db.should_not be_open
      end
    end
  end

  context "Database#open" do
    it "opens the database" do
      Database.new do |db|
        db.close
        db.should_not be_open
        db.open
        db.should be_open
      end
    end

    it "returns self" do
      Database.new do |db|
        db.open.should == db
      end
    end
  end

  context "Database#closed?" do
    it "returns false for open databases" do
      Database.new do |db|
        db.open
        db.should_not be_closed
      end
    end

    it "returns true for closed databases" do
      Database.new do |db|
        db.close
        db.should be_closed
      end
    end
  end

  context "Database#close" do
    it "closes the database" do
      Database.new do |db|
        db.open
        db.should_not be_closed
        db.close
        db.should be_closed
      end
    end

    it "returns self" do
      Database.new do |db|
        db.close.should == db
      end
    end
  end

  context "Database#options" do
    it "returns a Hash" do
      Database.new.options.should be_a Hash
    end
  end

  context "Database#filename" do
    it "returns a Pathname for file-system databases" do
      Database.open(@tmpfile).filename.should be_a Pathname
    end

    it "returns nil for in-memory databases" do
      Database.new.filename.should be_nil
    end
  end

  context "Database#persistent?" do
    it "returns true for file-system databases" do
      Database.open(@tmpfile).should be_persistent
    end

    it "returns false for in-memory databases" do
      Database.new.should_not be_persistent
    end
  end

  context "Database#transient?" do
    it "returns false for file-system databases" do
      Database.open(@tmpfile).should_not be_transient
    end

    it "returns true for in-memory databases" do
      Database.new.should be_transient
    end
  end

  context "Database#exists?" do
    it "returns true if the database file exists" do
      pending # TODO
    end

    it "returns false if the database file does not exist" do
      pending # TODO
    end

    it "returns false for in-memory databases" do
      Database.new.should_not exist
    end
  end

  context "Database#readable?" do
    it "returns true if the database file is readable" do
      pending # TODO
    end

    it "returns false if the database file is not readable" do
      pending # TODO
    end

    it "returns true for in-memory databases" do
      Database.new.should be_readable
    end
  end

  context "Database#writable?" do
    it "returns true if the database file is writable" do
      pending # TODO
    end

    it "returns false if the database file is not writable" do
      pending # TODO
    end

    it "returns true for in-memory databases" do
      Database.new.should be_writable
    end
  end

  context "Database#version" do
    it "returns an integer" do
      Database.new.version.should be_an Integer
    end

    it "returns zero for new uninitialized databases" do
      Database.new(:initialize => false).version.should == 0
    end

    it "returns non-zero for new initialized databases" do
      Database.new.version.should_not == 0
    end

    it "returns the database version" do
      Database.new(:initialize => false) do |db|
        db.version.should == 0
        db.execute("PRAGMA user_version = 42;")
        db.version.should == 42
      end
    end
  end

  context "Database#version=" do
    it "raises ArgumentError if the value is negative" do
      lambda { Database.new.version = -1 }.should raise_error(ArgumentError)
    end

    it "returns an integer" do
      (Database.new.version = 1).should be_an Integer
    end

    it "sets and returns the database version" do
      Database.new(:initialize => false) do |db|
        db.version.should == 0
        (db.version = 42).should == 42
        db.version.should == 42
      end
    end
  end

  context "Database#initialized?" do
    # TODO
  end

  context "Database#empty?" do
    it "returns true for new databases" do
      pending # TODO
    end

    it "returns true for empty databases" do
      pending # TODO
    end

    it "returns false for non-empty databases" do
      pending # TODO
    end
  end

  context "Database#size" do
    # TODO
  end

  context "Database#execute" do
    # TODO
  end

  context "Database#execute_batch" do
    # TODO
  end

  context "Database#transaction_active?" do
    # TODO
  end

  context "Database#transaction" do
    # TODO
  end

  context "Database#commit" do
    # TODO
  end

  context "Database#rollback" do
    # TODO
  end

  context "Database#clear!" do
    # TODO
  end

  context "Database#compact!" do
    # TODO
  end

  context "Database#issuers" do
    it "returns an Issuer enumerator" do
      pending do
        Database.new.issuers.should be_an Enumerator
      end
    end
  end

  context "Database#currencies" do
    it "returns a Currency enumerator" do
      pending do
        Database.new.currencies.should be_an Enumerator
      end
    end
  end

  context "Database#tokens" do
    it "returns a Token enumerator" do
      pending do
        Database.new.tokens.should be_an Enumerator
      end
    end
  end
end
