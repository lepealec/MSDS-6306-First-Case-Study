# This scripts will attempt to answer each of the questions presented in
# the "Case Study 01.pdf."

# ggplot2 is required

# Retrieve the merged data set
source("Scripts/TidyData.R")

# Answer each question

# --- Question 1 ----
# How many breweries are present in each state?
# -------------------

# Create a data.frame that contains the requested information and then
# present it in a ggplot2 barchart.

state_breweries <- as.data.frame(table(breweries$State))
names(state_breweries) <- c("State", "Breweries")
library(ggplot2)
p1 <- ggplot(state_breweries, aes(x= State, y= Breweries, fill=State)) + 
  geom_bar(stat="identity") + 
  geom_text(aes(label= Breweries), vjust= -0.3, size= 2) + 
  scale_y_continuous(expand = c(0,0)) + 
  geom_text(aes(x= 1, y= 50, label= " "), vjust= -1)
p1 <- p1 + labs(title="Number of Breweries by State", x ="State", 
              y = "Number of Breweries",
              caption = "NOTE: While not a state, Washington D.C. has its own entry.")
p1 <- p1 + theme(plot.title = element_text(hjust= 0.5))
p1 <- p1 + theme(axis.text.x= element_text(size= 8, angle= 90)) + 
  guides(fill=FALSE)
p1 <- p1 + theme(plot.caption = element_text(hjust = 0.5))

# --- Question 2 ----
# Merge beer data with the breweries data. Print the first 6
# observations and the last six observations to check the merged file.

head(beerbrew)
tail(beerbrew)

# --- Question 3 ----
# Report the number of NA's in each column.

# Iterate through each column and report the number of NAs
# (Alec, you probably have a cleaner way of doing this)
for (column in names(beerbrew)){
  if (any(is.na(beerbrew[[column]]))){
    NAs <- sum(is.na(beerbrew[[column]]))
    print(paste(column, "has ", NAs, "NA values"))
  }
}

# --- Question 4 ----
# Compute the median alcohol content and international
# bitterness unit for each state. Plot a bar chart to compare.

# (Again Alec, I'm sure you know a better way to do this)

alcohol <- data.frame(State= state_breweries[[1]])
for (state in alcohol$State){
  ABVs <- beerbrew$ABV[which(beerbrew$State== state)]
  IBUs <- beerbrew$IBU[which(beerbrew$State== state)]
  alcohol$ABV[which(alcohol$State == state)] <- median(ABVs, na.rm = T)
  alcohol$IBU[which(alcohol$State == state)] <- median(IBUs, na.rm = T)
}
# Melt the data.frame
library(reshape2)
alcohol <- melt(alcohol, rm.na= T)
names(alcohol) <- c("State", "Metric", "Value")
# One NA value is found corresponding to IBU for SD.  I replace it with 0.
alcohol$Value[which(is.na(alcohol$Value))] <- 0
# Make ABV values negative for proper display on the barplot
alcohol$Value[as.character(alcohol$Metric)=="ABV"] <- -100*alcohol$Value[as.character(alcohol$Metric)=="ABV"]
# Create the barplot
p2 <- ggplot(alcohol, aes(x= State, y= Value, fill= Metric)) + 
  geom_bar(stat="identity") +
  geom_text(aes(label= ifelse(Value>0, Value, -1*Value)), vjust= -0.3, size= 2) +
  scale_y_continuous(expand= expand_scale()) +
  geom_text(aes(x=1, y= 65, label=" "), vjust=-1)
p2 <- p2 + labs(title= "Median Alcohol Metrics by State", x ="State", 
              y = "ABV (%) and IBU (ppm isohumulone)",
              caption = "NOTE: SD has no information on IBU, thus 0 was used.")
p2 <- p2 + theme(plot.title = element_text(hjust= 0.5))
p2 <- p2 + theme(axis.text.x= element_text(size= 8, angle= 90)) + 
  guides(fill=FALSE)
p2 <- p2 + theme(plot.caption = element_text(hjust = 0.5))

# --- Question 5 ----
# Which state has the maximum alcoholic (ABV) beer? Which
# state has the most bitter (IBU) beer?

print(paste(beerbrew$State[which(beerbrew$ABV==max(beerbrew$ABV, na.rm=T))],
            "has the highest ABV at", max(beerbrew$ABV, na.rm=T)))
print(paste(beerbrew$State[which(beerbrew$IBU==max(beerbrew$IBU, na.rm=T))],
            "has the highest IBU at", max(beerbrew$IBU, na.rm=T)))

# --- Question 6 ----
# Summary statistics for the ABV variable.

print(summary(beerbrew$ABV))

# --- Question 7 ----
# Is there an apparent relationship between the bitterness of the
# beer and its alcoholic content? Draw a scatter plot.

p3 <- ggplot(beerbrew, aes(x= beerbrew$IBU, y= beerbrew$ABV*100)) + 
  geom_point(stat="identity") +
  scale_y_continuous(expand= expand_scale()) +
  scale_x_continuous(expand= expand_scale())
p3 <- p3 + labs(title= "IBU versus ABV", x ="IBU (ppm isohumulone)", 
              y = "ABV (%)",
              caption = "NOTE: 1005 rows containig missing values were omitted.")
p3 <- p3 + theme(plot.title = element_text(hjust= 0.5))
p3 <- p3 + theme(axis.text.x= element_text(size= 8, angle= 90)) + 
  guides(fill=FALSE)
p3 <- p3 + theme(plot.caption = element_text(hjust = 0.5))