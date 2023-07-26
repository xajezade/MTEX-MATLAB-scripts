%load('SingleGrainsR.mat') % an ebsd of a grain with 111||ED and 001||ED should be loaded (names:ebBlueRot, ebRedRot)
%load('scat.mat') % ebsd map of scattered orientations in the deformed state should be loaded
%load mode files as mode
LoadModes
%load msfile1 as ms
LoadScales
%rr=-180+rand(length(mode),1)*(180+180);
mscale=[ms;[1,1]];
counter=1;
for i=1:length(mscale)-1
if(mscale(i,2)>mscale(i+1,2))
tmp(counter,1)=counter;
tmp(counter,2)=mscale(i,2);
counter=counter+1;
end
end
if (mode(tmp(1,1))==1)
    ODF=RedOriGen(tmp(1,2),ebRedRot,rr(1,1));
else
    ODF=BlueOriGen(tmp(1,2),ebBlueRot,rr(1,1));
end
for i=2:length(tmp)
  if (mode(tmp(i,1))==1)
      ODF=[ODF;RedOriGen(tmp(i,2),ebRedRot,rr(i,1))];
  else
      ODF=[ODF;BlueOriGen(tmp(i,2),ebBlueRot,rr(i,1))];
  end
end 
ff=[ODF.phi1 ODF.Phi ODF.phi2]./degree;
%ff=ff';
dlmwrite('ODF-4.txt',ff,'delimiter','\t')
