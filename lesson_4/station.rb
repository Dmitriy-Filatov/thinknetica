# frozen_string_literal: true

class Station
  @all = []

  class << self
    attr_reader :all

    def all=(object)
      @all << object
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    self.class.all = self
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end
