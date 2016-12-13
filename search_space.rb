require 'csv'

class SearchSpace
  def initialize(file_path)

    @actual_demand = []
    @data = []
    CSV.foreach(file_path) do |row|
      # first value in every row is the demand at the end of the day
      # aka what we measure our estimates against
      @actual_demand << row.shift
      @data << row
    end
  end

  def actual_demand
    @actual_demand
  end

  def data
    @data
  end

  def evaluate(weights)
    return float.MAX unless is_valid(weights)
    estimates = []
    data.each_with_index do |row, index|
      puts index
      # apply weights to each row to get estimate
      estimates << calc_estimate(weights, row)

      print estimates
      print "\n"
    end

    fitness(estimates)
  end

  def is_valid(weights)
    weights.each do |weight|
      return false if weight < -100.00 || weight > 100
    end
    true
  end

  private
  def calc_estimate(weights, row)
    total = 0
    weights.each_with_index do |weight, index|
      total += weight*row[index].to_f
    end

    total/weights.length
  end

  def fitness(estimates)
    total = 0
    estimates.each_with_index do |estimate, index|
      total += estimate - actual_demand[index].to_f
    end
    total/estimates.length
  end
end
