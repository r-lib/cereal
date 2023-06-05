test_that("can dispatch", {
    x <- list(type = "potato", details = list())
    x <- as_dispatchable(x)
    expect_s3_class(x, "encoded_potato")
})

test_that("can roundtrip ptype through JSON", {
    df <- tibble::tibble(
        a = 1,
        b = 2L,
        c = as.Date("2023-01-01"),
        d = as.POSIXct("2019-01-01", tz = "America/New_York"),
        e = "x",
        f = factor("blue", levels = c("blue", "green", "red")),
        g = ordered("small", levels = c("small", "medium", "large"))
    )

    expect_snapshot(cereal_to_json(df$a), error = TRUE)

    json <- cereal_to_json(df)
    expect_snapshot(json)
    expect_equal(cereal_from_json(json), vctrs::vec_ptype(df))
})
