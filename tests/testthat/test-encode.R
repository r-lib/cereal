test_that("can encode data types", {
    expect_equal(cereal_encode(20:25), new_cereal("integer", "20"))
    expect_equal(cereal_encode(c(2.3, 4.5)), new_cereal("numeric", "2.3"))

    expect_equal(
        withr::with_options(list(digits = 6), cereal_encode(c(11/999, 11/999, 11/999))),
        new_cereal("numeric", "0.011011")
    )

    expect_equal(
        withr::with_options(list(digits = 9), cereal_encode(c(11/999, 11/999, 11/999))),
        new_cereal("numeric", "0.011011011")
    )

    expect_equal(cereal_encode(letters), new_cereal("character", "a"))
    expect_equal(cereal_encode(as.Date("2023-01-01")), new_cereal("Date", "2023-01-01"))

    x <- as.POSIXct("2019-01-01", tz = "America/New_York")
    expect_equal(
        cereal_encode(x),
        new_cereal("POSIXct", as.character(x), list(tzone = "America/New_York"))
    )

    x <- factor("blue", levels = c("blue", "green", "red"))
    expect_equal(
        names(cereal_encode(x)),
        c("type", "default", "details")
    )
    expect_equal(
        cereal_encode(x),
        new_cereal("factor", "blue", list(levels = levels(x)))
    )
    expect_equal(
        cereal_encode(vctrs::vec_ptype(x)),
        new_cereal("factor", NULL, list(levels = levels(x)))
    )

    expect_equal(
        cereal_encode(ordered("small", levels = c("small", "medium", "large"))),
        new_cereal("ordered", "small", list(levels = c("small", "medium", "large")))
    )
})
