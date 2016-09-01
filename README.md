# Temporal_Eigenvector_Centrality
This Matlab code includes scripts and a demo for computing eigenvector centralities for temporal networks. Please cite the following for any usage of this code:

D Taylor, SA Meyers, A Clauset, MA Porter and PJ Mucha (2015) "Eigenvector-based centrality measures for temporal networks" arXiv preprint. http://arxiv.org/abs/1507.01266


Included files:

1. demo_MGP.m - the main script to run
2. PhD Exchange Network Data - folder containing network that encodes math PhD exchange between universities based on a study of the Mathematics Genealogy Project - https://genealogy.math.ndsu.nodak.edu/
3. build_network.m - converts an edge list into a sequence of adjacnecy matrices
4. reduce_to_GC.m - identifies giant component in layer-aggegated network and removes all nodes outside the GC
5. components.m - identifies the giant component for a given network
6. compute_w_centrality.m - computes the joint centralities for a supra-centrality matrix with given weights for inter-layer coupling 
7. compute_TA_centrality_and_FOM_scores.m - computes time-averaged centrality and first-order-mover scores
8. identify_top_centralities.m - creates a .txt listing the 10 nodes with top time-averaged centrality and first-order-mover scores
9. plot_results_for_Georgia_Tech.m - plots the joint-centrality trajectory and condition-centrality trajectory for Georgia Tech


Copyright, Dane Taylor 1 September 2016

