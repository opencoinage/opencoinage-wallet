require File.join(File.dirname(__FILE__), 'spec_helper')

describe OpenCoinage::Wallet::CLI do
  # TODO
end

describe OpenCoinage::Wallet::CLI::Command do
  before :each do
    @command = CLI::Command.new
  end

  context "Command#home" do
    it "returns a Pathname" do
      @command.home.should be_a(Pathname)
    end
  end
end
