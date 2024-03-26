create.hist <- function(g) {
  # degree
  d <- degree(g);
  
  # histogram
  h <- rep(0, max(d)+1);
  for(i in 1:length(h)) {
    h[i] = length(d[d==i]);
  }
  
  # verification
  td <- sum(d);
  th <- 0;
  for(i in 1:length(h)) {
      th <- th + (h[i]*i);
  }
  if(td==th) {
    show("OK");
  } else {
    show("ERROR");
  }
  
  return(h);
}

H1 <- function(g) {
  h <- create.hist(g);
  
  r <- rep(0,6);
  r[1] <- sum(h[h>0 & h<=1]);
  r[2] <- sum(h[h>1 & h<=10]);
  r[3] <- sum(h[h>10 & h<=20]);
  r[4] <- sum(h[h>20 & h<=50]);
  r[5] <- sum(h[h>50 & h<=100]);
  r[6] <- sum(h[h>100]);
  
  return(r);
}

degdist <- function(g) {
  d <- degree(g);
  
  r <- rep(0,4);
  r[1] <- sum(d[d>0 & d<=10]);
  r[2] <- sum(d[d>10 & d<=100]);
  r[3] <- sum(d[d>100 & d<=1000]);
  r[4] <- sum(d[d>1000]);
  
  return(r);
}

g <- amazon;

vrq <- H1(g);
show("H1:");
show(vrq);
show(vrq/sum(vrq)*100);

dd <- degdist(g);
show("Degree distribution:");
show(dd);
show(dd/sum(dd)*100);
