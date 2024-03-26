library(igraph);

source('globals.R');

# DATASET
name <- "polbooks";

# params
datasetdir <- paste(baseDir, name, "-UMGA/", sep="");
print(paste("*****", name, "*****"));

# load values
load(paste(datasetdir, "results/", name, ".RData", sep=""));

# Compute the average value
mSet <- c("lambda1", "mu2", "AD", "h", "T", "SC", "EI", "D", "Q");
for(m in mSet) {
  # number of decimals
  numDec <- 3;
  if(m == "lambda1") {
    numDec <- 2;
  }
  # 
  v <- values[m, ];
  if(m == "SC") {
    if(name == "polblogs") {
      v <- v / 10^29;
    } else if(name == "polbooks") {
      v <- v / 10^3;
    }
  }
  
  print(paste("***", m, "***"));
  print(round(v, numDec));
  print(paste("Average Error = ", getAverageError(v), sep=""));
}
