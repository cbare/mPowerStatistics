# compute F0XY, maximum peak frequency detected by lombs-scarge
#
# https://github.com/Sage-Bionetworks/mPower-sdata/blob/master/featureExtraction/gaitHelpers.R
###############################################################################

gait_F0XY <- function(gait_data_from_json) {
  dat <- ShapeGaitData(gait_data_from_json)
  ## Note: left out low-pass filter as it was not being used
  y <- dat[, "y"]
  t <- dat[, "timestamp"]

  ## Lomb-Scargle Periodogram from package lomb
  lspXY <- lsp(cbind(t, y), plot = FALSE)
  F0XY <- lspXY$peak.at[1]
  return(F0XY)
}

ShapeGaitData <- function(x) {
  timestamp <- sapply(x, function(x) x$timestamp)
  timestamp <- timestamp - timestamp[1]
  accel <- sapply(x, function(x) x$userAcceleration)
  accel <- t(accel)
  dat <- data.frame(timestamp, accel)
  dat
}
