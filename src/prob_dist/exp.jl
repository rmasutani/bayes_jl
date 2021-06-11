using Plots, LinearAlgebra, Distributions, StatsPlots

function generate_exp(lambda, num_samples::Int)
    x = rand(num_samples)
    exp_rand = (-1) .* log.(x) ./ lambda
    return exp_rand
end

# 逆変換法で指数分布に従う乱数を生成
function main()
    num_samples = 5000
    lambda = 2.0
    exp_rand = generate_exp(lambda, num_samples)
    histogram(exp_rand, bins=100, normed=true, alpha=0.3, label="sample")

    x = collect(0:0.01:5)
    true_dist = pdf.(Exponential(1.0 / lambda), x)
    plot!(x, true_dist, linewidth=2, label="true pdf")
    savefig("exp_sample.png")
end

main()