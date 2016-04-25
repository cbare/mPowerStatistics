# This is the set of tests for the count statistic feature
# 
# Author: bhoff
###############################################################################

library(testthat)
library(RJSONIO)

context("testCountStatistic")

testDataFolder<-system.file("testdata/tapping", package="mPowerStatistics")

testTaps<-function(expectedCount, fileName) {
	expect_equal(expectedCount, tappingCountStatistic(fromJSON(file.path(testDataFolder, fileName))))
}

#testTaps(155, "tapping_results.json.TappingSamples-1a642746-7f22-421b-a6de-d90eabf99ba96278340256554412503.json")
#testTaps(124, "tapping_results.json.TappingSamples-2e87c348-d2e1-450f-9c34-2eab52fda5af111790938118683279.json")
#testTaps(45, "tapping_results.json.TappingSamples-3339eb37-cbca-470a-838f-09b553e50d5d3483250691459460603.json")
#testTaps(71, "tapping_results.json.TappingSamples-41126e25-aa15-419f-af14-1aa8e78d870e1383831155599447443.json")
#testTaps(134, "tapping_results.json.TappingSamples-532d5097-0e27-49a9-a8e6-7a26c63210bf8048991346106322245.json")
#testTaps(60, "tapping_results.json.TappingSamples-91ee9bcc-065d-4916-882a-53939ffb05962701562103948048429.json")
#testTaps(110, "tapping_results.json.TappingSamples-9891461a-2eaa-4a37-852f-b6e0d51c56737688883730723990581.json")
#testTaps(201, "tapping_results.json.TappingSamples-a307e4ae-d49a-4f96-a294-b9e56a30c0446583375764081646363.json")
#testTaps(38, "tapping_results.json.TappingSamples-a455a73c-1966-437f-a60e-e0433016ea128863241944941337544.json")
#testTaps(216, "tapping_results.json.TappingSamples-b2bafa3c-3178-46fd-81d3-c1a0e0a8ab965371216142531495452.json")
#testTaps(131, "tapping_results.json.TappingSamples-bac511da-1c4a-40e7-a4a9-2770bd74c1178230558000319275806.json")
#testTaps(206, "tapping_results.json.TappingSamples-bc72f80c-42b0-4ece-9e46-d75eb78467366264188730012735288.json")
#testTaps(212, "tapping_results.json.TappingSamples-c5563a25-a238-421d-be38-7a5134ff45177388291754517110557.json")
#testTaps(160, "tapping_results.json.TappingSamples-c755675b-7149-481a-aa19-b76db83db84d2150209084706275.json")
#testTaps(153, "tapping_results.json.TappingSamples-d1a0ff32-6756-4c65-bd7b-d5b60faec3926194198098794520520.json")
testTaps(32, "tapping_results.json.TappingSamples-dc348d0b-2457-4394-8bea-86b5975a92a68229272086582075256.json")
#testTaps(207, "tapping_results.json.TappingSamples-e255a421-36f0-4fd8-b548-dd67dedb445a8941215721774187059.json")
#testTaps(147, "tapping_results.json.TappingSamples-e5cb5f69-a75a-49cc-83b4-dd0871a6b4fb6002873297461980535.json")
#testTaps(166, "tapping_results.json.TappingSamples-e721d2e0-5930-4071-a840-f898883710265378819541683273264.json")
#testTaps(64, "tapping_results.json.TappingSamples-f6a5df58-a213-40cc-9dd1-d726144b178a7158428480297972834.json")


