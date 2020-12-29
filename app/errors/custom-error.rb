
class EmptyContentError < StandardError
  def initialize(message = 'The content is empty')
    super(message)
  end
end

class BadJsonContentError < StandardError
  def initialize(message = 'The JSON content is malformed')
    super(message)
  end
end
