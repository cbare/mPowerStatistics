#' Shell out to the Octave implementation of the medianF0 statistic.
#'
#' @param filepath path to input .wav file
#'
#' @return a numeric value or NA if the computation fails
medianF0 <- function(filepath) {
  if (is.na(filepath)) {
    stop("NA filename given")
  }

  cmd <- sprintf('cd %s; octave -q %s %s 2>&1',
                 system.file("octave", package="mPowerStatistics"),
                 system.file(package="mPowerStatistics", "octave", "medianF0_from_wav.m"),
                 filepath)
  output <- system(cmd, intern=TRUE)

  if ('status' %in% names(attributes(output)) && attributes(output)$status > 0) {
    stop(output)
  } else {
    as.numeric(output)
  }
}

#' Shell out to avconv to convert .m4a to .wav.
#'
#' @param filepath path to input .m4a file
#'
#' @return filepath to output .wav file in same directory as input file
convert_to_wav <- function(filepath) {
  filename <- basename(filepath)
  data_dir <- dirname(filepath)
  target_filename <- paste(tools::file_path_sans_ext(filename), 'wav', sep='.')
  target_filepath <- file.path(data_dir, target_filename)

  cmd <- sprintf('avconv -y -i %s %s 2>&1',
                 filepath, target_filepath)
  output <- system(cmd, intern=TRUE)

  if ('status' %in% names(attributes(output)) && attributes(output)$status > 0) {
    stop(output)
  } else {
    target_filepath
  }
}
