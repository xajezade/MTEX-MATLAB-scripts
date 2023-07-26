% finding a threshold for pair of subgrains that 001 and 111 fibres has a
% boundary between
f111 = fibre(Miller(1,1,1,ebsd.CS),zvector);
f001 = fibre(Miller(0,0,1,ebsd.CS),zvector);
threshold=angle(f001,f111)./degree;
% reducing the resolution of ebsd map for faster analysis
eb=reduce(ebsd,4);
% subgrain analysis
[grains,eb.grainId,eb.mis2mean] = calcGrains(eb,'threshold',2*degree,'unitcell');
pairs=grains.neighbors;
angleList=angle(grains(pairs(:,1)).meanOrientation,grains(pairs(:,2)).meanOrientation);
gBsubsCheck=angleList>(threshold-10)*degree;
gBsubs=grains(pairs(gBsubsCheck));
%keep only subs with 001||ED
% gBsubs_red=gBsubs(angle(gBsubs.meanOrientation,f001)<15*degree);
% eb_gBSub=eb(gBsubs_red);
% gIds=unique(eb_gBSub.prop.semsignal);
%keep only subs with 111||ED
gBsubs_blue=gBsubs(angle(gBsubs.meanOrientation,f111)<15*degree);
eb_gBSub=eb(gBsubs_blue);
gIds=unique(eb_gBSub.prop.semsignal);