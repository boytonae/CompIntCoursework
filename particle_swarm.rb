require_relative 'search_space'
require_relative 'particle'

class ParticleSwarm
  attr_reader :global_best

  def initialize
    @global_best = nil

    @training_data = SearchSpace.new('cwk_train.csv')

    @swarm = []
    swarm_size = (20 + Math.sqrt(@training_data.data.length)).round

    # initialize the swarm
    (0..swarm_size).each do
      particle = Particle.new(@training_data)


      if (@global_best == nil || @training_data.evaluate(particle.personal_best) < global_best_cost)
        @global_best = particle.personal_best
      end

      @swarm << particle
    end
  end

  def search
    @swarm.each do |particle|
      particle.update(@training_data, @global_best)

      if @training_data.evaluate(particle.personal_best) < global_best_cost
        @global_best = particle.personal_best
      end
    end
  end

  def global_best_cost
    @training_data.evaluate(@global_best)
  end
end
