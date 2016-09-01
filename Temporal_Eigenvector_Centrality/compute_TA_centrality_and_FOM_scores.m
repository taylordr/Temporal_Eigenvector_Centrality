%%

function TA_centrality_and_FOM_scores_datafile = compute_TA_centrality_and_FOM_scores(GC_network_data_filename,w_centrality_datafile)


   TA_centrality_and_FOM_scores_datafile = [w_centrality_datafile(1:(end-4)),'_TA_centrality_and_FOM_scores.mat'];
   
   if ~exist(TA_centrality_and_FOM_scores_datafile)
      
      
      load(GC_network_data_filename);%load network in struct net
      load(w_centrality_datafile);%load multilayer_centrality 
      
      T = net.T;
      N=net.N;
      
      %% Time-average centrality is given by the zeroth-order expansion
     
      %halfsine=sin([1:T]*pi/(T+1));
      %halfsine=halfsine/sqrt(sum(halfsine.^2));      
      [weights,temp] = eigs(multilayer_centrality.layer_adjacency_matrix,1);clear temp;
      halfsine = weights';
      
      
      Mstar = spalloc(net.N,net.N,net.N*net.T);
      for t=1:net.T
         Mstar = Mstar + multilayer_centrality.matrix_function(net.A{t})*(halfsine(t)^2);    
      end
      [a0,lambda1] = eigs(Mstar,1);
      a0 = sign(sum(a0))*a0;            
      V0 = a0*halfsine;
      
            
      
      %% First-Order_mover Scores is given by the first-order expansion (i.e., derivative)      

      G0=spalloc(net.N*net.T,net.N*net.T,net.N*net.T);
      for t=1:net.T
         ids = (t-1)*net.N + (1:net.N);
         G0(ids,ids) = multilayer_centrality.matrix_function(net.A{t});
      end

      
      
      L0=sparse(toeplitz([0,1,zeros(1,T-2)]));
      lambda0=eigs(L0,1,'la');%should be equal to 2*cos(pi/(T+1))
      L0=lambda0*speye(size(L0))-L0;
      L0plus=sparse(pinv(full(L0)));  %CAN WE CONTROL LEVEL OF PRECISION HERE? AND TEST OUTCOMES? pinv(A,TOL)
      L0plus=kron(L0plus,speye(N));
      L1=G0-lambda1*speye(size(G0));
      Mstar=Mstar-lambda1*speye(size(Mstar));
      v0idot=spdiags(repmat(halfsine(1),N,1),0,N,N*T);
      for t=2:T
          v0idot=v0idot+spdiags(repmat(halfsine(t),N,1),(t-1)*N,N,N*T);
      end
      L0plus=(L0plus+L0plus')/2;
      V1=L0plus*L1*V0(:);
      rhs=v0idot*L1*V1;
      lambda2=dot(rhs,a0);
      rhs=rhs-lambda2*a0;
      b1=-Mstar\rhs;
      b1=b1-dot(b1,a0)*a0;
      V1=reshape(V1,N,T)+b1*halfsine;

      
      
      
      
      %% Save variables
      
      TA_centrality = sqrt(sum(V0.^2,2));%i.e., a0
      FOM_scores = sqrt(sum(V1.^2,2));
    
      save(TA_centrality_and_FOM_scores_datafile,'V0','V1','TA_centrality','FOM_scores');
      
      
      
   end
   
end








