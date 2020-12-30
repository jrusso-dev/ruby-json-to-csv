require_relative 'json-parser'
require_relative 'csv-line-converter'
require_relative 'file-writer'

def display_help
  puts 'Usage :'
  puts 'ruby json-to-csv.rb input_file.json output_file.csv'
end

arguments_list = ARGV
if arguments_list.length != 2
  display_help
else
  input_path = arguments_list[0]
  output_path = arguments_list[1]
  json_file_exists = true

  puts "Reading input JSON file #{input_path}"
  begin
    input_file = File.open(input_path,'r')
  rescue
    puts "Input JSON file doesn't exist !"
    json_file_exists = false
  end

  if json_file_exists
    parsed_content = JsonParser.new(input_file.read()).parsed_content
    puts 'Content parsed successfully'

    first_line = parsed_content[0]
    header_csv = CsvLineConverter.new(first_line).get_csv_header

    file_writer = FileWriter.new(output_path)
    file_writer.write(header_csv)
    for line in parsed_content
      data_csv = CsvLineConverter.new(line).get_csv_data
      file_writer.write(data_csv)
    end
    puts "Writing output CSV file #{output_path}"

    input_file.close
    file_writer.close
  end
end
