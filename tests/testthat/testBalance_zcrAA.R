library(testthat)
library(RJSONIO)

context("testBalance_zcrAA")

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

expected_zcrAA=c(
  0.06842737,
  0.15701159,
  0.17801477,
  0.23701039,
  0.28765481,
  0.09036385,
  0.19295436,
  0.18373765,
  0.19327731,
  0.23691570,
  0.31114012,
  0.06265985,
  0.05082033,
  0.34575835,
  0.18098282,
  0.26608187,
  0.40889465,
  0.46040000,
  0.13677130,
  0.12669864)

testDataFolder <- system.file("testdata/walking", package="mPowerStatistics")
paths <- file.path(testDataFolder, sprintf('deviceMotion_walking_rest_%s.json', recordIds))

for (i in seq(along=paths)) {
  expect_equal(expected_zcrAA[i], balance_zcrAA(fromJSON(paths[i])), tolerance=1e-7)
}

