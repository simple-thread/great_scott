module Enumerable

  def sum
    self.inject(0){|accum, i| accum + i }
  end

  def mean
    self.sum/self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    sum/(self.length - 1).to_f
  end

  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end

  def confidence_interval_99
    confidence_interval(0.99)
  end

  def confidence_interval_95
    confidence_interval(0.95)
  end

  private

  def confidence_interval(confidence)
    interval = t_value(confidence, self.length) * Math.sqrt(self.standard_deviation**2 / self.length)
    [self.mean - interval, self.mean + interval]
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
      elsif size <= 500
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
      elsif size <= 500
        1.96
      end
    else
      fail 'not implemented'
    end
  end
end
