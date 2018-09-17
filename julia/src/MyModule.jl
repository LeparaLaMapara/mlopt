module MyModule

# Incldue packages
using ProgressMeter
using Distributions   # To sample points from Balls
using GSL             # Using GNU Scientific Library for special function like Gamma

# Learners
using OptimalTrees
OT = OptimalTrees

# Data manipulation and plotting
using DataFrames
using CSV
using Plots

# Mathematical programming and solvers
using JuMP
using MathProgBase
#  using GLPKMathProgInterface
#  using CPLEX   # For solving problems
using OSQP    # For creating problem structure from JuMP
using Gurobi  # For reading problems from files
using Clp  # For reading problems from files
using Mosek

# Define constants
TOL = 1e-06
INFINITY = 1e15
#  SOLVER = CplexSolver(CPX_PARAM_SCRIND = 0)
#  SOLVER= GLPKSolverLP()
SOLVER= MosekSolver(QUIET=1)
#  SOLVER = GurobiSolver(OutputFlag=0)
READ_SOLVER = GurobiSolver(OutputFlag=0)
#  READ_SOLVER = ClpSolver()
#  BUILD_SOLVER = OSQPMathProgBaseInterface.OSQPSolver(verbose=false)
BUILD_SOLVER= MosekSolver(QUIET=1)
#  BUILD_SOLVER = ClpSolver()


include("types.jl")  # Functions for solving and identifying active constraints
include("strategy.jl")  # Functions for solving and identifying strategies
include("learner.jl")    # Learn and predict active sets
include("performance.jl")    # Functions for analyzing performance of the method
include("utils.jl")    # Functions for analyzing performance of the method

# Include problem types
include("problems/assignment.jl")
include("problems/netliblp.jl")
include("problems/inventory.jl")

end