module Enumerable
  def sum
    inject(0) { |accum, i| accum + i }
  end

  def mean
    sum / length.to_f
  end

  def sample_variance
    m = mean
    sum = inject(0) { |accum, i| accum + (i - m)**2 }
    sum / (length - 1).to_f
  end

  def standard_deviation
    Math.sqrt(sample_variance)
  end

  def confidence_interval_99
    confidence_interval(0.99)
  end

  def confidence_interval_95
    confidence_interval(0.95)
  end

  private

  def confidence_interval(confidence)
    interval = t_value(confidence, length) * Math.sqrt(standard_deviation**2 / length)
    [mean - interval, mean + interval]
  end

  def t_value(confidence, size)
    if confidence == 0.99
      if size <= 5
        4.03
      elsif size <= 15
        2.95
      elsif size <= 25
        2.79
      elsif size <= 35
        2.72
      elsif size <= 50
        2.68
      elsif size <= 100
        2.63
      else
        2.58
      end
    elsif confidence == 0.95
      if size <= 5
        2.57
      elsif size <= 15
        2.13
      elsif size <= 25
        2.06
      elsif size <= 35
        2.03
      elsif size <= 50
        2.01
      elsif size <= 100
        1.98
      else
        1.96
      end
    else
      fail 'not implemented'
    end
  end
end
