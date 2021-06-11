using Distributions:Random
using Plots, Distributions, LinearAlgebra
Random.seed!(1234)

"""
Generate cauchy distribution C(0, 1)
"""
function generate_cauchy(num_samples::Int)
    x = rand(num_samples)
    cauch_rand = tan.(pi .* x .- (pi / 2))
    return cauch_rand
end

function main()
    num_samples = 1000
    cauch_rand = generate_cauchy(num_samples)
    histogram(cauch_rand, bins=100, normed=true, alpha=0.3, label="sample")
    
    # True pdf
    x = collect(-10:0.01:10)
    true_dist = pdf.(Cauchy(0, 1), x)
    plot!(x, true_dist, linewidth=2, label="true pdf")
    savefig("cauchy_sample.png")
end

main()