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

test_that("it get all normal transactions", {
  addresses <- c("0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a")
  transactions <- etherscan_transactions(addresses)
  expect_true(is.data.frame(transactions))
  expect_true(nrow(transactions) > 0)
  expect_true(is.logical(transactions$isError))
})

test_that("it get all internal transactions", {
  addresses <- c("0x2c1ba59d6f58433fb1eaee7d20b26ed83bda51a3")
  transactions <- etherscan_internal_transactions(addresses)
  expect_true(is.data.frame(transactions))
  expect_true(nrow(transactions) > 10)
  expect_true(is.logical(transactions$isError))
})
