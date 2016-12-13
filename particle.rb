require 'matrix'

class Particle
  def initialize(search_space)
    @positions = Matrix[search_space.generate_valid_weights]


    random_point = Matrix[search_space.generate_valid_weights]

    difference = random_point - @positions

    @velocity = difference/2

    @personal_best = @positions
    @personal_best_cost = search_space.evaluate(positions)
  end

  def update(search_space, global_best)
  end

  def personal_best
    @personal_best
  end

  def personal_best_cost
    @personal_best_cost
  end

  private
  def update_velocity
  end
end
