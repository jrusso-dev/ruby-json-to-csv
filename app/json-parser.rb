require_relative 'errors/custom-error'
require 'json'

class JsonParser
  attr_accessor :content, :parsed_content

  def initialize(content)
    @content = content
    check_content()
    parse_content()
    check_parsed_content()
  end

  def check_content()
    if (@content == nil || @content.length == 0)
      raise(EmptyContentError)
    end
  end

  def parse_content()
    begin
      @parsed_content = JSON.parse(@content)
    rescue
      raise(BadJsonContentError)
    end
  end

  def check_parsed_content()
    if (@parsed_content.length == 0)
      raise(EmptyContentError)
    end
  end

end