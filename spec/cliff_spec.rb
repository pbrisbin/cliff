require 'spec_helper'

module MyApp
  class Config < Cliff::Base

    option :verbose, :bool, false
    option :input, :string, '-'

  end

  describe Config do
    it "should have defaults" do
      Config.verbose?.should be_false
      Config.input.should == '-'
    end

    it "should be loadable from a file" do
      Config.load <<-EOYAML
      verbose: true
      input: ./a/file
      EOYAML

      Config.verbose?.should be_true
      Config.input.should == './a/file'
    end

  end
end
