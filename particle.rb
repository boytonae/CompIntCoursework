require 'matrix'

class Particle
  attr_reader :personal_best

  def initialize(search_space)
    @positions = Matrix[search_space.generate_valid_weights]

    # initial velocity
    random_point = Matrix[search_space.generate_valid_weights]
    difference = random_point - @positions
    @velocity = difference / 2

    @personal_best = @positions
  end

  def update(search_space, global_best)
    # update position
    @positions += @velocity

    # update velocity
    update_velocity(global_best)

    # evaluate position
    current_pos_cost = search_space.evaluate(@positions)

    # update pb if cp is better
    if current_pos_cost < search_space.evaluate(@personal_best)
      @personal_best = @positions
    end
  end

  def inertia
    1 / (2 * Math.log(2))
  end

  def cog_social
    0.5 + Math.log(2)
  end

  def positions_array
    @positions.to_a[0]
  end

  private

  def uniform_random_vector
    vector = []
    (0...positions_array.length).each do
      vector << rand
    end
    Matrix[vector]
  end

  def update_velocity(global_best)
    @velocity = ((inertia * @velocity) +
                 cog_social_multiply(@personal_best - @positions) +
                 cog_social_multiply(global_best - @positions))
  end

  def cog_social_multiply(weighting)
    rand_vector = uniform_random_vector
    cog_social * elementwise_multiplication(rand_vector, weighting)
  end

  def elementwise_multiplication(matrix1, matrix2)
    result = []
    array1 = matrix1.to_a[0]
    array2 = matrix2.to_a[0]

    unless array1.length == array2.length
      raise 'Matrices don\'t match'
    end

    array1.each_with_index do |value, i|
      result << value * array2[i]
    end

    Matrix[result]
  end
end
