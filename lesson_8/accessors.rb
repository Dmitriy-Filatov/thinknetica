# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) || [] }
      define_method("#{name}=".to_sym) do |value|
        values = [instance_variable_get(var_name), value].flatten.compact
        instance_variable_set(var_name, values)
      end
      alias_method "#{name}_history".to_sym, name.to_sym
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise "#{name} is not a #{name.class}" unless value.is_a? class_name

      instance_variable_set(var_name, value)
    end
  end
end
