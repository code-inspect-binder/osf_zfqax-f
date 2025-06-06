# R script for: Social Ball: An immerse research paradigm for social ostracism
# Study 1: Manipulation effectiveness
# Author: 

# Date: 13/07/2022

# To reproduce the analyses in the manuscript please first run steps 0 to 4. 
# this will ensure that all the required libraries are loaded and 
# variables required for analyses are created.
# When you go to the ANALYSES section, you can find the results. 

#NOTE: We created an alternative data set because this study was
# part of a larger project and we only want to use relevant variables. The code used to create this data set can be found at the end of the script. 

# 0. libraries and settings --------------

##libraries 
library(psych); library(magrittr); library(lme4); library(jtools); library(pscl); library(readxl); library(openxlsx); library(tidyverse); library("rstanarm"); library(see); library("sjstats")

stderror <- function(x) sd(x)/sqrt(length(x)) # to use in graphs
options(scipen = 999) 
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7") #colorblind friendly color palette for graphs

# 1. importing the data ------

##import the data file 
data <- read_xlsx("data/data_for_study_1.xlsx")

## 2. create data frames to work on ## 

# exclude unfinished responses
data <-filter(data, Finished == 1)

## rename the attention check questions to reflect that they are attention checks
data <- rename(data, 
               attentioncheck1 = attention_check_1,
               attentioncheck2 = catch_like_5)

# exclude participants who fail the attention checks
## correct answer in the 1st attention check is "This was a ball-tossing game" == 1
## correct answer for the 2nd attention check is "3"

data <- filter(data, attentioncheck2 == 3 | attentioncheck1 == 1)
glimpse(data)

# 3 person(s) failed both N = 247

## reverse code items 
## belonging 1, 2, 3; MExistence 1,2,3; 
data <- mutate(data,
               belonging_t1_1 = 6 - belonging_t1_1,
               belonging_t1_2 = 6 - belonging_t1_2,
               belonging_t1_3 = 6 - belonging_t1_3,
               existence_t1_1 = 6 - existence_t1_1,
               existence_t1_2 = 6 - existence_t1_2,
               existence_t1_3 = 6 - existence_t1_3)


## age recored as 1 = 18, to correct we added 17 to all age variables
data$age <- data$age + 17 

# emotions are labeled as mood, so we relabel them 
data <- rename(data, 
               anger_t1 = mood_t1_1,
               sadness_t1 = mood_t1_2,
               hurt_t1 =mood_t1_3)

# rename belonging 
data <- rename(data,
               belonging = catch_belonging)


# 3. demographics & some descriptive statistics ------
# gender
# 1 female, 2 male, 3 other
data$gender
table(data$gender)

data$age
describe(data$age)

table(data$belonging, data$share)

# how long did the filler task take? 
data$feedbacktime <-
  data$catch_timer1_Page_Submit + 
  data$catch_timer2_Page_Submit

describe(data$feedbacktime)

table(
  data$prev_cyberball, 
  data$belonging)

# 4. creating variables and calculating alphas------
#belonging
data$belonging_t1 <- 
  rowMeans(dplyr::select(
    data, 
    belonging_t1_1,
    belonging_t1_2, 
    belonging_t1_3)
    )

alpha_belonging_t1 <- 
  dplyr::select(
    data, 
    belonging_t1_1, 
    belonging_t1_2, 
    belonging_t1_3
    )

psych::alpha(alpha_belonging_t1)

# control
data$control_t1 <- 
  rowMeans(dplyr::select(
    data, 
    control_t1_1, 
    control_t1_2, 
    control_t1_3)
    )

alpha_control_t1 <- 
  dplyr::select(
    data, 
    control_t1_1, 
    control_t1_2, 
    control_t1_3
    )

psych::alpha(alpha_control_t1)

#self-esteem

data$selfesteem_t1 <- 
  rowMeans(dplyr::select(
    data, 
    self_esteem_t1_1, 
    self_esteem_t1_2, 
    self_esteem_t1_3)
    )

alpha_selfesteem_t1 <- 
  dplyr::select(
    data, 
    self_esteem_t1_1, 
    self_esteem_t1_2, 
    self_esteem_t1_3
    )

psych::alpha(alpha_selfesteem_t1)

# meaningful existence

data$existence_t1 <- 
  rowMeans(dplyr::select(
    data, 
    existence_t1_1,
    existence_t1_2, 
    existence_t1_3)
    )

alpha_existence_t1 <- 
  dplyr::select(
    data,
    existence_t1_1, 
    existence_t1_2, 
    existence_t1_3
    )

psych::alpha(alpha_existence_t1)


# overall need satisfaction
data$overall_t1 <-
  rowMeans(dplyr::select(
    data, 
    belonging_t1, 
    control_t1, 
    existence_t1,
    selfesteem_t1)
    )

alpha_overall_t1 <-
  dplyr::select(
    data,
    belonging_t1_1,
    belonging_t1_2,
    belonging_t1_3,
    control_t1_1,
    control_t1_2,
    control_t1_3,
    self_esteem_t1_1,
    self_esteem_t1_2,
    self_esteem_t1_3,
    existence_t1_1,
    existence_t1_2,
    existence_t1_3
  )

