# Inventory example script
import numpy as np
from problem import Inventory


# Development
import mlo
import importlib
importlib.reload(mlo)

#  def run_inventory():
# Generate data
T = 2
M = 4.
K = 10.
radius = 3.0

# Operating point
theta_bar = np.array([
    4.,  # h
    6.,  # p
    3.5,  # c
    5.,  # x_0
    ])
theta_bar = np.concatenate((theta_bar, 5. * np.ones(T)))

# Define problem
problem = Inventory(T, M, K, radius, bin_vars=True)

# Training and testing data
n_train = 200
n_test = 10
theta_train = problem.sample(theta_bar, N=n_train)
theta_test = problem.sample(theta_bar, N=n_test)

# Encode training strategies
x_train, _, strategies = problem.solve_parametric(theta_train)
y_train, enc2strategy = mlo.encode_strategies(strategies)

#  # Training
#  n_layers = 2
#  n_classes = len(enc2strategy)
#  learner = NeuralNet(n_layers, n_classes)
#  learner.train(theta_train, y_train)
#
#  # Testing
#  results = eval_performance(theta_test, learner, problem,
#                             enc2strategy, k=3)
#  store(results)