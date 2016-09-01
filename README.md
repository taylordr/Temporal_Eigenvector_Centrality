# Temporal_Eigenvector_Centrality
eigenvector centrality for temporal networks

this Matlab code includes scripts and a demo for computing eigenvector centralities for temporal networks

included files:

demo_MGP.m - the main script to run
PhD Exchange Network Data - folder containing network that encodes math PhD exchange between universities based on a study of the Mathematics Genealogy Project - https://genealogy.math.ndsu.nodak.edu/

build_network.m - converts an edge list into a sequence of adjacnecy matrices
reduce_to_GC.m - identifies giant component in layer-aggegated network and removes all nodes outside the GC
components.m - identifies the giant component for a given network
compute_w_centrality.m - computes the joint centralities for a supra-centrality matrix with given weights for inter-layer coupling 
compute_TA_centrality_and_FOM_scores.m - computes time-averaged centrality and first-order-mover scores
identify_top_centralities.m - creates a .txt listing the 10 nodes with top time-averaged centrality and first-order-mover scores
plot_results_for_Georgia_Tech.m - plots the joint-centrality trajectory and condition-centrality trajectory for Georgia Tech

Copyright, Dane TAylor 1 September 2016

Please cite the following for any usage of this code:

D Taylor, SA Meyers, A Clauset, MA Porter and PJ Mucha (2015) "Eigenvector-based centrality measures for temporal networks" arXiv preprint. http://arxiv.org/abs/1507.01266
