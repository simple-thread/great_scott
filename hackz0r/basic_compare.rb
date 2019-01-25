require_relative 'extend_enum'
require_relative 'request'

NUMBER_OF_TRIALS = 100
SEARCH_TERMS = ['scott', 'blake']

puts "NUMBER_OF_TRIALS: #{NUMBER_OF_TRIALS}"
puts "SEARCH_TERMS: #{SEARCH_TERMS}"

results = Hash.new { |h, k| h[k] = [] }
request = Request.new

NUMBER_OF_TRIALS.times do |i|
  puts "Trial #{i + 1} of #{NUMBER_OF_TRIALS}"
  SEARCH_TERMS.each do |term|
    results[term] << request.benchmark_get(term)
  end
end

results.each do |name, values|
  puts "Name: #{name}"
  puts "Trials: #{values.length}"
  puts "Min: #{values.min.round(1)}"
  puts "Max: #{values.max.round(1)}"
  puts "Mean: #{values.mean.round(1)}"
  puts "Standard Deviation: #{values.standard_deviation.round(1)}"
  puts "Confidence Interval 95%: #{values.confidence_interval_95}"
  puts "Confidence Interval 99%: #{values.confidence_interval_99}"
  puts 'Raw Values: '
  puts values.map { |v| v.round(1) }.to_s
  puts
end
