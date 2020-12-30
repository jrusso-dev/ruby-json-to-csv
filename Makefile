unittests:
	ruby tests/test-json-parser.rb

run-sample:
	ruby app/json-to-csv.rb app/assets/sample.json app/assets/sample.csv

help:
	ruby app/json-to-csv.rb