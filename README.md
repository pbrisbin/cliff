# Cliff

Cliff aims to help command line application developers with general app 
configuration.

More often than not, a simple Hash of key-values will be plenty to 
configure a simple command line app. The complication seems to come when 
we implement the common idiom of overriding settings: defaults to 
configuration file to commandline arguments.

Cliff intends to simplify that most common use-case.

## Usage

In your application, you're going to want a singleton object to hold app 
configuration. Inherit from `Cliff::Base` and declaratively state what 
the various options are.

~~~ { .ruby }
module MyApp
  class Config < Cliff::Base

    # Use a flag type to get a yes/no
    option(:verbose, 'Be more verbose', :flag)

    # By default, we get a simple option-argument
    option(:input, 'The input file')

    # There's also a list type for multiple values
    option(:output, 'Output files', :list)

  end
end
~~~

With that present, you can load a configuration file (or not) and parse 
options (or not). In the end, you're left with a normal ruby object with 
intuitive accessors for each of your defined options:

~~~ { .ruby }
module MyApp
  class Main
    CONFIG_FILE = 'something.yaml'
    #
    # Let's assume something.yaml contains:
    #
    #   input: A
    #   output:
    #     - B
    #     - C
    #     - D
    #

    def self.run(argv)
      Config.load_from_yaml(File.open(CONFIG_FILE))
      Config.load_from_argv(argv)

      p Config.verbose
      p Config.input
      p Config.output
    end
  end
end

MyApp::Main.run []
# false
# A
# [ B, C, D ]

MyApp::Main.run %w[ --verbose --input X --output Y --output Z ]
# true
# "X"
# [ B, C, D, Y, Z ]

MyApp::Main.run %w[ --help ]
# usage: my_app [options]
#   --[no-]verbose   Be more verbose
#   --input VALUE    The input file
#   --output VALUE   Output files
~~~
