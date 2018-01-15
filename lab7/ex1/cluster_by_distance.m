function bins = cluster_by_distance(X, threashold)
    %CLUSTER_BY_DISTANCE Cluster a dataset X based on the pairwise distance
    %between its point. Distances are computed using the euclidian one.
    
    % compute the distances between each point
    distances = pdist2(X, X, 'euclidean');

    % tranform the distances matrix to the matrix that describes a directed
    % graph having an edge between 2 point iff their distance is < threashold
    % 1 == edges are connected, 0 == edges are not connected
    graph_matrix = distances < threashold;
    G = graph(graph_matrix, 'upper', 'OmitSelfLoops');

    % find the connected components of the graph, i.e. our clusters
    bins = conncomp(G)';
end
