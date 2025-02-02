# frozen_string_literal: true

class ApplicationService
  def call(*args, &block)
    new(*args, &block).call
  end
end
