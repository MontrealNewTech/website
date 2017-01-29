# frozen_string_literal: true
class ServiceResponse
  attr_reader :object, :message

  def initialize(object, success = nil, message = nil)
    @object = object
    @success = success
    @message = message
  end

  def success?
    case @success
    when true, false
      @success
    else
      @object.respond_to?(:errors) ? @object.errors.none? : true
    end
  end

  def to_hash
    {
      object:   @object,
      success?: success?,
      message:  @message
    }
  end
end
