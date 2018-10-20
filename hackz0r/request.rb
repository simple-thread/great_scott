require 'benchmark'
require 'httparty'

class Request
  URL = 'http://localhost:3000/posts?search='

  CONCURRENT_THREADS = 4
  ENCODED_QUESTION_MARK = '%3F'
  ENCODED_SPACE = '+'

  def initialize
    # First request can be unreliable.  e.g. rails server is still initializing
    response = get('throw_away')
    # Make sure we're actually hitting the right page
    fail 'Wrong page' unless response.body.include? 'Listing posts'
    # Make sure we're a normal user (not logged in as admin)
    fail 'Wrong user' unless response.body.include? 'Admin Sign In'
  end

  def get(search_term)
    HTTParty.get(
      "#{URL}#{search_term}"
    )
  end

  def benchmark_get(search_term)
    bm = Benchmark.realtime do
      get(search_term)
    end
    bm * 1000
  end

  def threaded_benchmark_get(search_terms)
    search_terms.map do |term|
      [
        term,
        Thread.new do
          benchmark_get(term)
        end
      ]
    end.to_h
  end

  def trials(search_terms, num_trials)
    results = Hash.new { |h, k| h[k] = [] }

    num_trials.times do |i|
      puts "Trial #{i+1} of #{num_trials}"
      search_terms.each_slice(CONCURRENT_THREADS) do |slice|
        threads = threaded_benchmark_get(slice)
        threads.each do |term, thread|
          results[term] << thread.value
        end
      end
    end

    results
  end

  private

  # TODO: Space seems to be working in the UI?  Why does it not work here
  def encode(term)
    term.gsub('?', ENCODED_QUESTION_MARK).gsub(' ', ENCODED_SPACE)
  end
end
