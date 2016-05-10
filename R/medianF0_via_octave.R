#' Shell out to the Octave implementation of the medianF0 statistic.
#'
#' @param filepath path to input .wav file
#' @param run_in_docker if true, run octave from within a docker container
#'
#' @return a numeric value or NA if the computation fails
medianF0 <- function(filepath, run_in_docker=FALSE) {
  if (is.na(filepath)) {
    return(NA_real_)
  }
  if (run_in_docker) {
    filename <- basename(filepath)
    data_dir <- dirname(filepath)
    docker_conf <- 'eval "$(docker-machine env default)"'
    cmd <- paste(docker_conf,
                 sprintf('docker run -v %s:/data octave -q medianF0_from_wav.m /data/%s 2>&1',
                         data_dir, filename),
                 sep=';')
  } else {
    cmd <- sprintf('cd %s; octave -q %s %s 2>&1',
                   system.file("octave", package="mPowerStatistics"),
                   system.file(package="mPowerStatistics", "octave", "medianF0_from_wav.m"),
                   filepath)
  }

  output <- system(cmd, intern=TRUE)

  if ('status' %in% names(attributes(output)) && attributes(output)$status > 0) {
    NA_real_
  } else {
    as.numeric(output)
  }
}

#' Shell out to avconv to convert .m4a to .wav.
#'
#' @param filepath path to input .m4a file
#' @param run_in_docker if true, run avconv from within a docker container
#'
#' @return filepath to output .wav file in same directory as input file
convert_to_wav <- function(filepath, run_in_docker=FALSE) {
  filename <- basename(filepath)
  data_dir <- dirname(filepath)
  target_filename <- paste(tools::file_path_sans_ext(filename), 'wav', sep='.')
  target_filepath <- file.path(data_dir, target_filename)

  if (run_in_docker) {
    ## example: docker run -v `pwd`:/data av avconv -i /data/voice_03246007-b2f0-4e49-adb6-6281c7d5cb53.m4a /data/voice_03246007-b2f0-4e49-adb6-6281c7d5cb53.wav
    docker_conf <- 'eval "$(docker-machine env default)"'
    cmd <- paste(docker_conf,
                 sprintf('docker run -v %s:/data avconv -y -i /data/%s /data/%s 2>&1',
                         data_dir, filename, target_filename),
                 sep="; ")
  } else {
    cmd <- sprintf('avconv -y -i %s %s 2>&1',
                   filepath, target_filepath)
  }

  output <- system(cmd, intern=TRUE)

  if ('status' %in% names(attributes(output)) && attributes(output)$status > 0) {
    NA
  } else {
    target_filepath
  }
}
