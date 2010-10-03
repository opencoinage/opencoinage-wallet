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

  context "Database#version" do
    it "returns an integer" do
      pending do # TODO
        Database.new.version.should be_an Integer
      end
    end

    it "returns the database version" do
      pending # TODO
    end
  end

  context "Database#version=" do
    it "raises ArgumentError if the value is negative" do
      pending # TODO
    end

    it "returns an integer" do
      pending # TODO
    end

    it "sets the database version" do
      pending # TODO
    end
  end

  context "Database#execute" do
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
