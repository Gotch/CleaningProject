run_analysis <- function(dir) {
  setwd(dir)
  
  # get activity and feature labels
  features <- read.table("features.txt")
  activity_labels <- read.table("activity_labels.txt")
  
  ## get files from test folder
  setwd("./test")
  subject_test <- read.table("subject_test.txt")
  X_test <- read.table("X_test.txt")
  Y_test <- read.table("Y_test.txt")
  setwd("../")
  
  ## get files from train folder
  setwd("./train")
  subject_train <- read.table("subject_train.txt")
  X_train <- read.table("X_train.txt")
  Y_train <- read.table("Y_train.txt")  
  setwd("../")
  
  ##Extracts only mean and standard deviation measurements
  mean_set <-features[which(grepl("mean()", features$V2)==TRUE),]
  std_set <-features[which(grepl("std()", features$V2)==TRUE),]
  meanstd_featuresset <- merge(mean_set,std_set, all = TRUE)
  featuresvector <- meanstd_featuresset[,1]
  x_test_meanstd <- X_test[,featuresvector]
  x_train_meanstd <- X_train[,featuresvector]
  
  ## uses more descriptive column names
  colnames(x_test_meanstd) <- meanstd_featuresset[,2]
  colnames(x_train_meanstd) <- meanstd_featuresset[,2]
  
  ##Joins subject and activity labels to data frames
  x_test_meanstd$Activity <- Y_test[,1]
  x_train_meanstd$Activity <- Y_train[,1]
  x_test_meanstd$Subject <- subject_test[,1]
  x_train_meanstd$Subject <- subject_train[,1]
  
  ##merges test and training sets
  Results <- merge(x_test_meanstd,x_train_meanstd,all = TRUE)
  Results$Activity <- factor(Results$Activity,levels = activity_labels[,1], labels = activity_labels[,2])
  Results <- Results[,c(80,81,1:79)]
  Results <- Results[order(Results$Activity,Results$Subject),]
  Results$Subject <- as.factor(Results$Subject)
  ##Data is now ready to be summarized
  
  ## Exports Tidy Data Summary
  install.packages("reshape2")
  library(reshape2)
  Resultsmelt <- melt(Results, id = c("Activity","Subject"), measure.vars = meanstd_featuresset[,2])
  ResultsSummary <- dcast(Rmelt, Activity + Subject ~ variable, mean)
  ResultsSummary
  write.table(ResultsSummary,"ResultSummary.txt",row.names = FALSE)
}