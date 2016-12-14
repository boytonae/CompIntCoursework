require 'csv'

class SearchSpace
  attr_reader :actual_demand, :data

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

  def evaluate(weights)
    return float.MAX unless valid?(weights)
    estimates = []
    data.each do |row|
      # apply weights to each row to get estimate
      estimates << calc_estimate(weights, row)
    end

    fitness(estimates)
  end

  def valid?(weights)
    weights.each do |weight|
      return false if weight < -100.00 || weight > 100
    end
    true
  end

  def generate_valid_weights
    weights = []
    (0...@actual_demand.length).each do
      weights << rand * (100.00 - -100.00) + -100.00
    end

    weights
  end

  private

  def calc_estimate(weights, row)
    total = 0
    weights.each_with_index do |weight, index|
      total += weight * row[index].to_f
    end

    total / weights.length
  end

  def fitness(estimates)
    total = 0
    estimates.each_with_index do |estimate, index|
      total += estimate - actual_demand[index].to_f
    end
    total / estimates.length
  end
end
