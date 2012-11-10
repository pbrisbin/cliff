require 'spec_helper'

class MyConfig < Cliff::Base
  option :input, 'Input files'

  option :output, 'Output files', :list

  option :verbose, 'Act verbosely', :flag
end

describe Cliff do
  it "should load from yaml and argv" do
    MyConfig.load_from_yaml <<-EOY
      verbose: true
      input: x
      output:
       - y
       - z
      EOY

    MyConfig.load_from_argv(%w[ --no-verbose --input A --output B --output z ])

    MyConfig.verbose.should be_false

    MyConfig.input.should == 'A'

    MyConfig.output.should match_array(%w[ y z B z ])
  end
end
