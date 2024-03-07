
%%
% The following is a Matlab-based Code for Clutering evolvation to decipher
% subsurface geodynamics and stress patterens, using seismic catalog as
% input (Longitude, Latitude, and Depth of earthquakes). It produce
% seismicity patterens of the area to be studied, delineate various tectonically regimes distinct from each other. 
%The Code is developed at Center of Earthquake Studies (CES), Islamabad, Pakistan. 
% Corresponding Author: Mohammad Salam
% Email Address: salamphysicist@hotmail.com
%% 
clc
clear all
close all
%% Load seismic data
isb = xlsread('../InPut/Makran2.xlsx', 'Data5');
X = zscore(isb(:, 8:10));           % Z-standardize data
mean_orig = mean(isb(:, 8:10));     % to mean of data
std_orig = std(isb(:, 8:10));       % Calculation of Standard devaitin
rng default

num_clusters = 8;                   % User defined Number of clusters
clust = zeros(size(X, 1), num_clusters);        % To create an array of zeroes for the clusters value to be replace with
%% to Find clusters centers using Fuzzy C-means (FCM) method
for k = 1:num_clusters
    [centers, U] = fcm(X, k);
    [~, maxU] = max(U);
    clust(:, k) = maxU;
end

x = 1:num_clusters;

%% Cluster Evaluation on the basis of 'CalinskiHarabasz', 'DaviesBouldin', 'silhouette' indices
evaluations = cell(1, 3);
evaluation_names = {'CalinskiHarabasz', 'DaviesBouldin', 'silhouette'};
for i = 1:3
    eva = evalclusters(X, clust, evaluation_names{i});
    evaluations{i} = (eva.CriterionValues - mean(eva.CriterionValues(2:8))) / std(eva.CriterionValues(2:8));
end
%% As the optimal number of clusters are 6 in the given data so 6 centers for 3 records of data namely, Longitude, latude, and Depth are initialized 
centers6 = zeros(6, 3); % Initialize centers6
for i = 1:6
    [centers, ~] = fcm(X(clust(:, 6) == i, :), 1);
    centers6(i, :) = centers(:, 1:3) .* std_orig(:, 1:3) + mean_orig(:, 1:3);
end
%% Plot clustering evaluations on the basis of 'CalinskiHarabasz', 'DaviesBouldin', 'silhouette' indice
mar = {'rs:', 'bo--', 'g^-'};
figure('position', [0 0 900 700], 'PaperOrientation', 'landscape', 'PaperSize', [12, 10]);
hold on
for i = 1:3
    plot(x, evaluations{i}, mar{i}, 'DisplayName', evaluation_names{i});
end
annotation('ellipse', [0.62 0.25 0.05 0.55], 'Color', 'magenta');
annotation('textarrow', [0.5 0.62], [0.7 0.62], 'Color', 'magenta', 'String', 'Optimal Number of Clusters', 'FontSize', 14, 'FontWeight', 'bold');
hold off
legend('CalinskiHarabasz', 'DaviesBouldin', 'silhouette', 'Location', 'north', 'FontSize', 14, 'FontWeight', 'bold')
title('Normalized values for clustering indexes')
xlabel('Number of Clusters')
ylabel('Normalized Indexing Value')

ax = gca;
ax.XAxis.FontSize = 14;
ax.XAxis.FontWeight = 'bold';
ax.XAxis.Color = 'k';
ax.YAxis.FontSize = 14;
ax.YAxis.FontWeight = 'bold';
ax.YAxis.Color = 'k';
ax.Title.FontSize = 14;
ax.Title.FontWeight = 'bold';
ax.Title.Color = 'k';

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

print(fig, '../OutPut/Figure3', '-dpdf');
%% Plot Silhouette
figure('position', [0 0 900 700], 'PaperOrientation', 'landscape', 'PaperSize', [12, 10]);
silhouette(X, clust(:, 6))
ax = gca;
ax.XAxis.FontSize = 14;
ax.XAxis.FontWeight = 'bold';
ax.XAxis.Color = 'k';
ax.YAxis.FontSize = 14;
ax.YAxis.FontWeight = 'bold';
ax.YAxis.Color = 'k';
ax.Title.FontSize = 14;
ax.Title.FontWeight = 'bold';
ax.Title.Color = 'k';
fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

print(fig, '../OutPut/Figure2', '-dpdf');
%% import topo map which is already prefared using GMT
fim = imread('../InPut/FM.jpg');
[m, n, ~] = size(fim);   % to invert the map
fimb = fim;
for i = 1:n
    for j = 1:m
        fimb(j, i, :) = fim(m - j + 1, i, :);
    end
end
fimR = georefcells([24 30.2], [59.8 66.2], size(fimb));
figure('position', [0 0 950 800],'PaperOrientation', 'portrait', 'PaperSize', [10, 10]); %
geoshow(fimb, fimR, 'DisplayType', 'image')

hold on
% Define depth colormap
depthColormap = hsv(135); % 135 is the total number of events
colormap(depthColormap);

% Create a color index for depth values
depthColors = round(interp1(linspace(min(isb(:, 10)), max(isb(:, 10)), 155), 1:155, isb(:, 10))); % maximum depth is 155 km

markers = {'v', 'o', '^', '<', 's', 'd'};       % Define markers
transparency = 0.5; % Set the transparency level

for i = 1:6
    idx = clust(:, 6) == i;
    scatter(isb(idx, 8), isb(idx, 9), 100, depthColors(idx), markers{i}, 'filled', 'LineWidth', 2.5, 'MarkerEdgeColor', 'k');
end

c = colorbar;
c.Label.String = 'Depth Km';
c.Limits = [0, max(isb(:, 10)) + 10];
c.Label.FontSize = 16;
c.Label.FontWeight = 'bold';
c.Label.Color = 'k';

xlabel('Longitude');
ylabel('Latitude');
legend('Arabian Sea', 'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6', 'Location', 'southeast')
title('Clusters Formed by Fuzzy C-Means Clustering Technique')
%%   Aply Axes limites
ylim([24 30.2]);
xlim([59.8 66.2]);
%% Format figure axes
ax = gca;
ax.XAxis.FontSize = 14;
ax.XAxis.FontWeight = 'bold';
ax.XAxis.Color = 'k';
ax.YAxis.FontSize = 14;
ax.YAxis.FontWeight = 'bold';
ax.YAxis.Color = 'k';
ax.Title.FontSize = 14;
ax.Title.FontWeight = 'bold';
ax.Title.Color = 'k';

outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig, '../OutPut/Figure4', '-dpdf');   % SAve figure at OutPut directory in pdf format
%%  The End of the code