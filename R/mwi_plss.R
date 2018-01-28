#' Download data from KGS Kansas Master Ground-Water Well Inventory by choosing township, section, range
#'
#' @param township Township
#' @param range Range
#' @param range_dir Range Direction
#' @param section Section
#' @param unmatched Option for downloading unmatched data
#'
#' @return
#' Tibble data
#'
#' @examples
#' # Download data for given township, range, range direction, and section (optional).
#' \dontrun{mwi_plss(township = "1", range = "1", range_dir = "W", section = "1", unmatched = TRUE)}
#'
#' @export
mwi_plss <- function(township, range, range_dir, section = NULL, unmatched = FALSE) {
  url <- "http://hercules.kgs.ku.edu/geohydro/master_well/index.cfm"

  form <- rvest::html_form(xml2::read_html(url))[[1]]

  if (!(township %in% trimws(form$fields$f_twp$options))) stop(paste0('There is no township in KS with code "', township, '".'))
  if (!(range %in% trimws(form$fields$f_rng$options))) stop(paste0('There is no range in KS with code "', range, '".'))
  if (!(range_dir %in% trimws(form$fields$f_rngdir$options))) stop(paste0('Range direction must be either "W" or "E".'))
  if (!(section %in% trimws(form$fields$f_sect$options))) stop(paste0('There is no section in KS with code "', section, '".'))


  # kgs <- httr::GET(url)
  # townships <- httr::content(kgs) %>% rvest::html_nodes('select[name="f_twp"] option')
  # ranges <- httr::content(kgs) %>% rvest::html_nodes('select[name="f_rng"] option')
  # range_dirs <- httr::content(kgs) %>% rvest::html_nodes('select[name="f_rngdir"] option')
  # sections <- httr::content(kgs) %>% rvest::html_nodes('select[name="f_sect"] option')
  #
  # townships.code  <- townships %>% rvest::html_attr("value")
  # if (!(township %in% townships.code)) stop(paste0('There is no township in KS with code "', township, '".'))
  #
  # ranges.code     <- ranges %>% rvest::html_attr("value")
  # if (!(range %in% ranges.code)) stop(paste0('There is no range in KS with code "', range, '".'))
  #
  # range_dirs.code <- range_dirs %>% rvest::html_attr("value")
  # if (!(range_dir %in% range_dirs.code)) stop(paste0('Range direction must be either "W" or "E".'))
  #
  # sections.code   <- sections %>% rvest::html_attr("value")
  # if (!(section %in% sections.code)) stop(paste0('There is no section in KS with code "', section, '".'))
  #
  if (is.null(section)) {
    fd <- list(f_twp = township, f_rng = range, f_rngdir = range_dir, f_sect = "0", theButton = "Select by PLSS")
  } else {
    fd <- list(f_twp = township, f_rng = range, f_rngdir = range_dir, f_sect = section, theButton = "Select by PLSS")
  }

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
