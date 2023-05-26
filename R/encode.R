#' Encode a vector as JSON
#'
#' Create a list encoding the vctrs prototype (metadata) that can be stored
#' as JSON.
#'
#' @param x A vector
#' @param type An R type or class as a string, such as  "integer" or "factor"
#' @param details Optional details about the `type`, like the levels of a
#' factor or timezone of a datetime
#' @return A list that can be converted to JSON with [jsonlite::toJSON()]
#' @seealso [vctrs::vec_ptype()], [cereal_decode()]
#' @export
#'
#' @examples
#' new_encoding("double")
#'
#' cereal_encode(1:10)
#' cereal_encode(Sys.Date())
#' cereal_encode(sample(letters, 5))
#' cereal_encode(factor(letters[1:5], labels = "letter"))
#' cereal_encode(factor(LETTERS[3:1], ordered = TRUE))
#'
#' ## encoding a ptype returns the same result:
#' ptype <- vctrs::vec_ptype(factor(LETTERS[3:1], ordered = TRUE))
#' cereal_encode(ptype)
#'
cereal_encode <- function(x) {
    UseMethod("cereal_encode")
}

#' @export
cereal_encode.integer <- function(x) {
    new_encoding("integer")
}

#' @export
cereal_encode.double <- function(x) {
    new_encoding("double")
}

#' @export
cereal_encode.Date <- function(x) {
    new_encoding("Date")
}

#' @export
cereal_encode.POSIXct <- function(x) {
    new_encoding("POSIXct", details = list(tzone = attr(x, "tzone")))
}

#' @export
cereal_encode.character <- function(x) {
    new_encoding("character")
}
#' @export
cereal_encode.factor <- function(x) {
    new_encoding("factor", details = list(levels = levels(x)))
}

#' @export
cereal_encode.ordered <- function(x) {
    new_encoding("ordered", details = list(levels = levels(x)))
}

#' @rdname cereal_encode
#' @export
new_encoding <- function(class, details = list()) {
    list(class = class, details = details)
}

