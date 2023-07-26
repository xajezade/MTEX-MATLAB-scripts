function nori = RedOriGen(nno,ebsdTmpRed,rr)
ebsdTmp = rotate(ebsdTmpRed,rotation.byAxisAngle(zvector,rr*degree),'KeepXY');
[grains,ebsdTmp.grainId,ebsdTmp.mis2mean] = calcGrains(ebsdTmp,'threshold',15*degree);
odf=calcDensity(grains.meanOrientation,'halfwidth',4.5*degree);
nori=odf.discreteSample(nno,'withoutReplacement');
end