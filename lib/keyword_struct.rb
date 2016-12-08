class KeywordStruct < Struct
  def initialize(**keyword_arguments)
    super(keyword_arguments.keys)
    keyword_arguments.each { |key, value| self[key] = value }
  end
end
