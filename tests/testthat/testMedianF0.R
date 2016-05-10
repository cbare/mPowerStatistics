library(testthat)

context("testMedianF0")

run_in_docker <- grepl('Darwin',Sys.info()['sysname']) && Sys.info()['user']=='CBare'

recordIds <- c(
  '03246007-b2f0-4e49-adb6-6281c7d5cb53',
  '0fb00aae-6d05-44ef-b379-94ae37131dbf',
  '230721fe-4a64-4879-a6e0-d95c920e27a3',
  '2759b133-6e1a-4ea7-a55c-394473cb6aae',
  '3b8dd019-1c26-4197-9d2b-5696253546a0',
  '4b727cd9-0502-4aed-82df-eb4d1bf5b051',
  '533255f4-d1d1-414a-9aac-9020773356c1',
  '6694e082-40e5-4c1b-9415-99ca0548f009',
  '6bcd8756-03f1-44a0-af01-8b01521af926',
  '80d5e9e6-78a9-48b1-96fb-212d6f202f9f',
  '82fc6c5a-c47b-4dba-a860-8c05c134559a',
  '931441a5-e2dc-4048-9b16-4061f0cbcc8c',
  'a57cc7ea-b24a-4eba-a49c-7a5623cf75b5',
  'a74dfc2b-1fb6-447d-a8ca-b3d798cc164f',
  'b63261dd-6b7e-4de7-a14f-8b6814296b95',
  'd61aa8a8-9cb1-46e0-994c-00e339cf8436',
  'f2914e6e-46f9-4544-ad1f-394d1634ebf6',
  'f6eb3914-9c41-44a4-ad45-571529469c53')

## TODO verify these using the original MATLAB code
expected_medianF0 <- c(
  164.053533,
  100.115591,
  182.028792,
  496.743125,
  151.834538,
   81.695773,
  100.173437,
  177.871249,
  142.035352,
  138.351025,
  270.226033,
  106.683224,
  171.812301,
  160.956034,
  278.626665,
  106.560050,
  145.859908,
   99.481489)


testDataFolder <- system.file("testdata/voice", package="mPowerStatistics")
paths <- file.path(testDataFolder, sprintf('voice_%s.m4a', recordIds))

for (i in seq(along=paths)) {
  expect_equal(medianF0(convert_to_wav(paths[i], run_in_docker=run_in_docker), run_in_docker=run_in_docker), expected_medianF0[i], tolerance=1.0)
}

## cleanup .wav files
file.remove(file.path(testDataFolder, sprintf('voice_%s.wav', recordIds)))

## try processing a bad .m4a file
filepath <- file.path(testDataFolder, "bad.m4a")
f1 <- file(filepath, "wb")
writeBin(rep(0,1024), f1)
close(f1)
expect_warning(fn <- convert_to_wav(filepath, run_in_docker=run_in_docker))
expect_true(is.na(fn))
file.remove(filepath)

## try processing a bad .wav file
filepath <- file.path(testDataFolder, "bad.wav")
f2 <- file(filepath, "wb")
writeBin(rep(0,1024), f2)
close(f2)
expect_warning(f0m <- medianF0(filepath, run_in_docker=run_in_docker))
expect_true(is.na(f0m))
file.remove(filepath)
