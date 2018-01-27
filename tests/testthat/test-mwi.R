context("Test mwi")

test_that("Should stop for wrong county name", {
  expect_error(mwi("alle"))
})

# TODO -------------------------------------------------------------------------
# Include more tests
