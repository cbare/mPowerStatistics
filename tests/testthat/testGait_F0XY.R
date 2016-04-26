library(testthat)
library(RJSONIO)

context("testGait_F0XY")

## synthesize data with a dominant frequency of 0.2
t <- seq(0,20,0.01)
t <- t + rnorm(length(t), 0, 0.00002)
x <- rep(0.1, length(t))
y <- 11*sin(1/5*2*pi*t) + 4*cos(1/6*2*pi*t+0.1) + 5*sin(2*pi*t+0.2) + 3*sin(17*2*pi*t+0.3)
z <- rep(0.2, length(t))
synthetic_data <- lapply(seq(along=t), function(i) {
  list(
    timestamp=t[i],
    userAcceleration=c(x=x[i],y=y[i],z=z[i]))
})

expect_equal(gait_F0XY(synthetic_data), 0.2, tolerance=0.00001)


## test using permuted JSON data files with these record IDs
recordIds=c(
  '0dcb75f3-4b4c-4ede-884c-e04a1a8b97b4',
  '14d57715-275b-4a0c-a804-0b2b59abd9bd',
  '1aa5df10-7234-4bc2-b2d6-8bbc0e2192e1',
  '28471b20-9c6b-475f-aff5-7c73ac552cc5',
  '4ab5ea3e-fbfb-4fdb-ad9c-42aacca1e2db',
  '6d0869b7-dd3f-40cf-8315-f348c40e68a0',
  '7e2afa3c-cc8f-4068-b828-36cd31b95e76',
  '9088021e-4aa5-4949-9f1c-4a29a8c47a8e',
  '9a042f44-c47b-4bcc-ba8d-041c5cb3c0d3',
  '9c6c3680-f923-447e-a7ed-faa26b5e60dd',
  '9cef2ef9-c2ad-4e66-a82f-8d97f57bd4db',
  'a518701b-9185-4f74-8564-703c851713de',
  'b2b8e009-1c9b-44fd-a0fe-fd3fb486a783',
  'b48a220f-6c9f-42cd-bca9-af09a636740c',
  'bf5ad14c-7c32-421d-8b10-53906bf2d065',
  'c37f79ad-8909-49d7-abf6-212d882b39a8',
  'c90f8f8e-cec7-4944-bc00-77ca85503728',
  'cc490d2f-9279-477c-b2b0-0b2a57f2b151',
  'd070eac9-1627-42fd-9a2d-8fb715211342',
  'f973a1a1-108c-4c0f-9830-5f6b1cee7a8c')

expected_F0XY=c(
  1.48698102968,
  1.7473244731014,
  1.51670087105293,
  2.00926338231762,
  1.67793163255397,
  1.65166301104723,
  0.904257120672096,
  1.74389704312599,
  1.66882784839377,
  1.95664061813015,
  1.41401424807721,
  1.98367840039941,
  1.90779177834696,
  0.801093437079908,
  1.72721186211378,
  1.34613571215688,
  1.81306059604681,
  1.89279711733034,
  1.88019046670501,
  3.6987654764242)

testDataFolder <- system.file("testdata/walking", package="mPowerStatistics")
paths <- file.path(testDataFolder, sprintf('deviceMotion_walking_outbound_%s.json', recordIds))

for (i in seq(along=paths)) {
  expect_equal(gait_F0XY(fromJSON(paths[i])), expected_F0XY[i], tolerance=1e-7)
}

