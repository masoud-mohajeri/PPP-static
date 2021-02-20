
wgs84 = referenceEllipsoid('wgs84','m');

figure('Renderer','opengl')
ax = axesm('globe','Geoid',wgs84,'Grid','on', ...
    'GLineWidth',1,'GLineStyle','-',...
    'Gcolor',[.7 .8 .9],'Galtitude',100);
ax.Position = [0 0 1 1];
axis equal 
view(3)
load topo
geoshow(topo,topolegend,'DisplayType','texturemap')
load coastlines
plotm(coastlat,coastlon)
% demcmap(topo)

clear  coastlat coastlon topo  ax wgs84 topolegend topomap1 topomap2 topolonlim topolatlim

% hold on 
% plot3(-540020,5138020,3728020,'rh')







