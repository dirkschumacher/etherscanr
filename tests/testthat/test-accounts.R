test_that("it can retreive an account balance", {
  addresses <- c("0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a",
                 "0x63a9975ba31b0b9626b34300f7f627147df1f526")
  balance <- etherscan_balance(addresses)
  expect_true(is.data.frame(balance))
  expect_equal(colnames(balance), c("account", "balance"))
  expect_equal(nrow(balance), 2)
  expect_true(is.character(balance$account))
  expect_true(all(balance$balance >= 0))
})
