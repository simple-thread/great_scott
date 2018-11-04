require './extend_enum.rb'
require './request.rb'

NUMBER_OF_TRIALS = 10
DIGIT_LENGTH_RANGE = (10..70)
request = Request.new

SEARCH_TERMS = DIGIT_LENGTH_RANGE.map do |i|
  '?' * i
end

puts 'Running Trials...'
results = request.trials(SEARCH_TERMS, NUMBER_OF_TRIALS)

puts 'Exporting results to csv...'

File.open('tmp/find_digits.csv', 'w') do |file|
  results.each do |term, values|
    file.write "#{term.scan('?').count},#{values.mean}\n"
  end
  puts file.path
end
