
# compute the NC
polbooks_nc <- edgeNeighbourhoodCentrality(polbooks);
polblogs_nc <- edgeNeighbourhoodCentrality(polblogs);
grqc_nc <- edgeNeighbourhoodCentrality(grqc);

plotNC <- function(values, fileName) {
    setEPS();
    postscript(paste(fileName, ".eps", sep=""), width=8.0, height=6.0);
    plot(sort(values), type='l', col='red', xlab='Edges', ylab="NC score", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5);
    dev.off();
}

plotNC(polbooks_nc, "polbooks-nc");
plotNC(polblogs_nc, "polblogs-nc");
plotNC(grqc_nc, "grqc-nc");
