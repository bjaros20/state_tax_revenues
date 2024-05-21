#R code that merged all of the individual Excel files from FRED into a CSV

#Load Packages
library(readxl)
library(tidyr)
library(dplyr)
library(tidyverse)

#set working directory
setwd("~/Documents/GitHub/state_tax_revenues/fred_excel_files_feb_2024")

# The excel files are all saves with the state acronym in the title, followed by .xls.
#for example, Alaska is AK.xls.  The file has a first tab that describes the data.
#the second tab, titled "Annual" is what we are interested in merging.  
#It has the all of the revenue data.

#Step 1, you create a vector of state acronyms:
state_acronyms <- c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA", 
                    "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", 
                    "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", 
                    "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", 
                    "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY")

# Step 2, create a loop using list() that reads in the excel files for each state
state_dfs <- list()  

#Step 3, create a dataframe for each of those individual excel files
#remember, we want the "Annual" tab, so we put that in for sheet_name
for (state in state_acronyms) {
  file_name <- paste(state, ".xls", sep="")
  sheet_name <- "Annual"
  state_dfs[[state]] <- read_excel(file_name, sheet=sheet_name)
}


#After this step you should have a list of 50 tibbles for each of the states.
# The states will have between 7 and 11 columns, depending on if the state has 
# all of those taxes.
#The state will have up to 81 rows, depending on the years of collections.



#Step 4, access each dataframe by its acronym, because its in the title.
# This is an example, and it just creates a DF for Alaska
AK_df <- state_dfs[["AK"]]



#Step 5, merge the individual state dataframes in state_dfs on the column DATE.
#However, this will create a lot of NAs because each states doesn't have all years, example Alaska.
#Nor will each state have all collections, example Texas.

NA_df <- bind_rows(state_dfs,.id="State") %>%
  arrange(DATE)


#Step 6, create an empty final dataframe for the individual dataframes to be looped into:
final_df <- data.frame()


#Step 7, now we need to create a loop that stores each state in its own column in the final_df
counter <- 1
for (st in state_acronyms) {
  iteration <- NA_df[NA_df$State == st, ]
  iteration <- iteration[, colSums(is.na(iteration)) < nrow(iteration)]
  colnames(iteration) <- c("State", "DATE", substring(names(iteration[, 3:ncol(iteration)]), 3))
  if (counter == 1) {
    final_df <- iteration
  } else {
    final_df <- dplyr::bind_rows(final_df, iteration)
  }
  counter <- counter + 1
}

#View the final dataframe
View(final_df)


#Save For CSV
write.csv(final_df,file="FRED_SALT_Rev_Feb_2024.csv", row.names=FALSE)

