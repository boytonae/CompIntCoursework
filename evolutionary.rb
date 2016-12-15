class Evolutionary
  attr_reader :population, :global_best
  def initialize(pop_size)
    @training_data = SearchSpace.new('cwk_train.csv')

    @population = []
    (0...pop_size).each do
      @population << @training_data.generate_valid_weights
    end

    @global_best = current_best
  end

  def iterate
    filler_per_gen = 10

    if filler_per_gen > population.length
      raise 'More filler than the population size!'
    end

    # select the new parents
    parents = tournament_selection(3, population.length / 2 )

    #breed them to fill up most of the next generation
    next_gen = []
    (0...(population.length - filler_per_gen)).each do
      next_gen << breed(parents)
    end

    #add random filler to keep the 'gene pool' fresh
    (0..filler_per_gen).each do
      next_gen << @training_data.generate_valid_weights
    end

    @population = next_gen

    @global_best = current_best if current_best_cost < global_best_cost
  end

  def global_best_cost
    @training_data.evaluate(global_best)
  end

  private

  # randomly selects values from the parents to make a child
  # the more parents, the less will come from each
  def breed(parents)
    child = []

    for i in (0...parents[0].length) do
      random_parent = ((0...parents.length).to_a).sample

      child << parents[random_parent][i]
    end
    child
  end

  def rand_selection(num_candidates, pool=population)
    candidates = []

    (0...num_candidates).each do
      rand_candidate = ((0...pool.length).to_a).sample

      candidates << pool[rand_candidate]
    end

    candidates
  end

  def best_selection(num_candidates, pool=population)
    sorted_pop = pool.sort_by do |member|
      @training_data.evaluate(member)
    end

    sorted_pop[0...num_candidates]
  end

  def tournament_selection(num_candidates, tournament_size)
    if num_candidates > tournament_size
      raise 'Tournament too small!'
    end

    tournament = rand_selection(tournament_size)

    best_selection(num_candidates, tournament)
  end

  def current_best
    sorted_pop = population.sort_by do |member|
      @training_data.evaluate(member)
    end

    sorted_pop[0]
  end

  def current_best_cost
    @training_data.evaluate(current_best)
  end
end
