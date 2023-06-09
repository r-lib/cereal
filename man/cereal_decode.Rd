% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/decode.R
\name{cereal_decode}
\alias{cereal_decode}
\title{Convert a JSON-serialized prototype to a vctrs prototype}
\usage{
cereal_decode(x)
}
\arguments{
\item{x}{An object with class "cereal_*", such as "cereal_integer" or
"cereal_factor"}
}
\value{
A vector of zero length, such as \code{\link[=integer]{integer()}} or \code{\link[vctrs:new_factor]{vctrs::new_factor()}}
}
\description{
Create a \code{\link[vctrs:vec_ptype]{vctrs::vec_ptype()}} from a JSON-serialized prototype created with
\code{\link[=cereal_encode]{cereal_encode()}}.
}
\examples{
cereal_decode(structure(list(), class = "cereal_integer"))
cereal_decode(structure(list(), class = "cereal_Date"))

}
