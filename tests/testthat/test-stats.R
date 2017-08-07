test_that("we can set an api key", {
  expect_message(etherscan_set_api_key("wat"))
  expect_equal(etherscan_get_api_key(), "wat")
})

test_that("it returns the ether supply in Wei", {
  supply <- etherscan_ethsupply()
  expect_true(supply > 0)
})

test_that("we can receive the eth price", {
  price <- etherscan_ethprice()
  expect_true(price$ethusd > 0)
  expect_true(price$ethbtc > 0)
})