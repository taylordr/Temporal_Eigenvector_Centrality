% DEMO of temporal centrality analysis for PhD exchange between universities
%
% Copyright Dane Taylor 3 September 2016
 
clear;clc;%cleanup


%% Load edge list for weighted, directed network and construct adjacency matrices
      %edge_list_filename = 'PhD Exchange Network Data/PhD_exchange.txt';%edge list file
      %node_labels_filename = 'PhD Exchange Network Data/school_names.txt';%edge list file
      %network_data_filename = build_network(edge_list_filename,node_labels_filename);%build adjacnccy matrices
   network_data_filename = 'PhD Exchange Network Data/PhD_exchange_network.mat';

    
   
%% Reduce investigation to weakly component
   GC_network_data_filename = reduce_to_GC(network_data_filename);%build adjacnccy matrices

  

%% Analyze temporal centrality for given values of coupling weight omega
   load(GC_network_data_filename,'net');T = net.T;clear net;%extract number of time steps

   multilayer_centrality.layer_adjacency_matrix = spdiags(ones(T,2),[-1,1],T,T);%couple layers using an undirected chain
   multilayer_centrality.matrix_function = @(A) A'*A;%matrix function for authority scores
   multilayer_centrality.centrality_name = 'authority_scores';


   multilayer_centrality.omegas = 1./[.0001,.001,.01,.1,1];%explore these coupling strengths
   w_centrality_datafile = compute_w_centrality(GC_network_data_filename,multilayer_centrality);



%% Study Time-Averaged Centrality and First-Order-Mover Scores
% that is, study the limit when epsilon \to 0^+ (i.e., omega \to \infty)

   TA_centrality_and_FOM_scores_datafile = compute_TA_centrality_and_FOM_scores(GC_network_data_filename,w_centrality_datafile);

   tops_data_file = identify_top_centralities(TA_centrality_and_FOM_scores_datafile,GC_network_data_filename);


%% Study results results for Georgia Tech
   plot_results_for_Georgia_Tech(GC_network_data_filename,w_centrality_datafile);








