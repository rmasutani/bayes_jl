using Base:Float64

using Statistics, PyPlot, Distributions

"""
Gibbs sampling from a finite mixture model.
"""
function sample()
    # Define variables
    n = 500
    m = 10000
    theta = 0.3
    index = rand(n) .<= theta
    mu = 1.0

    # 表になる確率　θ のコインを投げ, 表なら X₁,  裏なら X₀ を出力する確率変数の分布
    x = randn(n) .+ index .* mu

    theta = rand() # θの初期値
    theta_vec = zeros(Float64, m)
    theta_vec[1] = theta
    index = rand(Binomial(1, 0.5), n) # Iₙの初期値

    for i = 2:m
        for j = 1:n
            u = rand()
            index[j] = ((theta * pdf(Normal(mu, 1), x[j])) / 
                (theta * pdf(Normal(mu, 1), x[j]) + (1 - theta) * pdf(Normal(0, 1), x[j])) > u)
        end

        theta = rand(Beta(sum(index) + 1, sum(1 .- index) + 1))
        theta_vec[i] = theta
    end

    # plot(theta_vec)

    # θの分布
    plt.hist(theta_vec, bins=100, density=true)
    plt.xlabel("θ")
    plt.ylabel("density")
    plt.savefig("results/theta_hist.png")
    plt.show()
end

sample()