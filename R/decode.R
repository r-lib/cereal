#' Convert a JSON-serialized prototype to a vctrs prototype
#'
#' Create a [vctrs::vec_ptype()] from a JSON-serialized prototype created with
#' [cereal_encode()].
#'
#' @param x An object with class "encoded_*", such as "encoded_integer" or
#' "encoded_factor"
#' @return A vector with zero length, such as [integer()] or [vctrs::new_factor()]
#' @export
#' @examples
#' cereal_decode(structure(list(), class = "encoded_integer"))
#' cereal_decode(structure(list(), class = "encoded_Date"))
#'
cereal_decode <- function(x) {
    UseMethod("cereal_decode")
}

#' @export
cereal_decode.encoded_integer <- function(x) {
    integer()
}

#' @export
cereal_decode.encoded_double <- function(x) {
    double()
}

#' @export
cereal_decode.encoded_Date <- function(x) {
    vctrs::new_date()
}

#' @export
cereal_decode.encoded_POSIXct <- function(x) {
    vctrs::new_datetime(tzone = x$details$tzone)
}

#' @export
cereal_decode.encoded_character <- function(x) {
    character()
}

#' @export
cereal_decode.encoded_factor <- function(x) {
    vctrs::new_factor(levels = x$details$levels)
}

#' @export
cereal_decode.encoded_ordered <- function(x) {
    vctrs::new_ordered(levels = x$details$levels)
}
