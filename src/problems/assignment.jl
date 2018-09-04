mutable struct Assignment <: OptimizationProblem
    # Data in LP form
    data::ProblemData

    # Additional data to build the problem
    # (independent from the parameters)
    A::Int64

    # Empty constructor
    Assignment() = new()
end


function populate!(problem::Assignment, theta::Array{Float64})

    # Get dimension
    A = problem.A

    T = A  # Same tasks as agents

    c = eye(A) + spdiagm(theta)

    # Define JuMP model
    m = Model(solver=MyModule.BUILD_SOLVER)

    # Variables
    @variable(m, x[i=1:A, j=1:T] >= 0)

    # Constraints
    @constraint(m, [i=1:A], sum(x[i, j] for j = 1:T) == 1)
    @constraint(m, [j=1:T], sum(x[i, j] for i = 1:A) == 1)

    # Objective
    @objective(m, Min, sum(c[i, j] * x[i, j]  for i in 1:A for j = 1:T))

    # Extract problem data
    problem.data = extract_problem_data(m)

end


