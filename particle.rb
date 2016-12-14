require 'matrix'

class Particle


  def initialize(search_space)
    @positions = Matrix[search_space.generate_valid_weights]

    # initial velocity
    random_point = Matrix[search_space.generate_valid_weights]
    difference = random_point - @positions
    @velocity = difference/2

    @personal_best = @positions
    @personal_best_cost = search_space.evaluate(positions_array)
  end

  def update(search_space, global_best)
    # update position
    @positions = @positions + @velocity

    # update velocity
    update_velocity(global_best)

    # evaluate position
    current_pos_cost = search_space.evaluate(positions_array)

    # update pb if cp is better
    if (current_pos_cost < personal_best_cost)
      @personal_best = @positions
      @personal_best_cost = current_pos_cost
    end
  end

  def personal_best
    @personal_best
  end

  def personal_best_cost
    @personal_best_cost
  end

  def inertia
    1/(2*Math.log(2))
  end

  def cog_social
    0.5+Math.log(2)
  end

  def positions_array
    @positions.to_a[0]
  end

  private
  def uniform_random_vector
    vector = []
    for i in (0...positions_array.length)
      vector << rand
    end
    Matrix[vector]
  end

  def update_velocity(global_best)
    # next pos = current pos + velocity
    # velocity = (inertia * currentVelocity) + (cognitive * randomVector * (personalBestPos - currentPos)) + (social * randomVector * (globalBestPos - currentPos))
    r1 = uniform_random_vector
    r2 = uniform_random_vector

    @velocity = ((inertia * @velocity) +
                 (cog_social * elementwise_multiplication(r1, (@personal_best - @positions))) +
                 (cog_social * elementwise_multiplication(r2, (global_best - @positions))))
  end

  def elementwise_multiplication(matrix1, matrix2)
    result = []
    array1 = matrix1.to_a[0]
    array2 = matrix2.to_a[0]

    raise StandardError 'Matricies don\'t match' unless array1.length == array2.length

    array1.each_with_index do |value, i|
      result << value * array2[i]
    end

    Matrix[result]
  end
end
