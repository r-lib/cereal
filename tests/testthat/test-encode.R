test_that("can encode data types", {
    expect_equal(cereal_encode(20:25), new_encoding("integer"))
    expect_equal(cereal_encode(c(2.3, 4.5)), new_encoding("double"))
    expect_equal(cereal_encode(letters), new_encoding("character"))
    expect_equal(cereal_encode(as.Date("2023-01-01")), new_encoding("Date"))

    expect_equal(
        cereal_encode(as.POSIXct("2019-01-01", tz = "America/New_York")),
        new_encoding("POSIXct", details = list(tzone = "America/New_York"))
    )

    x <- factor("blue", levels = c("blue", "green", "red"))
    expect_equal(
        cereal_encode(x),
        new_encoding("factor", details = list(levels = levels(x)))
    )
    expect_equal(cereal_encode(x), cereal_encode(vctrs::vec_ptype(x)))

    expect_equal(
        cereal_encode(ordered("small", levels = c("small", "medium", "large"))),
        new_encoding("ordered", details = list(levels = c("small", "medium", "large")))
    )
})

test_that("new encoding", {
    expect_equal(
        new_encoding("potato", list(levels = c("mashed", "fried", "boiled"))),
        list(
            type = "potato",
            details = list(levels = c("mashed", "fried", "boiled")))
    )
})
