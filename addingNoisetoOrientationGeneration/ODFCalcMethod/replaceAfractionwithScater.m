load('scat.mat')
ebsdTmp = rotate(scater,rotation.byAxisAngle(xvector,90*degree),'KeepXY');
odf=calcDensity(ebsdTmp.orientations,'halfwidth',5*degree);
LoadOrientations
gIds=gIds(randperm(length(gIds)));
newOris=odf.discreteSample(12000);
ODF(gIds(1:12000),1)=newOris.phi1./degree;
ODF(gIds(1:12000),2)=newOris.Phi./degree;
ODF(gIds(1:12000),3)=newOris.phi2./degree;
writematrix(ODF,'ODF_new.txt','Delimiter',' ')