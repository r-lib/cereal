test_that("can decode data types", {
    expect_equal(
        cereal_decode(structure(list(), class = "encoded_integer")),
        integer()
    )
    expect_equal(
        cereal_decode(structure(list(), class = "encoded_double")),
        double()
    )
    expect_equal(
        cereal_decode(structure(list(), class = "encoded_character")),
        character()
    )
    expect_equal(
        cereal_decode(structure(list(), class = "encoded_Date")),
        vctrs::new_date()
    )
    expect_equal(
        cereal_decode(structure(
            list(details = list(tzone = "my new time zone!")),
            class = "encoded_POSIXct"
        )),
        vctrs::new_datetime(tzone = "my new time zone!")
    )
    expect_equal(
        cereal_decode(structure(
            list(details = list(levels = c("boop", "beep"))),
            class = "encoded_factor"
        )),
        vctrs::new_factor(levels = c("boop", "beep"))
    )
    expect_equal(
        cereal_decode(structure(
            list(details = list(levels = c("low", "high"))),
            class = "encoded_ordered"
        )),
        vctrs::new_ordered(levels = c("low", "high"))
    )
})
