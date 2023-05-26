#' Serialize and deserialize the prototype of a data frame to JSON
#'
#' The function `cereal_to_json()` serializes the
#' [vctrs prototype](https://vctrs.r-lib.org/articles/type-size.html#prototype)
#' of a data frame to JSON, and the function `cereal_from_json()` deserializes
#' from a JSON prototype back to a vctrs prototype.
#'
#' @param data A data frame
#' @param x A JSON string
#' @param ... Arguments passed on to [jsonlite::toJSON()]
#'
#' @return `cereal_to_json()` returns a JSON string like [jsonlite::toJSON()],
#' and `cereal_from_json()` returns a vctrs ptype, like [vctrs::vec_ptype()].
#' @export
#' @seealso [cereal_encode()], [cereal_decode]
#' @examples
#'
#' df <- tibble::tibble(
#'     a = 1,
#'     b = 2L,
#'     c = Sys.Date(),
#'     d = as.POSIXct("2019-01-01", tz = "America/New_York"),
#'     e = "x",
#'     f = factor("blue", levels = c("blue", "green", "red")),
#'     g = ordered("small", levels = c("small", "medium", "large"))
#' )
#'
#' json <- cereal_to_json(df, auto_unbox = TRUE, pretty = TRUE)
#' json
#'
#' str(cereal_from_json(json))
#' ## same as:
#' str(vctrs::vec_ptype(df))
#'
cereal_to_json <- function(data, ...) {
    data <- lapply(data, cereal_encode)
    jsonlite::toJSON(data, ...)
}

#' @rdname cereal_to_json
#' @export
cereal_from_json <- function(x) {
    x <- jsonlite::fromJSON(x)
    x <- lapply(x, as_dispatchable)
    x <- lapply(x, cereal_decode)
    tibble::new_tibble(x, nrow = 0L)
}

as_dispatchable <- function(x) {
    class(x) <- paste0("encoded_", x$type)
    x
}
