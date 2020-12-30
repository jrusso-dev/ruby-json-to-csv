class CsvLineConverter
  attr_accessor :content, :converted_content

  def initialize(content)
    @content = content
  end

  def get_csv_header
    fields_name = Array.new
    @content.each do |field_name, field_content|
      if field_content.is_a?(Hash)
        flattened_hash = flatten_hash(field_content)
        flattened_hash.each do |flattened_name, flattened_content|
          fields_name.push("#{field_name}.#{flattened_name}")
        end
      else
        fields_name.push(field_name)
      end
    end
    return fields_name.join(',')
  end

  def get_csv_data
    fields_data = Array.new
    @content.each do |field_name, field_content|
      if field_content.is_a?(Hash)
        flattened_hash = flatten_hash(field_content)
        flattened_hash.each do |flattened_name, flattened_content|
          fields_data.push(flattened_content)
        end
      else
        fields_data.push(field_content)
      end
    end
    return fields_data.join(',')
  end

  def flatten_hash(hash)
    hash.each_with_object({}) do |(k, v), h|
      if v.is_a? Hash
        flatten_hash(v).map do |h_k, h_v|
          h["#{k}.#{h_k}".to_sym] = h_v
        end
      else
        h[k] = v
      end
    end
  end

end