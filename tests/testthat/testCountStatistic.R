# This is the set of tests for the count statistic feature
# 
# Author: bhoff
###############################################################################

library(testthat)
library(RJSONIO)

context("testCountStatistic")

testDataFolder<-system.file("testdata/tapping", package="mPowerStatistics")
tappingFile<-file.path(testDataFolder, "tapping_results.json.TappingSamples-1a642746-7f22-421b-a6de-d90eabf99ba96278340256554412503.json")
message("tappingFile: ", tappingFile)
tapping<-fromJSON(tappingFile)
# TODO how do we know what the right number is?
expect_equal(309, tappingCountStatistic(tapping))

