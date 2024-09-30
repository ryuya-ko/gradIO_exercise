# import Pkg;
# Pkg.add("QuadGK");
# Pkg.add("Random");
using QuadGK  # Package for numerical integration
using Random  # Package for random number generation
using Statistics  # Package for statistical functions

### 1a
# evaluate the integral of f(x) = x * phi(x) from 0 to 1 where phi is standard normal distribution
function phi(x)
    return -exp(-x^2 / 2) / sqrt(2 * pi)
end

function mean_trunc(x)
    numerator, _ = QuadGK.quadgk(x -> x * phi(x), 0, 1)
    return numerator
end

# evaluate E as mean_trunc(1) / \int_0^1 phi(x) dx
E_true = mean_trunc(1) / QuadGK.quadgk(phi, 0, 1)[1];
println("E = ", E_true)

### 1b
# draw 50 random draws from the standard normal distribution
# Random.seed!(123);
# n = 50;
# x = randn(n);
# # get the empirical estimate of E
# # numerator is the sum of x_i with x_i > 0 and x_i < 1
# # denominator is the number of x_i with x_i > 0 and x_i < 1
# E_rnd = sum(x[(x .> 0) .& (x .< 1)]) / sum((x .> 0) .& (x .< 1));
# println("E_rnd = ", E_rnd)

# write a function of the above procedure
function E_rnd(nsample)
    X = Random.randn(nsample);
    return sum(X[(X .> 0) .& (X .< 1)]) / sum((X .> 0) .& (X .< 1));
end

# iterate the function 100 times and store 100 estimates to a vector
Random.seed!(123);
num_samples = 50;
E_rnd_test = E_rnd(num_samples);
println("E_rnd = ", E_rnd_test)
# E_rnd_vec = [E_rnd(num_samples) for i in 1:100];
# define E_rnd_vec as a vector of 100 elements
E_rnd_vec = zeros(100);
for i in 1:100
    E_rnd_vec[i] = E_rnd(num_samples);
end

E_rnd_mean = Statistics.mean(E_rnd_vec);
E_rnd_median = Statistics.median(E_rnd_vec);
E_rnd_std = Statistics.std(E_rnd_vec);

println("E_rnd_mean = ", E_rnd_mean)
println("E_rnd_median = ", E_rnd_median)
println("E_rnd_std = ", E_rnd_std)