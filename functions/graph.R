getDegreeHistogramFromDegreeSequence <- function(d) {
  labels <- 0:max(d);
  h <- rep.int(0,length(labels));
  for (i in 1:length(h)) {
    h[i] <- sum(d==labels[i]);
  }
  
  # return
  return(h);
}

# Get k-anonymity value
# -h: degree histogram
# @return: k-anonymity value
getKAnonymityValueFromHistogram <- function(h) {
  return(min(h[h>0]));
}

getKAnonymityValueFromDegreeSequence <- function(d) {
  return(getKAnonymityValueFromHistogram(getDegreeHistogramFromDegreeSequence(d)));
}

getKAnonymityValueFromGraph <- function(g) {
  return(getKAnonymityValueFromDegreeSequence(degree(g)));
}

#
edgeIntersection <- function(g1, g2) {
  logdebug("edgeIntersection: Starting...");
  numNodesG1 <- length(V(g1));
  numNodesG2 <- length(V(g2));
  
  if(numNodesG1 != numNodesG2) {
    logerror("edgeIntersection: ERROR: Different number of nodes G1=%d and G2=%d",numNodesG1, numNodesG2);
    
    retutrn(NA);
  } else {
    numEdgesG1 <- length(E(g1));
    numEdgesG2 <- length(E(g2));
    total <- max(numEdgesG1,numEdgesG2);
    inter <- 0;
    
    # use matrix
    mG1 <- get.adjacency(g1);
    mG2 <- get.adjacency(g2);
    
    # count number of equal edges
    if(is.directed(g1) && is.directed(g2)) {
      stop("NOT YET IMPLEMENTED!");
        
    } else {
      mA <- mG1 * mG2;
      inter <- sum(mA[mA>0]);
      # undirected
      inter <- inter/2;
    }
    
    loginfo("edge_intersection: datasets G1=%d and G2=%d", numEdgesG1, numEdgesG2);
    loginfo("edge_intersection: Edge intersection(G1,G2) = %d/%d [%.2f %%]", inter, total, ((inter/total)*100),"%");
    
    return(inter);
  }
}