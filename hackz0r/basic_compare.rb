require './extend_enum.rb'
require './request.rb'

NUMBER_OF_TRIALS = 100
SEARCH_TERMS = ['great', 'blake', 'future', 'past']
results = Hash.new { |h, k| h[k] = [] }
request = Request.new

NUMBER_OF_TRIALS.times do |i|
  puts "Trial #{i+1} of #{NUMBER_OF_TRIALS}"
  SEARCH_TERMS.each do |term|
    results[term] << request.benchmark_get(term)
  end
end

results.each do |name, values|
  puts "Name: #{name}"
  puts "Trials: #{values.length}"
  puts "Mean: #{values.mean}"
  puts "Standard Deviation: #{values.standard_deviation}"
  # puts "Confidence Interval 95%: #{values.confidence_interval_95}"
  puts "Confidence Interval 99%: #{values.confidence_interval_99}"
  puts 'Raw Values: '
  puts values.to_s
  puts
end
