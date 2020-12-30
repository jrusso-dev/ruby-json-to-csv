require "test/unit"
require_relative '../app/lib/json-parser'
require_relative '../app/errors/custom-error'

class TestJsonParser < Test::Unit::TestCase

  def test_constructor
    assert_raise(ArgumentError) do
      JsonParser.new()
    end
  end

  def test_empty_or_nil_content
    assert_raise(EmptyContentError) do
      JsonParser.new("")
    end

    assert_raise(EmptyContentError) do
      JsonParser.new(nil)
    end
  end

  def test_wrong_json_format
    assert_raise(BadJsonContentError) do
      JsonParser.new("bad content")
    end
    assert_raise(BadJsonContentError) do
      JsonParser.new("{'mykey':}")
    end

  end

  def test_empty_json_content
    assert_raise(EmptyContentError) do
      JsonParser.new('{}')
    end
  end

  def test_good_json_content
    json_parser = JsonParser.new('{"mykey": "myvalue", "mysecondkey":"mysecondvalue"}')
    parsed_content = json_parser.parsed_content
    assert_equal(2, parsed_content.length)
    assert_equal('myvalue', parsed_content['mykey'])
    assert_equal('mysecondvalue', parsed_content['mysecondkey'])
  end



end