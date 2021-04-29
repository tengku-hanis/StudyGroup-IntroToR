## ===========================================================================
## Study group: Loop and function in R (brief)
## Author: Tengku Hanis
## Date: 29-04-2021
## ===========================================================================

##-------------- Loops
# For loops
for (i in 1:5) {
  print(i)
}

# While loops
i <- 0
while (i <= 4) {
  i <- i + 1
  print(i)
}

##-------------- More practical application 
set.seed(2021)
xlist <- list(col1 = rnorm(10000000), 
              col2 = rnorm(10000000),
              col3 = rnorm(100000000),
              col4 = rnorm(1000000))
str(xlist)

# Loop
ptm <- proc.time() #-- start the clock

mean_loop <- vector("list", 0) # place holder for a value
for (i in seq_along(xlist)) {
  mean_loop[[i]] <- mean(xlist[[i]])
}
mean_loop

proc.time() - ptm #-- stop the clock (time in seconds)

# Apply family
ptm <- proc.time() #-- start the clock

mean_apply <- lapply(xlist, mean)
mean_apply

proc.time() - ptm #-- stop the clock

sapply(xlist, mean)

##-------------- Make function
# Function to multiply numeric predictor in iris with 10
multiply10 <- function(var){
  var*10
}

lapply(iris[,1:4], multiply10)

