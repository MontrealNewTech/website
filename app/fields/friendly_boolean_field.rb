require "administrate/field/base"

class FriendlyBooleanField < Administrate::Field::Base
  def to_s
    data
  end
end
