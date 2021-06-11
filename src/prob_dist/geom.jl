using Plots, Distributions, LinearAlgebra
using Distributions:Random
Random.seed!(1234)

"""
Generate cauchy distribution C(0, 1)
"""
function generate_geom(p, num_samples::Int)
    x = rand(num_samples)
    geom_rand = floor.(log.(ones(num_samples) - x) ./ log(1 - p))
    return geom_rand
end

function main()
    num_samples = 5000
    p = 0.2
    geom_rand = generate_geom(p, num_samples)
    histogram(geom_rand, bins=40, normed=true, alpha=0.3, label="sample")
    
    # True pdf
    x = collect(0:1:40)
    true_dist = pdf.(Geometric(p), x)
    plot!(x, true_dist, linewidth=2, label="true pdf")
    savefig("geom_sample.png")
end

main()