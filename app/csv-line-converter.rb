class CsvLineConverter
  attr_accessor :content, :converted_content

  def initialize(content)
    @content = content
  end

  def get_csv_header
    fields_name = Array.new
    flatten_hash(@content).each do |field_name, field_content|
      fields_name.push(field_name)
    end
    fields_name.join(',')
  end

  def get_csv_data
    fields_data = Array.new
    returned_data = Array.new
    flatten_hash(@content).each do |field_name, field_content|
      fields_data.push(format_content(field_content))
    end
    fields_data.join(',')
  end

  def flatten_hash(hash)
    hash.each_with_object({}) do |(key, value), hash_reference|
      if value.is_a? Hash
        flatten_hash(value).map do |child_key, child_value|
          hash_reference["#{key}.#{child_key}".to_sym] = child_value
        end
      else
        hash_reference[key] = value
      end
    end
  end

  def format_content(content)
    if content.is_a? Array
      return "\"#{content.join(',')}\""
    end
    content
  end

end