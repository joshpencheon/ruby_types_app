# Ruby Types App

Playground for testing our RBS.

### Structure

Code is in `lib/`, and RBS signatures are in `sig/`.

## Examples

### RBS Setup

Using the static prototyper (notice `untyped` where things can't be derived):

```
$ bundle exec rbs prototype rb lib/classes.rb
```
```ruby
module RubyTypesApp
  class Car
    attr_reader colour: untyped

    attr_reader speed: untyped

    def initialize: (colour: untyped colour) -> void

    def accelerate: (?by: ::Integer by) -> untyped
  end

  class RacingCar < Car
    def initialize: () -> void
  end
end
```

### RBS Usage

Listing signatures:

```
$ bundle exec rbs -I sig/ --no-stdlib list
::RubyTypesApp (module)
::RubyTypesApp::Car (class)
::RubyTypesApp::RacingCar (class)
```

Getting method information:

```
$ rbs -I sig/ method ::RubyTypesApp::RacingCar accelerate
::RubyTypesApp::RacingCar#accelerate
  defined_in: ::RubyTypesApp::Car
  implementation: ::RubyTypesApp::Car
  accessibility: public
  types:
      (?by: ::Integer) -> ::Integer
```

Executing code with typechecking:

```
$ RBS_TEST_TARGET='RubyTypesApp::*'  ruby -r rbs/test/setup lib/classes.rb
TypeError:
  [RubyTypesApp::Car#accelerate] ArgumentTypeError: expected `::Integer` but given `99.9`,
  [RubyTypesApp::Car#accelerate] ReturnTypeError: expected `::Integer` but returns `99.9`
```

### Steep usage

Checking types (config sourced from the `Steepfile`):

```
$ bundle exec steep check
# Type checking files:

....................................................F...........

lib/classes.rb:30:21: [error] Cannot pass a value of type `::Float` as an argument of type `::Integer`
│   ::Float <: ::Integer
│     ::Numeric <: ::Integer
│       ::Object <: ::Integer
│         ::BasicObject <: ::Integer
│
│ Diagnostic ID: Ruby::ArgumentTypeMismatch
│
└ racer.accelerate(by: 99.9)
                       ~~~~

Detected 1 problem from 1 file
```
