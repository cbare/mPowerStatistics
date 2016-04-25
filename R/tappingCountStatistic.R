# This is the function to compute the tapping count statistic for the mPower tapping test
#
# Input is the json from Bridge Exporter, converted into an R
# object by RJSONIO.
#
# Output is number of taps
# 
# Author: bhoff
###############################################################################



tappingCountStatistic<-function(t) {
	length(t)
}
