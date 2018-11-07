require_relative 'extend_enum'
require_relative 'request'

NUMBER_OF_TRIALS = 50
DIGIT_LENGTH_RANGE = (10..70)
SEARCH_TERMS = DIGIT_LENGTH_RANGE.map do |i|
  '?' * i
end

puts "NUMBER_OF_TRIALS: #{NUMBER_OF_TRIALS}"
puts "DIGIT_LENGTH_RANGE: #{DIGIT_LENGTH_RANGE}"

puts 'Running Trials...'
request = Request.new
results = request.trials(SEARCH_TERMS, NUMBER_OF_TRIALS)

puts 'Exporting results to csv...'

File.open('tmp/find_digits.csv', 'w') do |file|
  results.each do |term, values|
    file.write "#{term.scan('?').count},#{values.mean}\n"
  end
  puts file.path
end
