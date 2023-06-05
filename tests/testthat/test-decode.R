test_that("can decode data types", {
    expect_equal(
        cereal_decode(structure(list(), class = "cereal_integer")),
        integer()
    )
    expect_equal(
        cereal_decode(structure(list(), class = "cereal_double")),
        double()
    )
    expect_equal(
        cereal_decode(structure(list(), class = "cereal_character")),
        character()
    )
    expect_equal(
        cereal_decode(structure(list(), class = "cereal_Date")),
        vctrs::new_date()
    )
    expect_equal(
        cereal_decode(structure(
            list(details = list(tzone = "my new time zone!")),
            class = "cereal_POSIXct"
        )),
        vctrs::new_datetime(tzone = "my new time zone!")
    )
    expect_equal(
        cereal_decode(structure(
            list(details = list(levels = c("boop", "beep"))),
            class = "cereal_factor"
        )),
        vctrs::new_factor(levels = c("boop", "beep"))
    )
    expect_equal(
        cereal_decode(structure(
            list(details = list(levels = c("low", "high"))),
            class = "cereal_ordered"
        )),
        vctrs::new_ordered(levels = c("low", "high"))
    )
})
