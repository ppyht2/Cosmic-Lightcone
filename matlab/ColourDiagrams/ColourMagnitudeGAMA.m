clc
close

%defined by cosmology
h=0.7;
%read in data
data=csvread('GAMA/GAMA_colour.csv',1,0);

%Define columns and map redshift range
gz=data(:,1);
m=data(:,2);
u=data(:,4);
r=data(:,6);

%preallocate lower limit redshifts to plot
z=[0 0.025 0.05 0.075 0.1 0.2];
sz=size(z);
%allocate step in redshift
stepsize=0.1;

%setting up positions for plot
x=[0.1 0.4 0.7 0.1 0.4 0.7];
y=[0.5 0.5 0.5 0.1 0.1 0.1];
figure1 = figure;
for i=1:sz(2)
    
    
    %setting subplots with no gaps
    axes('Parent',figure1,...
        'Position',[x(:,i)-0.05 y(i) 0.3 0.4]);
  
    cMap=gz<=z(:,i)+stepsize & gz>=z(:,i) & r-5*log10(h)<-10;
    %apply map to data
    cutu=u(cMap);
    cutr=r(cMap);
   
    %generate values for plotting
    difference=cutu-cutr;
    X=cutr-5*log10(h);
    
    dscatter(X, difference)
    colormap jet
    
    % caxis manual;
    caxis([0 20]);
    axis([-25 -15 0 3])
    
    %Store redshifts for legend
    zl(i,:) =sprintf('%0.3f',z(:,i));
    zu(i,:) =sprintf('%0.3f',z(:,i)+stepsize);
    zsfull(i,:) =strcat(zl(i,:),'<z<', zu(i,:));
    title(zsfull(i,:))
    set(gca, 'box', 'on')
    
    %remove ticks from non-edge plots
    if i== 2 || i== 3 || i==5 || i== 6
        set(gca,'YTickLabel',[]);
    else
        ylabel('$$M_u-M_r$$','interpreter','latex')
    end
    if i== 1 || i== 2 || i==3
        set(gca,'XTickLabel',[]);
    else
        xlabel('$$M_r-5logh$$','interpreter','latex')
    end
    
end
%colorbar;