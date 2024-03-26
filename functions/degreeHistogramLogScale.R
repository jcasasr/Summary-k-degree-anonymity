degreeHistogramLogScale <- function(g) {
  # candidate set size
  lis <- c(1.5,10,20,50,100);
  
  # caida2007
  dd <- degree.distribution(g, normalized = FALSE, cumulative = FALSE);
  dd <- dd * length(degree(g));
  
  setEPS();
  postscript('plots/dd-caida.eps', width=8.0, height=6.0);
  #png(file='plots/dd-caida.png', width=560, height=480, units='px', pointsize=18);
  plot(dd, type='p', log='xy', main='', xlab='Degree', ylab='Frequency', yaxt="n", xaxt='n', cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5);
  for(li in lis) {
    lines(rep(li, length(dd)), type='l', lty=2, col='grey');
  }
  axis(1, c(10^0,10^1,10^2,10^3,10^4), cex.axis=1.2) # length(degree.distribution(caida2007))
  axis(2, c(10^0,10^1,10^2,10^3,10^4), cex.axis=1.2) # max(degree(caida2007))
  dev.off();
}