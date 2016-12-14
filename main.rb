require_relative 'particle_swarm'

# training_data = SearchSpace.new('cwk_train.csv')

swarm = ParticleSwarm.new

print "\n****************************\n"
print swarm.global_best_cost

(0..1000).each do
  swarm.search
end
print "\n****************************\n"
print swarm.global_best_cost
print "\n****************************\n"
