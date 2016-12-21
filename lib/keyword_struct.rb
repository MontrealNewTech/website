# frozen_string_literal: true
class KeywordStruct < Struct
  def initialize(**keyword_arguments)
    keys = keyword_arguments.keys.empty? ? nil : keyword_arguments.keys
    super(keys)
    keyword_arguments.each { |key, value| self[key] = value }
  end
end
