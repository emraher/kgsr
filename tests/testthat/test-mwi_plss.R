context("Test mwi_plss")

test_that("Should stop for wrong township", {
  expect_error(mwi_plss(township = "100", , range = "1", range_dir = "W", section = "1", unmatched = TRUE))
})

test_that("Should stop for wrong range", {
  expect_error(mwi_plss(township = "1", , range = "100", range_dir = "W", section = "1", unmatched = TRUE))
})

test_that("Should stop for wrong range direction", {
  expect_error(mwi_plss(township = "1", , range = "1", range_dir = "N", section = "1", unmatched = TRUE))
})

test_that("Should stop for wrong section", {
  expect_error(mwi_plss(township = "1", , range = "1", range_dir = "W", section = "100", unmatched = TRUE))
})
# TODO -------------------------------------------------------------------------
# Include more tests
