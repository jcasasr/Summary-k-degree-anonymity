# load, clean ans save datasets
k <- 1:10;
type <- "gml";
path <- "../Summary-k-degree-anonymity-datasets/polblogs-EAGA/";
name <- "polblogs"

for(i in k) {
  filename <- paste(path, name, "-k=", i, ".gml", sep="");
  loadAndCorrectDataset(filename, type);
}