#' Encode a vector as JSON
#'
#' Create a list encoding the vctrs prototype (metadata) that can be stored
#' as JSON.
#'
#' @param x A vector
#' @details
#' Use the `digits` option to specify how many digits after the decimal point
#' to record in JSON, for example via [withr::local_options()].
#'
#' @return A list that can be converted to JSON with [jsonlite::toJSON()]
#' @seealso [vctrs::vec_ptype()], [cereal_decode()]
#' @export
#'
#' @examples
#' cereal_encode(1:10)
#' cereal_encode(Sys.Date())
#' cereal_encode(sample(letters, 5))
#' cereal_encode(factor(letters[1:5], labels = "letter"))
#' cereal_encode(factor(LETTERS[3:1], ordered = TRUE))
#'
#' ## you can encode a ptype as well:
#' ptype <- vctrs::vec_ptype(factor(LETTERS[3:1], ordered = TRUE))
#' ## but default is NULL:
#' cereal_encode(ptype)
#'
cereal_encode <- function(x) {
    list(
        type = class(x)[[1]],
        default = cereal_default(x),
        details = cereal_details(x)
    )
}

#' Find needed details for vctrs prototype
#'
#' @param x A vector
#'
#' @return A list
#'
#' @examples
#' cereal_details(factor(letters[1:5], labels = "letter"))
#' cereal_details(factor(LETTERS[3:1], ordered = TRUE))
#' cereal_details(as.POSIXct("2023-01-01", tz = "America/New_York"))
#' @export
cereal_details <- function(x) {
    UseMethod("cereal_details")
}

#' @export
cereal_details.default <- function(x) {
    list()
}

#' @export
cereal_details.POSIXct <- function(x) {
    list(tzone = attr(x, "tzone"))
}

#' @export
cereal_details.factor <- function(x) {
    list(levels = levels(x))
}

#' @export
cereal_details.ordered <- function(x) {
    list(levels = levels(x))
}

cereal_default <- function(x) {
    if (length(x) > 0) {
        return(format(x[[1]], digits = getOption("digits")))
    } else {
        return(NULL)
    }
}

new_cereal <- function(type, default = NULL, details = list()) {
    list(type = type, default = default, details = details)
}
