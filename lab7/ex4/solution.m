clf; close all; clear; clc;

% load the data
provinces = {
    'South Holland'
    'North Holland'
    'Utrecht'
    'Limburg'
    'North Brabant'
    'Gelderland'
    'Overijssel'
    'Flevoland'
    'Groningen'
    'Zeeland'
    'Friesland'
    'Drenthe'
};
X = importdata('data/provinces.mat');
assert(size(provinces, 1) == size(X, 1));
n = size(X, 1);

% normalize (z-transform)
Z = (X - mean(X, 1)) ./ std(X, [], 1);

% compute the dissimilarity matrix
distances = pdist2(Z, Z, 'euclidean');

% remove the diagonal from the distances matrix
d = distances + diag(nan(n, 1));

% extract the index of the province Groningen
index = find(strcmp(provinces, 'Groningen'));

% question 3: most similar to Groningen = lowest distance
[dissimilarity_most, index_most_similar] = min(d(index, :));
most_similar = provinces{index_most_similar};
fprintf('[Q3]: the most similar province to Groningen is %s, dissimilatiry = %f\n', ...
    most_similar, dissimilarity_most);

% question 4: least similar to Groningen = biggest distance
[dissimilarity_least, index_least] = max(d(index, :));
least_similar = provinces{index_least};
fprintf('[Q5]: the least similar province to Groningen is %s, dissimilatiry = %f\n', ...
    least_similar, dissimilarity_least);
