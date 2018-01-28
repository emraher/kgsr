#' Download data from KGS Master List of Oil and Gas Wells in Kansas by choosing township, range, section, etc.
#'
#' @param township Township
#' @param range Range
#' @param range_dir Range Direction
#' @param section Section
#' @param lease Lease Name
#' @param operator Operator Name
#' @param state State
#' @param county County
#' @param api 5 digit API Well Number
#' @param welltype Well Type
#' @param all Should we download all data for default values
#'
#' @return
#' Tibble data
#'
#' @examples
#' # Download data for given township, range, section, etc.
#' \dontrun{ogw(township = "1", range = "1", range_dir = "W", section = "1")}
#'
#' @export
ogw <- function(township  = NULL, range  = NULL, range_dir = "W", section = NULL, lease  = NULL, operator  = NULL, state  = "kansas", county  = "any county", api  = NULL, welltype = "ALL", all = FALSE){
  if (all == TRUE || is.null(c(township, range, section, lease, operator, api)) && county == "any county" && welltype == "ALL") {
    # SEE: https://stackoverflow.com/a/3053883
    # SEE: https://stackoverflow.com/users/143305/dirk-eddelbuettel
    temp <- tempfile()
    utils::download.file("http://www.kgs.ku.edu/PRS/Ora_Archive/ks_wells.zip", temp)
    dt <- unz(temp, "ks_wells.txt") %>% readr::read_csv(col_types = readr::cols(), guess_max = 35000)
    unlink(temp)
  }

  url <- "http://www.kgs.ku.edu/Magellan/Qualified/index.html"
  form <- rvest::html_form(xml2::read_html(url))[[1]]

  if (!(range_dir %in% c("W", "E"))) stop('Range direction must be either "W" or "E".')

  if (range_dir == "W") {
    if (!(is.null(range) || range %in% as.character(c(1:43)))) stop(paste0('There is no range in KS West with code "', range, '".'))
  } else if (range_dir == "E") {
    if (!(is.null(range) || range %in% as.character(c(1:25)))) stop(paste0('There is no range in KS East with code "', range, '".'))
  } else {
    stop(paste0('There is no range in KS with code "', range, '".'))
  }

  if (!(is.null(township) || township %in% as.character(c(1:35)))) stop(paste0('There is no township in KS with code "', township, '".'))

  if (!(is.null(section) || section %in% as.character(c(1:36)))) stop(paste0('There is no section in KS with code "', section, '".'))

  state <- tolower(state)
  states <- c("colorado" = "5", "kansas" = "15", "missouri" = "24", "nebraska" = "26", "oklahoma" = "35")
  if (!(state %in% names(states))) stop('State must be either "Colorado", "Kansas", "Missouri", "Nebraska", or "Oklahoma".')
  state <- states[[state]]

  # TODO: Need to check if api provided is numeric!----
  if (!is.null(api) && nchar(api) > 5) stop('API Well No. is the 5-digit well number.')

  county <- tolower(county)
  counties <- form$fields$f_c$options
  names(counties) <- tolower(gsub("--[0-9]+","",names(form$fields$f_c$options)))
  if (!(county %in% names(counties))) stop(paste0('There is no county in KS named "', county, '".'))
  county <- counties[[county]]

  if (!(welltype %in% trimws(form$fields$f_ws$options))) stop(paste0('There is no well type with code "', welltype, '".'))

  if ((!is.null(lease) && nchar(lease) > 50)) stop(paste0('Lease can have maximum 50 characters!'))
  if ((!is.null(operator) && nchar(operator) > 50)) stop(paste0('Operator can have maximum 50 characters!'))


  fd <- list(f_t   = township,
             f_r   = range,
             ew    = range_dir,
             f_s   = section,
             f_l   = lease,
             f_o   = operator,
             f_st  = state,
             f_c   = county,
             f_api = api,
             f_ws  = welltype)

  kgs.resp <- httr::POST(url, body = fd)

  dt.links <- httr::content(kgs.resp) %>%
    rvest::html_nodes("td~ td+ td a") %>%
    rvest::html_attr("href")

  link <- dt.links[1]

  if (is.na(link)) stop("No data returned from the query!")

  download.page <- xml2::read_html(link)

  dp.link <- rvest::html_nodes(download.page, "p:nth-child(4) a") %>%
    rvest::html_attr("href")

  dt <- readr::read_csv(dp.link, col_types = readr::cols(), guess_max = 15000)

  }
