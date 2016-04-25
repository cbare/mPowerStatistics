# compute zcrAA "zero crossing rate of the average acceleration"
#
# adapted from: https://github.com/Sage-Bionetworks/mPower-sdata/blob/master/featureExtraction/balanceExtraction.R
###############################################################################

balance_zcrAA <- function(balance_data_from_json) {
  dat <- ShapeBalanceData(balance_data_from_json)

  dat <- TrimData(dat)
  x <- dat$x
  y <- dat$y
  z <- dat$z
  aa <- sqrt(x^2 + y^2 + z^2)

  return(ZCR(aa))
}


ShapeBalanceData <- function(x){
  timestamp <- sapply(x, function(x) x$timestamp)
  timestamp <- timestamp - timestamp[1]
  accel <- sapply(x, function(x) x$userAcceleration)
  accel <- t(accel)
  dat <- data.frame(timestamp, accel)
  dat$x <- as.numeric(dat$x) * 9.8
  dat$y <- as.numeric(dat$y) * 9.8
  dat$z <- as.numeric(dat$z) * 9.8
  return(dat)
}


TrimData <- function(dat, timeStart=5, timeEnd=NULL){
  time <- dat$timestamp
  if (is.null(timeEnd)) {
    timeEnd <- time[length(time)]
  } 
  iStart <- min(which(time >= timeStart))
  iEnd <- max(which(time <= timeEnd))
  dat <- dat[iStart:iEnd,]
  dat$timestamp <- dat$timestamp - dat$timestamp[1]
  return(dat)
}


ZCR <- function(x){
  x <- x[!is.na(x)]
  if(length(x) < 3){
    return(NA)
  } else{
    n <- length(x)
    aux.x <- rep(1, n)
    aux.x[x <= mean(x)] <- -1
    return(sum(aux.x[-n] * aux.x[-1] < 0)/(n - 1))
  }
}
