# This script will automate the process of reading in the data and cleaning
# it to a tidy data set.

# First read in the data
beers <- read.csv("Data/Beers.csv", header = T)
breweries <- read.csv("Data/Breweries.csv", header = T)

# Next we see that "beers" has a column called "Brewery_id" and "breweries"
# has a column named "Brew_ID".  These are the same thing, so rename them
# appropriately and merge the data sets on it.
names(beers) <- c("Beer_Name", "Beer_ID", "ABV", "IBU", "Brew_ID", "Style", "Ounces")
names(breweries) <- c("Brew_ID", "Brewery", "City", "State")
beerbrew <- merge(beers, breweries, by= "Brew_ID")