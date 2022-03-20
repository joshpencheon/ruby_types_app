module RubyTypesApp
  class Car
    attr_reader :colour
    attr_reader :speed

    def initialize(colour:)
      @colour = colour
      @speed = 0
    end

    def accelerate(by: 1)
      @speed += by
    end
  end

  class RacingCar < Car
    def initialize
      super(colour: "red")
    end
  end
end

car = RubyTypesApp::Car.new(colour: "blue")
car.accelerate
car.accelerate(by: 10)
car.accelerate(by: 10.1)

racer = RubyTypesApp::RacingCar.new