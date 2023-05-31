
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cereal 🥣

<!-- badges: start -->

[![R-CMD-check](https://github.com/juliasilge/cereal/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/juliasilge/cereal/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/juliasilge/cereal/branch/main/graph/badge.svg)](https://app.codecov.io/gh/juliasilge/cereal?branch=main)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of cereal is to provide methods to
[serialize](https://en.wikipedia.org/wiki/Serialization) objects from
[vctrs](https://vctrs.r-lib.org/) to
[JSON](https://en.wikipedia.org/wiki/JSON), as well as back from JSON to
vctrs objects.

## Installation

You can install the development version of cereal from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("juliasilge/cereal")
```

## Example

A data frame is a rectangular collection of variables (in the columns)
and observations (in the rows). Each variable is a vector of one data
type, like factor or datetime:

``` r
df <- tibble::tibble(
  a = c(1.2, 2.3, 3.4),
  b = 2L:4L,
  c = Sys.Date() + 0:2,
  d = as.POSIXct("2019-01-01", tz = "America/New_York") + 100:102,
  e = sample(letters, 3),
  f = factor(c("blue", "blue", "green"), levels = c("blue", "green", "red")),
  g = ordered(c("small", "large", "medium"), levels = c("small", "medium", "large"))
)

df
#> # A tibble: 3 × 7
#>       a     b c          d                   e     f     g     
#>   <dbl> <int> <date>     <dttm>              <chr> <fct> <ord> 
#> 1   1.2     2 2023-05-31 2019-01-01 00:01:40 t     blue  small 
#> 2   2.3     3 2023-06-01 2019-01-01 00:01:41 p     blue  large 
#> 3   3.4     4 2023-06-02 2019-01-01 00:01:42 w     green medium
```

The vctrs package has a [concept of a **vector
prototype**](https://vctrs.r-lib.org/articles/type-size.html) which
captures the metadata associated with a vector without keeping any of
the data itself.

``` r
vctrs::vec_ptype(df)
#> # A tibble: 0 × 7
#> # ℹ 7 variables: a <dbl>, b <int>, c <date>, d <dttm>, e <chr>, f <fct>,
#> #   g <ord>
```

The information stored in such a vector prototype includes, for example,
the levels of a factor and the timezone for a datetime. This can be
useful or important information when deploying code or models, such as
when using [vetiver](https://vetiver.rstudio.com/). We could store this
vector prototype as an R binary object saved as an `.rds` file, but with
cereal, you can store this vector prototype in plain text as JSON:

``` r
library(cereal)
json <- cereal_to_json(df, auto_unbox = TRUE, pretty = TRUE)
json
#> {
#>   "a": {
#>     "type": "numeric",
#>     "default": "1.2",
#>     "details": []
#>   },
#>   "b": {
#>     "type": "integer",
#>     "default": "2",
#>     "details": []
#>   },
#>   "c": {
#>     "type": "Date",
#>     "default": "2023-05-31",
#>     "details": []
#>   },
#>   "d": {
#>     "type": "POSIXct",
#>     "default": "2019-01-01 00:01:40",
#>     "details": {
#>       "tzone": "America/New_York"
#>     }
#>   },
#>   "e": {
#>     "type": "character",
#>     "default": "t",
#>     "details": []
#>   },
#>   "f": {
#>     "type": "factor",
#>     "default": "blue",
#>     "details": {
#>       "levels": ["blue", "green", "red"]
#>     }
#>   },
#>   "g": {
#>     "type": "ordered",
#>     "default": "small",
#>     "details": {
#>       "levels": ["small", "medium", "large"]
#>     }
#>   }
#> }
```

Storing prototype information as JSON (rather than a binary file) means
it can be used as plain-text metadata for a model.

You can also convert from JSON back to the original prototype:

``` r
cereal_from_json(json)
#> # A tibble: 0 × 7
#> # ℹ 7 variables: a <dbl>, b <int>, c <date>, d <dttm>, e <chr>, f <fct>,
#> #   g <ord>
```

For an approach to this same task using Python, [see Pydantic’s
`model.json()`](https://docs.pydantic.dev/latest/usage/exporting_models/#modeljson).

## Contributing

- This project is released with a [Contributor Code of
  Conduct](https://www.contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
  By contributing to this project, you agree to abide by its terms.

- If you think you have encountered a bug, please [submit an
  issue](https://github.com/juliasilge/cereal/issues).

- Either way, learn how to create and share a
  [reprex](https://reprex.tidyverse.org/articles/articles/learn-reprex.html)
  (a minimal, reproducible example), to clearly communicate about your
  code.
