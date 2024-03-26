# Get the subgraph centrality
getSubgraphCentrality <- function(g) {
  return(sum(subgraph.centrality(g)) / vcount(g));
}


# Get the largest eigenvalue of the adjacency matrix
getLambda1 <- function(g) {
  e <- eigen(get.adjacency(g));
  return(max(e$values));
}

# Get the second smallest eigenvalue of the Laplacian Matrix
getMu2 <- function(g, index=2) {
  L <- graph.laplacian(g);
  e <- eigen(L);
  eigenvalues <- sort(e$values, decreasing=FALSE);
  
  return(eigenvalues[index]);
}

# Get the harmonic value
# ChesterEtAl:2012
# TODO
getHarmonic <- function(g) {
  n <- vcount(g);
  sp <- shortest.paths(g);
  
  value <- 0;
  for(i in 1:length(sp[,1])) {
    for(j in 1:length(sp[i,])) {
      if(sp[i,j] > 0) {
        value <- value + (1/sp[i,j]);
      }
    }
  }
  term <- (1/(n*(n-1)));
  res <- (1 / (term * value));
  
  return(res);
}