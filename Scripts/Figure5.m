
%%
% The following is a Matlab-based Code for creating figure 5 of the paper, based on Clutering evolvation to decipher
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
X = zscore(isb(:, 8:10)); % Z-standardize data
mean_orig = mean(isb(:, 8:10));
std_orig = std(isb(:, 8:10));
rng default
num_clusters = 8; % Number of clusters
clust = zeros(size(X, 1), num_clusters);
for k = 1:num_clusters
    [centers, U] = fcm(X, k);
    [~, maxU] = max(U);
    clust(:, k) = maxU;
end
x = 1:num_clusters;
evaluations = cell(1, 3);
evaluation_names = {'CalinskiHarabasz', 'DaviesBouldin', 'silhouette'};
for i = 1:3
    eva = evalclusters(X, clust, evaluation_names{i});
    evaluations{i} = (eva.CriterionValues - mean(eva.CriterionValues(2:8))) / std(eva.CriterionValues(2:8));
end
centers6 = zeros(6, 3); % Initialize centers6
for i = 1:6
    [centers, ~] = fcm(X(clust(:, 6) == i, :), 1);
    centers6(i, :) = centers(:, 1:3) .* std_orig(:, 1:3) + mean_orig(:, 1:3);
end
%% import topo map
fim = imread('../Input/FM2.jpg');
[m, n, ~] = size(fim);
fimb = fim;
for i = 1:n
    for j = 1:m
        fimb(j, i, :) = fim(m - j + 1, i, :);
    end
end
fimR = georefcells([24 30.2], [59.8 66.2], size(fimb));
figure('position', [0 0 800 750],'PaperOrientation', 'landscape','PaperSize', [8, 7]);

%% Subplot a)
subplot(3, 3, [1, 2, 4, 5]);
geoshow(fimb, fimR, 'DisplayType', 'image')
hold on
markers = ['s', 'o', '^', 'd', 'v', 'p'];%, 'x', 'd', 'h'];
colors = [0.8000, 0, 0; 0.4941, 0.1843, 0.5569; 0, 1, 0; 0, 0, 1; 0.3020, 0.7451, 0.9333; 0.8000, 0, 0.8000];%; 0.8510, 0.3255, 0.0980];
h = gscatter(isb(:, 8), isb(:, 9), clust(:, 6), colors, markers);
for i = 1:numel(h)
    set(h(i), 'MarkerFaceColor', colors(i, :), 'MarkerEdgeColor', colors(i, :));
end
% legend('A. Sea', 'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6', 'Location', 'north');
legend('hide');
%%
xlabel('Longitude');
ylabel('Latitude');
ylim([24 30.2]);
xlim([59.8 66.2]);
%%
ax = gca;
ax.XAxis.FontSize = 12;
ax.XAxis.FontWeight = 'bold';
ax.XAxis.Color = 'k';
ax.YAxis.FontSize = 12;
ax.YAxis.FontWeight = 'bold';
ax.YAxis.Color = 'k';
ax.Title.FontSize = 12;
ax.Title.FontWeight = 'bold';
ax.Title.Color = 'k';
ax.YAxisLocation = 'left';
ax.XAxisLocation = 'top';
adjustPosition(ax);
text(0.05, 0.95, 'a)', 'Units', 'normalized', 'Color', 'black', 'FontSize', 16);  % Adjust position as needed
%% Subplot b)
subplot(3, 3, [3, 6]);
hold on
h = gscatter(isb(:, 10), isb(:, 9), clust(:, 6), colors, markers);
for i = 1:numel(h)
    set(h(i), 'MarkerFaceColor', colors(i, :), 'MarkerEdgeColor', colors(i, :));
end
xlabel('Depth Km');
ylabel('Latitude');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6', 'Location', 'southeast')
% legend('hide');
xlim([0 165]);
ylim([24 30.2]);

%%
ax = gca;
ax.XTick = [0 50 100 150];
ax.XAxis.FontSize = 12;
ax.XAxis.FontWeight = 'bold';
ax.XAxis.Color = 'k';
ax.YAxis.FontSize = 12;
ax.YAxis.FontWeight = 'bold';
ax.YAxis.Color = 'k';
ax.Title.FontSize = 12;
ax.Title.FontWeight = 'bold';
ax.Title.Color = 'k';
ax.YAxisLocation = 'right';
ax.XAxisLocation = 'top';
adjustPosition(ax);
text(0.15, 0.95, 'b)', 'Units', 'normalized', 'Color','black', 'FontSize', 16);
%% Subplot c)
subplot(3, 3, [7, 8]);
hold on
h = gscatter(isb(:, 8), -(isb(:, 10)), clust(:, 6), colors, markers);
for i = 1:numel(h)
    set(h(i), 'MarkerFaceColor', colors(i, :), 'MarkerEdgeColor', colors(i, :));
end
xlabel('Longitude');
ylabel('Depth (km)');
% legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6', 'Location', 'southoutside');
legend('hide');
ylim([-165 0]);
xlim([59.8 66.2]);
%%
ax = gca;
ax.XAxis.FontSize = 12;
ax.XAxis.FontWeight = 'bold';
ax.XAxis.Color = 'k';
ax.YAxis.FontSize = 12;
ax.YAxis.FontWeight = 'bold';
ax.YAxis.Color = 'k';
ax.Title.FontSize = 12;
ax.Title.FontWeight = 'bold';
ax.Title.Color = 'k';
ax.YAxisLocation = 'left';
adjustPosition(ax);
text(0.85, 0.15, 'c)', 'Units', 'normalized', 'Color','black', 'FontSize', 16);
%%

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig, '-bestfit', '../OutPut/Figure5', '-dpdf');
% print(fig,'../OutPut/Figure5','-depsc');
%%