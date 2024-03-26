source('globals.R');

#################
# load datasets #
#################
polblogs <- loadDataset(paste(baseDir, "polblogs/polblogs.gml", sep=""), "gml");
polbooks <- loadDataset(paste(baseDir, "polbooks/polbooks.gml", sep=""), "gml");
