#' Get Total Supply of Ether
#'
#' @param api_key the etherscan api key
#' @return The total Ether supply in Wei. To get value in Ether divide result by 1000000000000000000
#'
#' @examples
#' ether <- etherscan_ethsupply() / Rmpfr::mpfr("1000000000000000000")
#' @export
etherscan_ethsupply <- function(api_key = etherscan_get_api_key()) {
  url <- append_api_key("https://api.etherscan.io/api?module=stats&action=ethsupply", api_key)
  res <- jsonlite::fromJSON(url)
  if (is_ok(res)) {
    Rmpfr::mpfr(res$result)
  } else {
    stop(res$message, call. = FALSE)
  }
}

#' Get ETHER LastPrice Price
#'
#' Finds the current price in BTC and USD.
#'
#' @param api_key the etherscan api key
#'
#' @return a list with 4 named entries
#'
#' @export
etherscan_ethprice <- function(api_key = etherscan_get_api_key()) {
  url <- append_api_key("https://api.etherscan.io/api?module=stats&action=ethprice", api_key)
  res <- jsonlite::fromJSON(url)
  if (is_ok(res)) {
    result <- res$result
    list(
      ethbtc = as.numeric(result$ethbtc),
      ethbtc_date = as.POSIXct(as.numeric(result$ethbtc_timestamp), origin = "1970-01-01"),
      ethusd = as.numeric(result$ethusd),
      ethusd_date = as.POSIXct(as.numeric(result$ethusd_timestamp), origin = "1970-01-01")
    )
  } else {
    stop(res$message, call. = FALSE)
  }
}
