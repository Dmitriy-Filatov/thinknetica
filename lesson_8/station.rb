# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'
require_relative 'train'

class Station
  extend Accessors
  include InstanceCounter
  include Validation

  attr_accessor_with_history :trains
  attr_reader :name, :trains

  strong_attr_accessor :test_var, TestClass

  validate :name, :presence
  validate :name, :type, String

  @all = []

  class << self
    attr_reader :all

    def all=(object)
      @all << object
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.all = self
    validate!
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def each_train(&block)
    raise "Station #{name} is empty." if @trains.empty?

    @trains.each { |train| block.call(train) } if block_given?
  end

  protected

  attr_writer :name

  def validate!
    raise_blank_type_error if name.empty?
    raise_length_error if name.length > 40
  end

  def raise_blank_type_error
    raise 'Name not entered'
  end

  def raise_length_error
    raise 'Name must not be longer than 40 symbols'
  end
end
