#' Get the api key
#'
#' @export
etherscan_get_api_key <- function() {
  key <- Sys.getenv("ETHERSCAN_KEY")
  if (!is.null(key)) {
    message("Using ETHERSCAN_KEY as api key")
    key
  }
}

#' Sets the api key as an environment variable
#'
#' @param api_key etherscan.io api key
#'
#' @export
etherscan_set_api_key <- function(api_key) {
  message("Setting environment variable ETHERSCAN_KEY")
  Sys.setenv("ETHERSCAN_KEY" = api_key)
}
