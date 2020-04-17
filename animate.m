function [M] = animate(data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

figure
%load coastlines;
%worldmap('world')
xlabel('Longitude')
ylabel('Latitude')
load coastlines
plot(coastlon,coastlat,'LineWidth',2,'Color','k')
xlim([-180 180])
ylim([-90 90])
hold on

lat = data(:,1);
lon = data(:,2);
x = linspace(-90,90,60);
y = linspace(-180,180,60);
[X,Y] = meshgrid(x,y);
%size(X)
v = 1000;
%hold off;

tot = CovidMatStreamLine(lat,lon,data(:,3));
%size(tot')
%contourfm(X,Y,tot,levels)
%geoshow(coastlat,coastlon,'Color','k')
%contourcbar
contourspline(Y,X,tot',v); % plot the first set of data  
colorbar
axis manual      % this way the scales do not change 

for ii = 4:68   % now animate; use 200 (random, correct)...
                 % ...time steps or data sets
    hold on;
    fprintf('Plotting data for day: %i \n', ii-2);
    tot = CovidMatStreamLine(lat,lon,data(:,ii)); % replace by sensor data
    confirmed= sum(sum(tot));
    %disp(count);
    %levelMax = round(max(tot)+50);
    %levels = 0:10:levelMax;
    contourspline(Y,X,tot',v);
    plot(coastlon,coastlat,'LineWidth',2,'Color','k')
    colorbar
    %levels = 0:10:levelMax;
    %contourfm(X,Y,tot,levels)
    %geoshow(coastlat,coastlon,'Color','k')
    %contourcbar
    title(['This is Day: ',num2str(ii-3), '; Total confirmed cases: ', num2str(confirmed)]);
    pause(0.1)   % nope. to slow it down. you loop through...
                 % ...draw > pause > draw > pause etc.
    M(ii-3) = getframe(gcf);
end

end

