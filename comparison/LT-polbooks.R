library(igraph);

source('globals.R');

# Params
datasetdir <- paste(baseDir, "polbooks/", sep="");
name <- "polbooks";

# Read the original graph
g <- read.graph(paste(datasetdir, "/", name,".gml", sep=""), format="gml");
g <- simplify(g, remove.loops=TRUE, remove.multiple=TRUE);

# Save the communities/labels (in order to compute the modularity)
# Nodes have been given values "l", "n", or "c" to indicate whether they are "liberal", "neutral", or "conservative".
communities <- V(g)$value;
communities[communities=='n'] <- 0;
communities[communities=='c'] <- 1;
communities[communities=='l'] <- 2;
communities <- as.integer(communities);

# Results of Liu&Terzi's algorithm
LT_lambda1 <- c(11.93, 12.00, 12.05, 12.11, 12.22, 12.30, 12.31, 12.64, 12.72, 12.85);
LT_mu2 <- c(0.32, 0.43, 0.45, 0.60, 0.60, 0.79, 0.63, 0.65, 0.97, 0.88);
LT_gloefi <- c(2.45, 2.35, 2.32, 2.28, 2.28, 2.23, 2.27, 2.26, 2.20, 2.19);
LT_modul <- c(0.40, 0.39, 0.39, 0.38, 0.38, 0.36, 0.37, 0.37, 0.34, 0.35);
LT_trans <- c(0.34, 0.33, 0.33, 0.32, 0.33, 0.30, 0.31, 0.32, 0.29, 0.30);
LT_sc <- c(2520, 2480, 2560, 2530, 2760, 2440, 2680, 3600, 3580, 4120);

# apply
# Compute the average value
print("*** lambda1 ***");
print(round(LT_lambda1, 2));
print(paste("Average Error = ", getAverageError(LT_lambda1), sep=""));

print("*** mu2 ***");
print(round(LT_mu2, 3));
print(paste("Average Error = ", getAverageError(LT_mu2), sep=""));

print("*** h ***");
print(round(LT_gloefi, 3));
print(paste("Average Error = ", getAverageError(LT_gloefi), sep=""));

print("*** Q ***");
print(round(LT_modul, 3));
print(paste("Average Error = ", getAverageError(LT_modul), sep=""));

print("*** T ***");
print(round(LT_trans, 3));
print(paste("Average Error = ", getAverageError(LT_trans), sep=""));

print("*** SC ***");
print(round(LT_sc / 10^3, 3));
print(paste("Average Error = ", getAverageError(LT_sc / 10^3), sep=""));
