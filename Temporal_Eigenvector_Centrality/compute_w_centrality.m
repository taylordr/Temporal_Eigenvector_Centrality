%%




function [w_centrality_datafile] = compute_w_centrality(GC_network_data_filename,multilayer_centrality)

   w_centrality_datafile = [GC_network_data_filename(1:(end-4)),'_',num2str(multilayer_centrality.centrality_name)];
   w_centrality_datafile = [w_centrality_datafile,'.mat']
   
   if ~exist(w_centrality_datafile)      

      load(GC_network_data_filename);%load struct 'net'
            
      
      G0=spalloc(net.N*net.T,net.N*net.T,net.N*net.T);
      for t=1:net.T
         ids = (t-1)*net.N + (1:net.N);
         G0(ids,ids) = multilayer_centrality.matrix_function(net.A{t});
      end
      
      for e = 1:length(multilayer_centrality.omegas)
         epsilon = 1/multilayer_centrality.omegas(e);
         %supracentrality matrix
         G = kron(multilayer_centrality.layer_adjacency_matrix,speye(net.N)) + epsilon*G0;      
         
         [multilayer_centrality.joint_centrality{e},multilayer_centrality.eigenvalues{e}]=eigs(G,1);         
         multilayer_centrality.joint_centrality{e} = sign(sum(multilayer_centrality.joint_centrality{e}))*multilayer_centrality.joint_centrality{e};
         multilayer_centrality.joint_centrality{e} = reshape(multilayer_centrality.joint_centrality{e},net.N,net.T);
                           
      end
                  

      
      
                        
      save(w_centrality_datafile,'multilayer_centrality');
      
      
      
   end

end






