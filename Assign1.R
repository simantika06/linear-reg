setwd("C:/Users/roysim/Downloads/Stats831")

# Now, we need to use functions to read in specific types of data files.

# For .csv files, use read.csv().
df <- read.csv("831AssignStats1.csv")
View(df)
summary(df)
library("psych")
describe(df$Logit.CP)
hist(df$Logit.CP)
hist(df$Logit.M2E.Anticipatory)


### SIMPLE REGRESSION ####

# To run a linear regression, use the lm() function.

# We are regressing CP scores on M2E scores, from the dataframe "df".
fit <- lm(Logit.M2E.Anticipatory ~ Logit.CP, data = df)

# This is the linear model object-- we rarely examine this on its own.
fit

# Instead we tend to use the summary() function to view coefficients, etc.
summary(fit)


### GGPLOT ###

# Let's install ggplot2.
install.packages("ggplot2")

# Remember to load it.
library("ggplot2") 

# Honestly I tend to just copy-paste ggplot syntax and change what I need.
ggplot(df, aes(x = Logit.CP, y = Logit.M2E.Anticipatory)) +    # Set the data and axes
  geom_point() +                              # Request scatterplot
  geom_smooth(method = "lm", se = FALSE) +    # Request line
  annotate("text", x = 4, y = 4,             # Add regression equation from "summary(fit)"
           label = "anti=-4.16-0.116*CP")




### PREDICTION ###

# We can also make new predictions based on specific data points-- for example, the 400th observation.
# Here is the 400th observation.
df[400,]

# We're assigning this person's math quiz score to "y".
y.Logit_M2E_Anticipatory = df$Logit.M2E.Anticipatory[400]

# We're assigning this person's phobia score to "x".
x.Logit_CP = df$Logit.CP[400]
print(x.Logit_CP)

# Based on our regression line, we just plug in "x" to calculate our predicted y ("yhat").
yhat = -4.16 - 0.116*x.Logit_CP
print(yhat)

# To see what the residual (difference between observed y and predicted y), we subtract them.
new.residual = y.Logit_M2E_Anticipatory - yhat

# This is our residual for the 400th observation. 
new.residual

# We can also use the predict() function to obtain the predicted y ("yhat") for the 400th case.
predict(fit, data.frame(Logit.CP=c(x.Logit_CP)))

