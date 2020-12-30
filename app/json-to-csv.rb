require_relative 'json-parser'
require_relative 'csv-line-converter'

input_path = "/workspace/ruby/rubytutorial/app/assets/users.json"
output_path = "/workspace/ruby/rubytutorial/app/assets/users.csv"

input_file = File.open(input_path,"r")
input_file_content = input_file.read()
input_file.close()

json_parser = JsonParser.new(input_file_content)
parsed_content = json_parser.parsed_content

first_line = parsed_content[0]
csv_line_converter = CsvLineConverter.new(first_line)
header_csv = csv_line_converter.get_csv_header

output_file = File.open(output_path, "w+")
output_file.write(header_csv+"\n")
for line in parsed_content
  csv_line_converter = CsvLineConverter.new(line)
  data_csv = csv_line_converter.get_csv_data
  output_file.write(data_csv+"\n")
end
output_file.close()