psych::alpha(alpha_overall_t1)

# overall reversed (need threat)

data$needthreat_t1 <-
  6 - rowMeans(dplyr::select(data, belonging_t1, control_t1, existence_t1, selfesteem_t1))

#manipulation check
data$manipulation_check_rejection <-
  rowMeans(dplyr::select(data, mc_rejection_1, mc_rejection_2))

print(corr.test(data$mc_rejection_1, data$mc_rejection_2, method = "spearman"),
      short = FALSE) #instead of cronbach's alpha we check spearman correlation bcs it's 2 items

# User language variable into a factor 
data$UserLanguage <- ifelse(data$UserLanguage == "EN", "EN", "NL")
data$UserLanguage <- as.factor(data$UserLanguage)
contrasts(data$UserLanguage) <- c(0, 1)

# belonging status and response type recorded into factors
# what's referred to as "share" here is the "Response Type" in the main article
data$belonging <- as.factor(data$belonging)
contrasts(data$belonging) <- c(0, 1)
data$prev_cyberball <- as.factor(data$prev_cyberball)

## effect coding belonging and share 
data$belonging_effect <- data$belonging
contrasts(data$belonging_effect) <- c(-.5, .5)

# we're turning the subject column into a factor so that converting between long and wide isn't a problem
data$subject <- as.factor(data$subject)
 
## subsetting data 
data_exclusion <- subset(data, belonging == "exclusion")
data_inclusion <- subset(data, belonging == "inclusion")

# 5. manipulation check ------
# feelings of rejection 
ttest_mcheck_rejection <-
  t.test(manipulation_check_rejection ~ belonging, data = data)

ttest_mcheck_rejection

effectsize::cohens_d(manipulation_check_rejection ~ belonging, data = data)

data %$% 
  describeBy(manipulation_check_rejection, group = belonging)

# number of ball tosess 
ball_toss_test <- t.test(mc_balltoss ~ belonging, data = data)
ball_toss_test

effectsize::cohens_d(mc_balltoss ~ belonging, data = data)

data %$%
  describeBy(mc_balltoss, group = belonging)

# 6. Sadness analysis -----
ttest_sadness <- t.test(sadness_t1 ~ belonging, data = data)
effectsize::cohens_d(sadness_t1 ~ belonging, data = data)

data %$%
  describeBy(sadness_t1, group = belonging)


# 7. Anger Analysis -----
ttest_anger <- t.test(anger_t1 ~ belonging, data = data)
ttest_anger
effectsize::cohens_d(anger_t1 ~ belonging, data = data)

data %$%
  describeBy(anger_t1, group = belonging)


# 8. Hurt Analysis -----
ttest_hurt<- t.test(hurt_t1 ~ belonging, data = data)
ttest_hurt
effectsize::cohens_d(hurt_t1 ~ belonging, data = data)

data %$%
  describeBy(hurt_t1, group = belonging)

# 9. Belonging analysis ----
ttest_belonging <- t.test(belonging_t1 ~ belonging, data = data)
ttest_belonging
effectsize::cohens_d(belonging_t1 ~ belonging, data = data)

data %$%
  describeBy(belonging_t1, group = belonging)

# 10. Self-esteem analysis  -----
ttest_selfesteem<- t.test(selfesteem_t1 ~ belonging, data = data)
ttest_selfesteem
effectsize::cohens_d(selfesteem_t1 ~ belonging, data = data)

data %$%
  describeBy(selfesteem_t1, group = belonging)

# 11. Meaningful existence analysis-----
ttest_existence <- t.test(existence_t1 ~ belonging, data = data)
ttest_existence
effectsize::cohens_d(existence_t1 ~ belonging, data = data)

data %$%
  describeBy(existence_t1, group = belonging)

# 12. Control analysis ---
ttest_control<- t.test(control_t1 ~ belonging, data = data)
ttest_control
effectsize::cohens_d(control_t1 ~ belonging, data = data)

data %$%
  describeBy(control_t1, group = belonging)


# 13. overall need satisfaction analysis ------
ttest_overallneed <- t.test(overall_t1 ~ belonging, data = data)
ttest_overallneed
effectsize::cohens_d(overall_t1 ~ belonging, data = data)

data %$%
  describeBy(overall_t1, group = belonging)

# 14. code used to create the current data frame----
## create an order(subject) variable 
#data$subject <- 1:nrow(data)

## create a new data frame with the necessary variables 
#data <- dplyr::select(data, 
#                      subject, 
#                      Progress, 
#                      starts_with("Duration"), 
#                      Finished, 
#                      ic, 
#                      UserLanguage,
#                      catch_ID,
#                      starts_with("catch_timer"),
#                      catch_belonging,
#                      starts_with("belonging_t1"),
#                      starts_with("control_t1"),
#                      starts_with("self_esteem_t1"),
#                      starts_with("existence_t1"),
#                      starts_with("mood_t1"),
#                      starts_with("catch_like"),
#                      starts_with("pain"),
#                      attention_check_1,
#                      starts_with("mc"),
#                      prev_cyberball,
#                      age,
#                      starts_with("gender"),
#                      comment, 
#                      catch_improvement)
#write.xlsx(data, "data_for_study_1.xlsx")
