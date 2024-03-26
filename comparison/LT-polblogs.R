library(igraph);

source('globals.R');

# Params
datasetdir <- paste(baseDir, "polblogs/", sep="");
name <- "polblogs";

# Read the original graph
g <- read.graph(paste(datasetdir, "/", name,".gml", sep=""), format="gml");
g <- simplify(g, remove.loops=TRUE, remove.multiple=TRUE);
g <- as.undirected(g, mode="collapse");

# Save the communities/labels (in order to compute the modularity)
# Node "value" attributes indicate political leaning according to:
# - 0 (left or liberal)
# - 1 (right or conservative)
communities <- V(g)$value;
communities <- as.integer(communities);

# Results of Liu&Terzi's algorithm
LT_lambda1 <- c(74.08, 74.89, 74.50, 75.16, 75.10, 76.32, 75.82, 76.67, 77.42, 78.42);
LT_mu2 <- c(0.168, 0.168, 0.168, 0.168, 0.168, 0.168, 0.168, 0.168, 0.168, 0.168);
LT_gloefi <- c(2.506, 2.500, 2.484, 2.494, 2.475, 2.469, 2.461, 2.462, 2.486, 2.458);
LT_modul <- c(0.405, 0.402, 0.401, 0.401, 0.396, 0.394, 0.395, 0.389, 0.387, 0.385);
LT_trans <- c(0.226, 0.225, 0.223, 0.224, 0.221, 0.222, 0.220, 0.219, 0.221, 0.221);
LT_sc <- c(1.21e+29, 2.73e+29, 1.87e+29, 3.61e+29, 3.40e+29, 1.45e+29, 6.94e+29, 6.25e+29, 4.46e+29, 4.04e+29);

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
print(round(LT_sc / 10^29, 3));
print(paste("Average Error = ", getAverageError(LT_sc / 10^29), sep=""));
