LoadOrientations
fileID = fopen('raw.raw');
grainID = fread(fileID,[8192 8192],'int32');
phi1_map=ODF(grainID,1);
phi_map=ODF(grainID,2);
phi2_map=ODF(grainID,3);
x=1:8192;
xmat=ones(8192,8192).*x;
ymat=xmat';
c1=reshape(phi1_map,[8192*8192 1]);
c2=reshape(phi_map,[8192*8192 1]);
c3=reshape(phi2_map,[8192*8192 1]);
c4=reshape(xmat,[8192*8192 1]);
c5=reshape(ymat,[8192*8192 1]);
c6=reshape(grainID,[8192*8192 1]);
ebsd_var=[c1 c2 c3 c5 c4 c6];
writematrix(ebsd_var,'ebsd.txt','Delimiter','\t')