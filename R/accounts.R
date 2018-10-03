#' Get Ether Balance for multiple Accounts
#'
#' Currently, you can only query up to 20 accounts with one call.
#'
#' @param accounts a character vector of account addresses
#' @param api_key the etherscan api key
#'
#' @return a data frame with two columns, address and balance.
#'
#' @export
etherscan_balance <- function(accounts, api_key = etherscan_get_api_key()) {
  stopifnot(is.character(accounts))
  if (length(accounts) > 20) {
    stop("Sorry, only <= 20 accounts can be queries with one call", call. = FALSE)
  }
  url <- append_api_key(paste0("https://api.etherscan.io/api?module=account&action=balancemulti",
                               "&address=", paste0(accounts, collapse = ",")), api_key)
  res <- jsonlite::fromJSON(url)
  if (is_ok(res)) {
    balance <- res$result
    data.frame(
      account = balance$account,
      balance = balance$balance,
      stringsAsFactors = FALSE
    )
  } else {
    stop(res$message, call. = FALSE)
  }
}

#' Get all 'normal' transactions of an account
#'
#' @param account the account address
#' @param startblock the starting block
#' @param endblock the endblock
#' @param offset max records to return
#' @param page page number
#' @param api_key the etherscan api key
#'
#' @export
etherscan_transactions <- function(account, startblock = 0,
                                   endblock = 999999999,
                                   offset = 1000,
                                   page = 1,
                                   api_key = etherscan_get_api_key()) {
  stopifnot(length(account) == 1, is.character(account))
  stopifnot(startblock >= 0)
  stopifnot(endblock > startblock)
  url <- append_api_key(paste0("https://api.etherscan.io/api?module=account&action=txlist",
                               "&address=", account,
                               "&startblock=", as.integer(startblock),
                               "&endblock=", as.integer(endblock),
                               "&page=", as.integer(page),
                               "&offset=", as.integer(offset)), api_key)
  res <- jsonlite::fromJSON(url)
  data.frame(
    blockNumber = as.integer(res$result$blockNumber),
    timeStamp = as.POSIXct(as.numeric(res$result$timeStamp), origin = "1970-01-01"),
    hash = res$result$hash,
    nonce = as.integer(res$result$nonce),
    blockHash = res$result$blockHash,
    transactionIndex = as.integer(res$result$transactionIndex),
    from = res$result$from,
    to = res$result$to,
    value = res$result$value,
    gas = res$result$gas,
    gasPrice = res$result$gasPrice,
    isError = res$result$isError == "1",
    txReceiptPass = res$result$txreceipt_status == "1",
    input = res$result$input,
    contractAddress = res$result$contractAddress,
    cumulativeGasUsed = res$result$cumulativeGasUsed,
    gasUsed = res$result$gasUsed,
    confirmations = as.integer(res$result$confirmations),
    stringsAsFactors = FALSE
  )
}


#' Get all 'internal' transactions of an account
#'
#' @param account the account address
#' @param startblock the starting block
#' @param endblock the endblock
#' @param offset max records to return
#' @param page page number
#' @param api_key the etherscan api key
#'
#' @export
etherscan_internal_transactions <- function(account, startblock = 0,
                                   endblock = 999999999,
                                   offset = 1000,
                                   page = 1,
                                   api_key = etherscan_get_api_key()) {
  stopifnot(length(account) == 1, is.character(account))
  stopifnot(startblock >= 0)
  stopifnot(endblock > startblock)
  url <- append_api_key(paste0("https://api.etherscan.io/api?module=account&action=txlistinternal",
                               "&address=", account,
                               "&startblock=", as.integer(startblock),
                               "&endblock=", as.integer(endblock),
                               "&page=", as.integer(page),
                               "&offset=", as.integer(offset)), api_key)
  res <- jsonlite::fromJSON(url)
  data.frame(
    blockNumber = as.integer(res$result$blockNumber),
    timeStamp = as.POSIXct(as.numeric(res$result$timeStamp), origin = "1970-01-01"),
    hash = res$result$hash,
    from = res$result$from,
    to = res$result$to,
    value = res$result$value,
    contractAddress = res$result$contractAddress,
    input = res$result$input,
    type = res$result$type,
    gas = res$result$gas,
    gasUsed = res$result$gasUsed,
    traceId = res$result$traceId,
    isError = res$result$isError == "1",
    errCode = res$result$errCode,
    stringsAsFactors = FALSE
  )
}