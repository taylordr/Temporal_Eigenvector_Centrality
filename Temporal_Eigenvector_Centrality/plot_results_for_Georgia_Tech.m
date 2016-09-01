function [] = plot_results_for_Georgia_Tech(GC_network_data_filename,multilayer_centrality)

   %load timestamps
   load(GC_network_data_filename);
   times = net.time_stamps;clear net; 
   
   %study centrality trajectories for various values of epsilon
   load(multilayer_centrality);
   
   for e = 1:length(multilayer_centrality.omegas)   
      GTech_joint_centrality_trajectory(e,:) = multilayer_centrality.joint_centrality{e}(37,:);

      marginal_layer_centrality = sum(multilayer_centrality.joint_centrality{e});
      GTech_conditional_centrality_trajectory(e,:) = ...
         multilayer_centrality.joint_centrality{e}(37,:)./marginal_layer_centrality;
   end
   
   
   GTech_fig = figure;
   
   subplot1 = subplot(1,2,1,'Parent',GTech_fig,'YScale','log','YMinorTick','on');
   %subplot(1,2,1);plot(times,GTech_conditional_centrality_trajectory')
   box(subplot1,'on');
   hold(subplot1,'all');
   semilogy1 = semilogy(times,GTech_conditional_centrality_trajectory,'Parent',subplot1,'LineStyle','none');
   set(semilogy1(1),'Marker','x','Color',[0 0 0]);
   set(semilogy1(2),'Marker','+','Color',[0 0 1]);
   set(semilogy1(3),'Marker','v');
   set(semilogy1(4),'Marker','o','Color',[0.682352960109711 0.466666668653488 0]);
   set(semilogy1(5),'Marker','square','Color',[0 0.749019622802734 0.749019622802734]);
   ylim(subplot1,[1e-3 0.1]);

   
   subplot2 = subplot(1,2,2,'Parent',GTech_fig,'YScale','log','YMinorTick','on');
   %plot(times,GTech_joint_centrality_trajectory')
   box(subplot2,'on');
   hold(subplot2,'all');
   semilogy2 = semilogy(times,GTech_joint_centrality_trajectory,'Parent',subplot2);
   set(semilogy2(1),'Marker','x','Color',[0 0 0]);
   set(semilogy2(2),'Marker','+','Color',[0 0 1]);
   set(semilogy2(3),'Marker','v');
   set(semilogy2(4),'Marker','o','Color',[0.682352960109711 0.466666668653488 0]);
   set(semilogy2(5),'Marker','square','Color',[0 0.749019622802734 0.749019622802734]);
   ylim(subplot2,[1e-06 0.06]);
   
   for e=1:length(multilayer_centrality.omegas)
      legend_names{e} = ['\epsilon = ',num2str(1/multilayer_centrality.omegas(e))];
   end
   
   legend(legend_names)
   
   









end