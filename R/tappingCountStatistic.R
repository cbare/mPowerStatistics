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
	result<-data.frame(time, X, Y, buttonid, stringsAsFactors=F)
	rownames(result)<-NULL
	result
}


CleanTappedButtonNone <- function(x) {
	il <- x$buttonid == "TappedButtonLeft" ## get indexes of taps on left button 
	ir <- x$buttonid == "TappedButtonRight" ## get indexes of taps on right button
	ino <- x$buttonid == "TappedButtonNone" ## get indexes of taps outside the button
	xx <- rbind(x[il,], x[ir,], x[ino,]) ## create new matrix where the data from taps outside the button is at the bottom
	dupli <- duplicated(cbind(xx$X, xx$Y)) ## determine which data is duplicated
	## we only want to drop TappedButtonNone duplications
	## so we force a FALSE for data corresponding to taps on the right and left buttons 
	nlr <- sum(il) + sum(ir)
	dupli[seq(nlr)] <- FALSE
	############################
	xx <- xx[which(!dupli),] ## now we remove on the duplicated data from taps outside the buttons
	xx[order(xx[, 1]),] ## order the data according to time
}



