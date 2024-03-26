library(igraph);

source('globals.R');

# dataset
dataset <- "polblogs";
mSet <- c("lambda1", "mu2", "AD", "h", "T", "SC", "EI", "D");

########
# MAIN #
########
if(dataset == "polbooks") {
    datasetDir <- paste(baseDir, "polbooks-UMGA/", sep="");
    datasetName <- "polbooks";
    extension <- "gml";
    kSet <- 1:10;
    s <- "E"
    e <- "NC";
    
    # ***** XUNGO!!!!!
    G_ORIGINAL <- loadDataset(paste(datasetDir, datasetName, ".", extension, sep=""), "gml");
    # Save the communities/labels (in order to compute the modularity)
    # Nodes have been given values "l", "n", or "c" to indicate whether they are "liberal", "neutral", or "conservative".
    mSet <- c(mSet, "Q");
    communities <- V(G_ORIGINAL)$value;
    communities[communities=='n'] <- 0;
    communities[communities=='c'] <- 1;
    communities[communities=='l'] <- 2;
    communities <- as.integer(communities);
    COMMUNITIES <- communities;
} else if(dataset == "polblogs") {
    datasetDir <- paste(baseDir, "polblogs-UMGA/", sep="");
    datasetName <- "polblogs";
    extension <- "gml";
    kSet <- 1:10;
    s <- "E";
    e <- "NC";
    
    # ***** XUNGO!!!!!
    G_ORIGINAL <- loadDataset(paste(datasetDir, datasetName, ".", extension, sep=""), "gml");
    # Save the communities/labels (in order to compute the modularity)
    # Node "value" attributes indicate political leaning according to:
    # - 0 (left or liberal)
    # - 1 (right or conservative)
    mSet <- c(mSet, "Q");
    communities <- V(G_ORIGINAL)$value;
    communities <- as.integer(communities);
    COMMUNITIES <- communities;
} else {
    logerror("Dataset Error!");
    stop();
}

computeMetricValues(datasetDir, datasetName, extension, kSet, s, e, mSet, "UMGA");
