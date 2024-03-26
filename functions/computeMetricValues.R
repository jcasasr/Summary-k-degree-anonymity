# Compare netqorks
computeMetricValues <- function(datasetDir, datasetName, extension, kSet, s, e, mSet, algorithm) {
  # values: "metric" x "k-value"
  values <- array(data=NA, dim=c(length(mSet), length(kSet)), dimnames=list(mSet, kSet));
  
  # load all metric data into "values"
  for(m in mSet) {    
    for(k in kSet) {
      logdebug("*** Metric: %s, k=%s", m, k);
      
      # load graph
      if(algorithm == "UMGA") {
        # UMGA
        filename <- paste(datasetName, "-k", k, "-", s,"-", e, sep="");
      } else if(algorithm == "EAGA") {
        # EAGA
        filename <- paste(datasetName, "-k=", k, sep="");
      }
      filenameAbsolut <- paste(datasetDir, filename, ".", extension, sep="");
      g <- loadDataset(filenameAbsolut, "gml");
      
      # compute metric 'm'
      filenameMetric <- paste(datasetDir, "data/", filename, "-", m, ".RData", sep="");
      values[m, as.character(k)] <- getMetricValue(g, filenameMetric, m);
    }
  }
  
  # summary
  summary <- array(data=NA, dim=c(length(mSet), 1), dimnames=list(mSet, "NC"));
  for(m in mSet) { 
    logdebug("*** Summary metric: %s", m);
    
    # export data
    filename <- paste(datasetName, "-", m, ".txt", sep="");
    filenameAbsolut <- paste(datasetDir, "results/", filename, sep="");
    write.table(values[m,], file=filenameAbsolut, append=FALSE, sep = "\t", row.names=TRUE, col.names=TRUE);
    
    summary[m,"NC"] <- getAverageError(values[m,]);
  }
  
  # export data
  filename <- paste(datasetName, ".txt", sep="");
  filenameAbsolut <- paste(datasetDir, "results/", filename, sep="");
  write.table(summary, file=filenameAbsolut, append=FALSE, sep = "\t", row.names=TRUE, col.names=TRUE);
  
  # plotting
  for(m in mSet) { 
    logdebug("*** Plotting metric: %s", m);
    
    # export plot
    filename <- paste(datasetName, "-", m, "-[RGB]", ".png", sep="");
    filenameAbsolut <- paste(datasetDir, "plots/", filename, sep="");
    getPlot(filenameAbsolut, values[m,]);
  }
  
  # save results
  filename <- paste(datasetName, ".RData", sep="");
  filenameAbsolut <- paste(datasetDir, "results/", filename, sep="");
  save(values, file=filenameAbsolut);
}

#############
# FUNCTIONS #
#############
getMetricValue <- function(g, filenameMetric, metric) {
    
    if(file.exists(filenameMetric)) {
        # metric exists, load file
        logdebug("+++ Loading %s...", metric);
        
        load(filenameMetric);
        
    } else {
        # metric does not exist, compute it
        logdebug("+++ Computing %s...", metric);
        
        if(metric == 'lambda1') {
            # lambda_1
            value <- getLambda1(g);
        } else if(metric == 'mu2') {
            # mu_2
            value <- getMu2(g);
        } else if(metric == 'AD') {
            # Average distance
            value <- average.path.length(g, directed=FALSE);
        } else if(metric == 'D') {
            # Diameter
            value <- diameter(g, directed=FALSE);
        } else if(metric == 'T') {
            # Transitivity
            value <- transitivity(g, type="global", isolates=NaN);
        } else if(metric == 'EI') {
            # Edge intersection
            value <- edgeIntersection(G_ORIGINAL, g);
        } else if(metric == 'SC') {
            # Subgraph centrality
            value <- getSubgraphCentrality(g);
        } else if(metric == 'h') {
            # Harmonic
            value <- getHarmonic(g);
        } else if(metric == 'Q') {
            # Modularity
            value <- modularity(g, communities);
        }
        
        # save data
        save(value, file=filenameMetric);
    }
    
    return(value);
}

getPlot <- function(filenameAbsolut, series) {
    ymin <- min(series, na.rm=TRUE);
    ymax <- max(series, na.rm=TRUE);
    
    bw <- c("black", "black");
    colors <- c("red", "blue");
    lty <- c(1, 2);
    
    #setEPS();
    #postscript(paste(fileName, "[BW].eps", sep=""), width=8.0, height=6.0);
    png(filename=filenameAbsolut);
    par(mai=c(0.5,0.5,0.5,0.5),omi=c(0.1,0.1,0.1,0.1));
    plot (series, type="l", lty=lty[1], col=colors[1], ylim=c(ymin, ymax), main="", xlab="", ylab="", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5);
    #legend(x="top", legend=c(names(series[1,])), ncol=2, bty="n", col=colors, lty=lty, lwd=2, cex=1.5);
    dev.off();
}

getErrorTotal <- function(values) {
    return(sum(abs(values-values[1])));
}

getAverageError <- function(values, numDec=3) {
    return(round(mean(abs(values-values[1])), numDec));
}