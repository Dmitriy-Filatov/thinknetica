# frozen_string_literal: true

module Validate
  def valid?
    validate!
    true
  rescue
    false
  end
end
