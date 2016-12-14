# get a random population of weigths
# select candidates (tournament? other? roulette)
# mutate/crossover candidates until you have a new popiulation
class Evolutionary
  attr_reader :population
  def initialize(pop_size)
    @training_data = SearchSpace.new('cwk_train.csv')

    @population = []
    (0...pop_size).each do
      @population << @training_data.generate_valid_weights
    end
  end

  def iterate

  end

  private

  # randomly selects values from the parents to make a child
  # the more parents, the less will come from each
  def breed(parents)
    child = []

    for i in (0...parents[0].length) do
      random_parent = ((0...parents.length).to_a).sample
      puts random_parent
      child << parents[random_parent][i]
    end
    print child
    child
  end

  def rand_selection(num_candidates, population)
    candidates = []

    (0...num_candidates).each do
      rand_candidate = ((0...population.length).to_a).sample

      candidates << population[rand_candidate]
    end

    candidates
  end

  def best_selection(num_candidates, population)
    sorted_pop = population.sort_by do |member|
      @training_data.evaluate(member)
    end

    sorted_pop[0...num_candidates]
  end
end
