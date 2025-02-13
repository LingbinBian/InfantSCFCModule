% The functions called in this code are originially from: https://www.mathworks.com/matlabcentral/fileexchange/7210-ternary-plots
% 
function plot_ternary(alpha)
    num_samples = 10000;
    
    % Generate samples
    samples = drchrnd(alpha, num_samples);
    
    % Extract the samples
    x = samples(:, 1); % K=2
    y = samples(:, 2); % K=1
    z = samples(:, 3); % K=3
    
    data=dirichlet_pdf([x,y,z],alpha);
    
    %--------------------------------------------------------------------------
    
    figure;
    h=fill([0 1 0.5 0],[0 0 0.866 0],[0 0 0.3],'linewidth',2);
    % Plot the data
    % First set the colormap (can't be done afterwards)
    colormap(hot)
    %[hg,htick,hcb]=tersurf(A(:,1),A(:,2),A(:,3),v);
    [hg,htick,hcb]=tersurf(x,y,z,data);
    % Add the labels
    hlabels=terlabel('r_{2}=P(K=2)','r_{1}=P(K=1)','r_{3}=P(K=3)');
    
    %--------------------------------------------------------------------------
    %--  Change the color of the grid lines
    set(hg(:,3),'color',[0 0.4470 0.7410],'linewidth',1)
    set(hg(:,1),'color',[0.8500 0.3250 0.0980],'linewidth',1)
    set(hg(:,2),'color',[0.4660 0.6740 0.1880],'linewidth',1)
    
    %--  Modify the labels
    set(hlabels,'fontsize',16)
    set(hlabels(3),'color',[0 0.4470 0.7410])
    set(hlabels(1),'color',[0.8500 0.3250 0.0980])
    set(hlabels(2),'color',[0.4660 0.6740 0.1880])
    %--  Modify the tick labels
    set(htick,'fontsize',14)
    set(htick(:,2),'color',[0.4660 0.6740 0.1880],'linewidth',3)
    set(htick(:,1),'color',[0.8500 0.3250 0.0980],'linewidth',3)
    set(htick(:,3),'color',[0 0.4470 0.7410],'linewidth',3)
    
    %--  Change the color of the patch
    %set(h,'facecolor',[0 0 0.5156],'edgecolor','k')
    
    set(h,'facecolor',[0.0104 0 0],'edgecolor','k')
    %--  Change the colorbar
    set(hcb,'xcolor','k','ycolor','k')
    %--  Modify the figure color
    set(gcf,'color',[1 1 1])
    %-- Change some defaults
    set(gcf,'paperpositionmode','auto','inverthardcopy','off')
    h=colorbar;
    h.FontSize=14;
    h.Position=[0.88 0.1105 0.0286 0.8134];
    
    set(gcf,'unit','centimeters','position',[6 10 14 12])
    set(gca,'Position',[.15 .2 .65 .65]);
    
    % Estimate the marginal densities using kernel density estimation
    [f1, x] = ksdensity(x);
    [f2, y] = ksdensity(y);
    [f3, z] = ksdensity(z);
    
    % Plot the marginal densities
    figure;
    
    plot(x, f1, 'LineWidth', 2,'Color',[0.4660 0.6740 0.1880]);
    set(gca,'box','on')
    set(gca, 'linewidth', 1.2, 'fontsize', 12)
    title('Marginal Density of r_{2}','fontsize',16);
    xlabel('r_{2}=P(K=2)','fontsize',16);
    ylabel('P(r_{2})','fontsize',16);
    set(gcf,'unit','centimeters','position',[6 10 14 12])
    set(gca,'Position',[.22 .2 .65 .65],'fontsize',16);
    set(gca,'XTick',0:0.2:1)
    xlim([0,1]); % range of x
    
    figure
    plot(y, f2, 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980]);
    set(gca,'box','on')
    set(gca, 'linewidth', 1.2, 'fontsize', 12)
    title('Marginal Density of r_{1}','fontsize',16);
    xlabel('r_{1}=P(K=1)','fontsize',16);
    ylabel('P(r_{1})','fontsize',16);
    set(gcf,'unit','centimeters','position',[6 10 14 12])
    set(gca,'Position',[.22 .2 .65 .65],'fontsize',16);
    set(gca,'XTick',0:0.2:1)
    xlim([0,1]); % range of x
    
    figure
    plot(z, f3, 'LineWidth', 2,'Color',[0 0.4470 0.7410]);
    set(gca,'box','on')
    set(gca, 'linewidth', 1.2, 'fontsize', 12)
    title('Marginal Density of r_{3}','fontsize',16);
    xlabel('r_{3}=P(K=3)','fontsize',16);
    ylabel('P(r_{3})','fontsize',16);
    set(gcf,'unit','centimeters','position',[6 10 14 12])
    set(gca,'Position',[.22 .2 .65 .65],'fontsize',16);
    set(gca,'XTick',0:0.2:1)
    xlim([0,1]); % range of x
    % Adjust the layout
    %sgtitle('Marginal Densities of Dirichlet Distribution');
    % -------------------------------------------------------------------------
    % nested function
    function r = drchrnd(a,n)
        p = length(a);
        r = gamrnd(repmat(a,n,1),1,n,p);
        r = r ./ sum(r,2);
    end
    
    function p = dirichlet_pdf(X, alpha)
        % X is an N-by-K matrix where each row is a point in the K-dimensional simplex
        % alpha is a 1-by-K vector of Dirichlet parameters
        gamma_prod = prod(gamma(alpha));
        gamma_sum = gamma(sum(alpha));
        p = gamma_sum / gamma_prod * prod(X.^(alpha - 1), 2);
    end
end

