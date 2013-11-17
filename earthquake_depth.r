# Samuel Crane
# https://github.com/samuelcrane
# 
# This plot described at http://www.samuelcrane.com/blog/earthquakes
# Earthquake data downloaded from http://earthquake.usgs.gov/earthquakes/search/


library('ggplot2')
eq20k <- read.csv('eq20k.csv')

# Formatting for all plots
cols <- c("FALSE" = "firebrick2","TRUE" = "steelblue")
Title <- 'Earthquake Magnitude versus Origin Depth\n(Worldwide, n = 20,000)'

# Define the depth threshold for the seismogenic layer
`Origin Depth` <- factor(eq20k$depth<=15)

# Make scatterplot without transformation
depths <- ggplot(eq20k, aes(x=mag, y=depth)) 
depths <- depths + geom_point(aes(color=`Origin Depth`),shape=1)
depths <- depths + labs(title = Title, x = "Magnitude", y = "Depth (km)") 
depths <- depths + scale_colour_manual(values=cols, labels = c("Greater than 15 km", "Less than 15 km"))
depths

# Make copy of original data to manipulate negative and 0 values
cleaned_eq20k <- eq20k

# Set negative values to zero
cleaned_eq20k$depth[cleaned_eq20k$depth < 0.0000] <- 0.0000

# Remove zero values by adding 1.0000 to all values
cleaned_eq20k$depth <- cleaned_eq20k$depth + 1.0000

# Check values of depth
depth_list <- sort(cleaned_eq20k$depth)

# Change the depth threshold because of the transformation:
`Origin Depth` <- factor(cleaned_eq20k$depth<=16)

# Make scatterplot with log-transformation
log_depths <- ggplot(cleaned_eq20k, aes(x=mag, y=log(depth))) 
log_depths <- log_depths + geom_point(shape=1, aes(color=`Origin Depth`))
log_depths <- log_depths + labs(title = Title, x = "Magnitude", y = "log(Depth + 1)") 
log_depths <- log_depths + scale_colour_manual(values=cols, labels = c("Greater than 15 km", "Less than 15 km"))
log_depths 
