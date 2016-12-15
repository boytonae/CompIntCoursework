require_relative 'particle_swarm'
require_relative 'evolutionary'
require_relative 'random_search'

n = 100
loops = 1000

random_results = open('Results\reults_random.csv', 'w')

 (0...n).each do
  random = RandomSearch.new

  (0...loops).each do
    random.iterate
  end
  random_results.write("#{random.global_best_cost}, #{random.global_best} \n")
end
random_results.close

pso_results = open('Results\reults_pso.csv', 'w')

(0...n).each do
  swarm = ParticleSwarm.new
  (0...loops).each do
    swarm.search
  end
  pso_results.write("#{swarm.global_best_cost}, #{swarm.global_best} \n")
end
pso_results.close

evolve_results = open('Results\results_evolve.csv', 'w')

(0...n).each do
  evolve = Evolutionary.new(100)
  (0...loops).each do
    evolve.iterate
  end
  evolve_results.write("#{evolve.global_best_cost}, #{evolve.global_best} \n")
end
evolve_results.close

