# get a random population of weigths
# select candidates (tournament? other? roulette)
# mutate/crossover candidates until you have a new popiulation
class Evolutionary
  attr_reader :population
  def initialize(pop_size)
    @training_data = SearchSpace.new('cwk_train.csv')

    @population = []
    (0..pop_size).each do
      @population << @training_data.generate_valid_weights
    end
  end

  def iterate

  end

  private

  def breed(parent1, parent2)

  end

  def rand_selection(num_candidates)

  end

end
