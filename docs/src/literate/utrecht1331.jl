# # Utrecht1331 
#
# ```Matlab
# % Utrecht1331 in NLEVP
# 
# %% Clear the workspace and the command window
# clear;
# clc;
# 
# %% Load the matrices
# load utrecht1331
# 
# %% Get the coefficients of the eigenvalue problem
# lambda = quadeig(M, D, K);
# 
# %% Plot the distribution of eigenvalues
# 
# % Use LaTeX by default for all labels
# set(groot,'defaultTextInterpreter','latex')
# scatter(real(lambda), imag(lambda), 150, "red", ".");
# 
# % Set title, axis limit, labels
# title('Distribution of the eigenvalues of \texttt{utrecht1331}', 'FontSize', 20)
# axis([-18, 0, -600, 500])
# xlabel('$\Re(\lambda)$', 'FontSize',18);
# ylabel('$\Im(\lambda)$', 'FontSize',18);
# grid on;
# ```