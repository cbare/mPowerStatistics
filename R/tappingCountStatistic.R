# This is the function to compute the tapping count statistic for the mPower tapping test
#
# Input is the json from Bridge Exporter, converted into an R
# object by RJSONIO.
#
# Output is number of taps
# 
# Author: bhoff
###############################################################################



tappingCountStatistic<-function(tapping) {
	d1<-ShapeTappingData(tapping)
	print(d1)
	d2<-CleanTappedButtonNone(d1)
	nrow(d2)
}

# This is from https://github.com/Sage-Bionetworks/mPower-sdata/blob/master/qcCode/check_duplicated_TappedButtonNone.R
GetXY <- function(x) {
	x <- substr(x, 2, nchar(x) - 1)
	as.numeric(strsplit(x, ", ")[[1]])
}

ShapeTappingData <- function(x) {
	time <- sapply(x, function(x) x$TapTimeStamp)
	buttonid <- sapply(x, function(x) x$TappedButtonId)
	tapcoord <- sapply(x, function(x) x$TapCoordinate)
	coord <- sapply(tapcoord, GetXY)
	X <- coord[1,]
	Y <- coord[2,]  
	data.frame(time, X, Y, buttonid)
}

CleanTappedButtonNone <- function(x) {
	il <- x$buttonid == "TappedButtonLeft"
	ir <- x$buttonid == "TappedButtonRight"
	ino <- x$buttonid == "TappedButtonNone"
	xx <- rbind(x[il,], x[ir,], x[ino,])
	delta <- xx$X - xx$Y
	dupli <- duplicated(delta)
	## we only want to drop TappedButtonNone duplications 
	nlr <- sum(il) + sum(ir)
	dupli[seq(nlr)] <- FALSE
	############################
	xx <- xx[which(!dupli),]
	xx[order(xx[, 1]),]
}



