function nori = BlueOriGen(nno,ebsdTmpBlue,rr)
ebsdTmp = rotate(ebsdTmpBlue,rotation.byAxisAngle(zvector,rr*degree),'KeepXY');
[grains,ebsdTmp.grainId,ebsdTmp.mis2mean] = calcGrains(ebsdTmp,'threshold',15*degree);
odf=calcDensity(grains.meanOrientation,'halfwidth',3.45*degree);
nori=odf.discreteSample(nno,'withoutReplacement');
end