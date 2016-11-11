
#Read in data
data <- read.table("nyt1.csv",header=TRUE, ",")
class(data)
bins <- c(<18,18-24,25-34,35-44,45-54,55-64,>64)
data$CTR = c()
