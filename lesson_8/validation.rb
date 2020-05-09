# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, args = nil)
      @validations ||= []
      validation = { type.to_sym => { name: name, args: args } }
      @validations << validation
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation.each do |validation_name, params|
          instance_var = instance_variable_get("@#{params[:name]}".to_sym)
          send(validation_name, instance_var, params[:args])
        end
      end
    end

    def valid?
      validate!
      true
    end

    def presence(value, _arg)
      raise 'Пустота недопустима.' if value.empty? || value.nil?
    end

    def format(value, format)
      raise 'Значение не соответствует формату.' if value !~ format
    end

    def type(value, type)
      raise 'Неверный тип.' if value.class != type
    end
  end
end
