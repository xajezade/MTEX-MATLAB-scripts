LoadGlobalOrientationList
cs=crystalSymmetry('cubic');
ori=orientation.byEuler(ODF.*degree,cs);
f001 = fibre(Miller(0,0,1,cs),zvector);
f111 = fibre(Miller(1,1,1,cs),zvector);
fracs=zeros(51,3);
for i=0:50
%% load grains size list
    opts = delimitedTextImportOptions("NumVariables", 1);
    % Specify range and delimiter
    opts.DataLines = [1, Inf];
    opts.Delimiter = ",";
    
    % Specify column names and types
    opts.VariableNames = "VarName1";
    opts.VariableTypes = "double";
    
    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Import the data
    GrainSize = readtable(strcat("GrainSize",num2str(i),".txt"), opts);
    GrainSize = table2array(GrainSize);
    clear opts

%% calculate fractions
    red_check=angle(ori,f001);
    red_cri=red_check<15*degree;
    red_frac=sum(red_cri.*GrainSize)/sum(GrainSize);
    blue_check=angle(ori,f111);
    blue_cri=blue_check<15*degree;
    blue_frac=sum(blue_cri.*GrainSize)/sum(GrainSize);
%% store to a list
    fracs(i+1,1)=red_frac*100;
    fracs(i+1,2)=blue_frac*100;
    fracs(i+1,3)=(1-blue_frac-red_frac)*100;
end
dt=0.8/4*0.25*0.25/(500*0.324);
t=0:dt*1000:dt*50000;
fg=figure(1);
plot(t,fracs(:,2),'DisplayName','111||ED')
hold on;
plot(t,fracs(:,1),'DisplayName','001||ED')
hold on
plot(t,fracs(:,3),'DisplayName','non-ideal orientations')
ylim([0,100])
xlabel('$time (s)$','Interpreter','latex')
ylabel('$Volume\ fraction (\%)$','Interpreter','Latex')
legend()
saveas(fg,'fracs.tiff','tiff');