append_api_key <- function(url, api_key) {
  stopifnot(is.character(url))
  if (is.character(api_key) && length(api_key) == 1) {
    paste0(url, "&apikey=", api_key)
  } else {
    url
  }
}

#' Converts values
#' Currently only from wei to ether is supported
#'
#' @param x a vector of numbers (as string representation is possible)
#' @param from from scale
#'
#' @export
to_ether <- function(x, from = "wei") {
  as.numeric(Rmpfr::mpfr(x) / Rmpfr::mpfr("1000000000000000000"))
}

is_ok <- function(request_result) request_result$message == "OK"

