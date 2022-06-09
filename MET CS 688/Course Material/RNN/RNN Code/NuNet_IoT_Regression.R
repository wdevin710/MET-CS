# Using RSNNS on Xcel Data
rm(list=ls()); cat("\014") # clear all
library("RSNNS")

# Read Raw Data
Import.Files <- file.path("Data","EIS_Data.csv")
temp.CSV <- read.csv(Import.Files,stringsAsFactors = FALSE,blank.lines.skip = TRUE,header=T)

# Split the Data 
inputs <- temp.CSV$Actual.Consumption..kWh. # Actual Consumption - used for training
targets <- temp.CSV$Expected.Consumption..kWh. # Expected Consumption (Regression data) used as Tags
inputs.scale <- max(inputs); targets.scale <- max(targets); 
inputs.normalized <- inputs/inputs.scale; targets.normalized <- targets/targets.scale # Normalize Data
patterns <- splitForTrainingAndTest(inputs.normalized, targets.normalized, ratio = 0.15) # Split the input data into train and test ratio=0.15


# Plot the data
ymax <- inputs.scale; xmax <- 100
plot(c(0,xmax),c(0,ymax),type = "n",xlab = "Day Index", ylab = "Consumed kWh/day",main = "Regression Model Fit to the Actual")
lines(inputs[1:xmax],col="green",lwd=2.5) # Plot Data 1
lines(targets[1:xmax],col="red",lwd=2.5) # Plot Data 2
legend(0.0,2e4, # places a legend at the appropriate place 
       c("Actual","Regression"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("green","red")) # gives the legend lines the correct color and width

# Train NN to folow Actual 
# The use of an Elman network (Elman 1990) for time series regression. 
model <- elman(patterns$inputsTrain, patterns$targetsTrain,
               size = c(8, 8), learnFuncParams = c(0.1), maxit = 500,
               inputsTest = patterns$inputsTest, targetsTest = patterns$targetsTest,
               linOut = FALSE)

NN.fitted.Train <- model$fitted.values*inputs.scale 
NN.fitted.Test <- model$fittedTestValues*targets.scale 

# Plot Train Values
ymax <- 1; xmax <- 100 # length(NN.fitted.Train)
plot(c(0,xmax),c(0,ymax),type = "n",xlab = "Day Index", ylab = "Consumed kWh/day",main = "NN Trained to follow Actual Consumption and Fit the Regression Model")
lines(patterns$inputsTrain[1:xmax],col="green",lwd=2.5) # Plot Data 1 - Train 
lines(patterns$targetsTrain[1:xmax],col="red",lwd=2.5) # Plot Data 2 - Targets
lines(model$fitted.values[1:xmax], col = "blue",lwd=2.5)  # Plot Data 3 predicted
legend(0.0,0.3, # places a legend at the appropriate place 
       c("Actual","Regression","NN Modeled"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("green","red","blue")) # gives the legend lines the correct color and width

# Plot Test Values
ymax <- targets.scale; xmax <- length(patterns$inputsTest)
plot(c(0,xmax),c(0,ymax),type = "n",xlab = "Day Index", ylab = "Consumed kWh/day",main = "NN Trained to follow Actual Consumption and Fit the Regression Model")
lines(patterns$inputsTest*inputs.scale,col="green",lwd=2.5) # Plot Data 1 - Train 
lines(patterns$targetsTest*targets.scale,col="red",lwd=2.5) # Plot Data 2 - Targets
lines(model$fittedTestValues*targets.scale, col = "blue",lwd=2.5)  # Plot Data 3 predicted
legend(0.0,2e4, # places a legend at the appropriate place 
       c("Actual","Regression","NN Modeled"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("green","red","blue")) # gives the legend lines the correct color and width

# Plot Errors
# Regression plot for the training data, showing an optimal linear fit (black), and linear fit to the training data (red).
plotRegressionError(patterns$targetsTrain, model$fitted.values)
# Regression plot for the test data. 
plotRegressionError(patterns$targetsTest, model$fittedTestValues)




###------ rnn implementation ------- 
library(rnn)
InputsTrain <- t(patterns$inputsTrain) # Make Row Vectors
TargetTrain <- t(patterns$targetsTrain) # Make Row Vectors

# Train model. Keep out the last two sequences.
model <- trainr(Y = TargetTrain, # Target 
                X = InputsTrain, # Input 
                learningrate = 0.1,
                hidden_dim = 5,
                numepochs = 10)

# Predicted values
# InputsTest = patterns$inputsTest
X <- t(inputs.normalized)
NN.fitted <- predictr(model, X)

plot(c(0,length(NN.fitted)),c(0,1),type = "n",xlab = "Day Index", ylab = "Consumed kWh/day",main = "RNN Trained to follow Actual Consumption and Fit Xcel Model")
lines(NN.fitted,col="green",lwd=2.5) # Plot Data 1 - Train 
legend(0.0,0.2, # places a legend at the appropriate place 
       c("NN Modeled"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("green")) # gives the legend lines the correct color and width

NN.fitted.Train <- NN.fitted[1:length(patterns$inputsTrain)]
NN.fitted.Test <- NN.fitted[(length(patterns$inputsTrain)+1):length(NN.fitted)]

# Plot Test Values
ymax <- targets.scale; xmax <- length(patterns$inputsTest)
plot(c(0,xmax),c(0,ymax),type = "n",xlab = "Day Index", ylab = "Consumed kWh/day",main = "RNN Trained to follow Actual Consumption and Fit Xcel Model")
lines(patterns$inputsTest*inputs.scale,col="green",lwd=2.5) # Plot Data 1 - Train 
lines(patterns$targetsTest*targets.scale,col="red",lwd=2.5) # Plot Data 2 - Targets
lines(NN.fitted.Test*targets.scale, col = "blue",lwd=2.5)  # Plot Data 3 predicted
legend(0.0,2e4, # places a legend at the appropriate place 
       c("Actual","Regression","NN Modeled"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("green","red","blue")) # gives the legend lines the correct color and width

#



