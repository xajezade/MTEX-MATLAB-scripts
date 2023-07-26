%% Load denoised data
LoadDeformedState

%% Automatic reference frame alignment
pfAnnotations = @(varargin) [];
setMTEXpref('pfAnnotations',pfAnnotations);
odf=calcDensity(ebsd.orientations,'halfwidth',5*degree);
[odf_corrected,rot_inv] = centerSpecimen(odf);
[mtexFig,~]=newMtexFigure('nrows',4,'ncols',3,'figSize','huge');
plotPDF(ebsd.orientations,Miller({1,1,1},{1,1,0},{1,0,0},ebsd.CS),'antipodal','contour','grid','grid_res',5*degree)
hold on
mtexFig.nextAxis
plotPDF(odf,Miller({1,1,1},{1,1,0},{1,0,0},odf.CS),'antipodal','contour','grid','grid_res',5*degree)
mtexFig.nextAxis
plotPDF(odf_corrected,Miller({1,1,1},{1,1,0},{1,0,0},odf.CS),'antipodal','contour','grid','grid_res',5*degree)
ebsd=rotate(ebsd,rot_inv, 'keepXY');
mtexFig.nextAxis
plotPDF(ebsd.orientations,Miller({1,1,1},{1,1,0},{1,0,0},ebsd.CS),'antipodal','contour','grid','grid_res',5*degree)
CLim(mtexFig,'equal')
mtexColorbar('location','southoutside');
saveas(gcf,'ReferenceFrameAlignment.tiff','tiff');
close all
%% Plot raw data
fg=figure(1);
ipfKey=ipfHSVKey(ebsd.CS.Laue);
ipfKey.inversePoleFigureDirection=yvector;
color=ipfKey.orientation2color(ebsd.orientations);
plot(ebsd,color)
saveas(fg,'raw-data.tiff','tiff');
close(fg);
%% Seperate and Plot a specific fibre (111||ED)
f111 = fibre(Miller(1,1,1,ebsd.CS),yvector);
mis111=angle(f111,ebsd.orientations)./degree;
ebsd111=ebsd(mis111<15.0);
fg=figure(2);
ipfKey=ipfHSVKey(ebsd111.CS.Laue);
ipfKey.inversePoleFigureDirection=yvector;
color=ipfKey.orientation2color(ebsd111.orientations);
plot(ebsd111,color)
saveas(fg,'111-fibre.tiff','tiff');
close(fg);
%% Plot a specific fibre (001||ED)
f001 = fibre(Miller(0,0,1,ebsd.CS),yvector);
mis001=angle(f001,ebsd.orientations)./degree;
ebsd001=ebsd(mis001<15.0);
fg=figure(3);
ipfKey=ipfHSVKey(ebsd001.CS.Laue);
ipfKey.inversePoleFigureDirection=yvector;
color=ipfKey.orientation2color(ebsd001.orientations);
plot(ebsd001,color)
saveas(fg,'001-fibre.tiff','tiff');
close(fg);
%% Seperate orientations that do not belong to either of fibres
scater=ebsd(mis001>=15.0 & mis111>=15.0);
fg=figure(4);
ipfKey=ipfHSVKey(scater.CS.Laue);
ipfKey.inversePoleFigureDirection=yvector;
color=ipfKey.orientation2color(scater.orientations);
plot(scater,color)
saveas(fg,'scatter.tiff','tiff');
close(fg);
%% Plot pole figures with different colors
fg=figure(5);
plotIPDF(ebsd.orientations,yvector,'antipodal','contour')
hold on
plotIPDF(scater.orientations,yvector,'antipodal','all','DisplayName','other orientations')
legend()
saveas(fg,'inverse polefigures.tiff','tiff');
close(fg);
