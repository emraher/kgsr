#' Download county data from KGS Kansas Master Ground-Water Well Inventory
#'
#' @param county County Name
#'
#' @return
#' Tibble data
#'
#'
#' @examples
#' # Download data for given county
#' \dontrun{mwi("allen")}
#'
#' @export
mwi <- function(county) {
  url <- "http://hercules.kgs.ku.edu/geohydro/master_well/index.cfm"

  kgs <- httr::GET(url)
  counties <- httr::content(kgs) %>% rvest::html_nodes('select[name="f_c"] option')
  counties.code <- counties %>% rvest::html_attr("value")
  counties.name <- counties %>% rvest::html_text(counties) %>% trimws() %>% tolower()

  if (tolower(county) %in% counties.name) {
    county.code <- which(counties.name == tolower(county))
    county.code <- counties.code[county.code]
  } else {
    stop(paste0('There is no county in KS named "', county, '".'))
  }

  fd <- list(theButton = "Select by County", f_c = county.code)
  kgs.resp <- httr::POST(url, body = fd, encode = "multipart")
  dt.links <- httr::content(kgs.resp) %>%
    rvest::html_nodes("form a") %>%
    rvest::html_attr("href")
  if (length(dt.links) == 1) {
    dt <- readr::read_csv(dt.links, col_types = readr::cols())
  } else {
    message("There are unmatched records, ignoring them!")
    dt <- readr::read_csv(dt.links[1], col_types = readr::cols())
  }
}
