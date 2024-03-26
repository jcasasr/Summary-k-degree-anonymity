library(igraph);

source('globals.R');

# Results of Liu&Terzi's algorithm
Chester_h <- c(2.51, 2.51, 2.49, 2.48, 2.48, 2.46, 2.46, 2.45, 2.44, 2.43);
Chester_T <- c(0.226, 0.219, 0.215, 0.207, 0.205, 0.200, 0.226, 0.190, 0.185, 0.183);
Chester_SC <- c(1.21e+29, 1.30e+29, 1.41e+29, 2.16e+29, 2.88e+29, 2.66e+29, 5.55e+29, 5.37e+29, 11.00e+29, 8.25e+29);

# Compute the average value
print("*** h ***");
print(round(Chester_h, 3));
print(paste("Average Error = ", getAverageError(Chester_h), sep=""));

print("*** T ***");
print(round(Chester_T, 3));
print(paste("Average Error = ", getAverageError(Chester_T), sep=""));

print("*** SC ***");
print(round(Chester_SC / 10^29, 3));
print(paste("Average Error = ", getAverageError(Chester_SC / 10^29), sep=""));
