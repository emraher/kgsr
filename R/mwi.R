#' Download data from KGS Kansas Master Ground-Water Well Inventory by choosing county
#'
#' @param county County Name
#' @param unmatched Option for downloading unmatched data
#'
#' @return
#' Tibble data
#'
#' @examples
#' # Download data for given county
#' \dontrun{mwi("allen")}
#'
#' @export
mwi <- function(county, unmatched = FALSE) {
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
    if (unmatched == TRUE) {
      dt.list <- list()
      for (i in 1:length(dt.links)) {
        dt.list[[i]] <- readr::read_csv(dt.links[i], col_types = readr::cols())
      }
      dt <- data.table::rbindlist(dt.list) %>% tibble::as.tibble()
    } else {
      message("There are unmatched records, ignoring them! You can set 'unmatched = TRUE' if you also want that data.")
      dt <- readr::read_csv(dt.links[1], col_types = readr::cols())
    }
  }
}
