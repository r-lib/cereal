#' Convert a JSON-serialized prototype to a vctrs prototype
#'
#' Create a [vctrs::vec_ptype()] from a JSON-serialized prototype created with
#' [cereal_encode()].
#'
#' @param x An object with class "cereal_*", such as "cereal_integer" or
#' "cereal_factor"
#' @return A vector of zero length, such as [integer()] or [vctrs::new_factor()]
#' @export
#' @examples
#' cereal_decode(structure(list(), class = "cereal_integer"))
#' cereal_decode(structure(list(), class = "cereal_Date"))
#'
cereal_decode <- function(x) {
    UseMethod("cereal_decode")
}

#' @export
cereal_decode.cereal_integer <- function(x) {
    integer()
}

#' @export
cereal_decode.cereal_numeric <- function(x) {
    double()
}

#' @export
cereal_decode.cereal_double <- function(x) {
    double()
}

#' @export
cereal_decode.cereal_Date <- function(x) {
    vctrs::new_date()
}

#' @export
cereal_decode.cereal_POSIXct <- function(x) {
    vctrs::new_datetime(tzone = x$details$tzone)
}

#' @export
cereal_decode.cereal_character <- function(x) {
    character()
}

#' @export
cereal_decode.cereal_factor <- function(x) {
    vctrs::new_factor(levels = x$details$levels)
}

#' @export
cereal_decode.cereal_ordered <- function(x) {
    vctrs::new_ordered(levels = x$details$levels)
}
