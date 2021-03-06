
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kgsr

[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Linux Build
Status](https://travis-ci.org/emraher/kgsr.svg?branch=master)](https://travis-ci.org/emraher/kgsr)
[![Windows Build
status](https://ci.appveyor.com/api/projects/status/4ejevtp69fcrr31o?svg=true)](https://ci.appveyor.com/project/emraher/kgsr)
[![](http://www.r-pkg.org/badges/version/kgsr)](http://www.r-pkg.org/pkg/kgsr)
[![CRAN RStudio mirror
downloads](http://cranlogs.r-pkg.org/badges/kgsr)](http://www.r-pkg.org/pkg/kgsr)
[![Coverage
status](https://codecov.io/gh/emraher/kgsr/branch/master/graph/badge.svg)](https://codecov.io/github/emraher/kgsr?branch=master)

## Disclaimer

This software is in no way affiliated, endorsed, or approved by the
[Kansas Geological Survey - The University of
Kansas](http://www.kgs.ku.edu/). It comes with absolutely no warranty.

## Overview

`kgsr` is an R “interface” to KGS. It can download data from [Kansas
Geological Survey - The University of Kansas](http://www.kgs.ku.edu/).

## Installation

You can install `kgsr` from github with:

``` r
# install.packages("devtools")
devtools::install_github("emraher/kgsr")
```

## Data on KGS

  - [Water](http://www.kgs.ku.edu/Hydro/hydroIndex.html)
      - [Kansas Master Ground-Water Well
        Inventory](http://hercules.kgs.ku.edu/geohydro/master_well/index.cfm)
  - [Energy](http://www.kgs.ku.edu/PRS/petroIndex.html)
      - [State Production and Historical
        Info](http://www.kgs.ku.edu/PRS/petro/state.html)
      - [County
        Production](http://www.kgs.ku.edu/PRS/petro/interactive.html)
      - [Production from Kansas Oil and Gas
        Fields](http://www.kgs.ku.edu/Magellan/Field/index.html)
      - [Gas Storage Fields in
        Kansas](http://chasm.kgs.ku.edu/ords/oil.ogf4.GasStorage)
      - [Production from Kansas Oil and Gas
        Leases](http://www.kgs.ku.edu/Magellan/Field/lease.html)
      - [Kansas Oil and Gas Production by
        Operator](http://www.kgs.ku.edu/Magellan/Field/operators.html)
      - [Master List of Oil and Gas Wells in
        Kansas](http://www.kgs.ku.edu/Magellan/Qualified/index.html)
  - [Geology](http://www.kgs.ku.edu/General/geologyIndex.html)
  - [Geophysics](http://www.kgs.ku.edu/Geophysics/esIndex.html)

## Usage

### Download data from [Kansas Master Ground-Water Well Inventory](http://hercules.kgs.ku.edu/geohydro/master_well/index.cfm)

There are two functions in the package which retrieve data from Kansas
Master Ground-Water Well Inventory.

``` r
library(kgsr)
dt <- mwi("allen")
dt
#> # A tibble: 627 x 31
#>     WELL_KID LATITUDE LONGITUDE LAT_LONG_DATUM LAT_LONG_SOURCE COUNTY_CODE
#>        <int>    <dbl>     <dbl> <chr>          <chr>                 <int>
#>  1    1.04e⁹     37.9     -95.3 NAD83          LEO                       1
#>  2    1.04e⁹     37.9     -95.3 NAD83          LEO                       1
#>  3    1.04e⁹     37.9     -95.3 NAD83          LEO                       1
#>  4    1.04e⁹     37.9     -95.3 NAD83          LEO                       1
#>  5    1.04e⁹     37.9     -95.3 NAD83          LEO                       1
#>  6    1.04e⁹     37.9     -95.3 NAD83          LEO                       1
#>  7    1.04e⁹     37.9     -95.2 NAD83          LEO                       1
#>  8    1.04e⁹     37.9     -95.2 NAD83          LEO                       1
#>  9    1.04e⁹     37.8     -95.2 NAD83          LEO                       1
#> 10    1.04e⁹     37.8     -95.2 NAD83          LEO                       1
#> # ... with 617 more rows, and 25 more variables: TOWNSHIP <int>,
#> #   TOWNSHIP_DIRECTION <chr>, RANGE <int>, RANGE_DIRECTION <chr>,
#> #   SECTION <int>, SUBDIVISION_1_LARGEST <chr>, SUBDIVISION_2 <chr>,
#> #   SUBDIVISION_3 <chr>, SUBDIVISION_4_SMALLEST <chr>,
#> #   ELEVATION_SURFACE <dbl>, ELEVATION_SURFACE_DATUM <chr>,
#> #   ELEVATION_SURFACE_SOURCE <chr>, ELEVATION_SURFACE_NED <int>,
#> #   ELEVATION_SURFACE_NED_DATUM <chr>, COMPLETION_DATE <dttm>,
#> #   WELL_DEPTH <int>, USES_OF_WATER <chr>, NAD27_LATITUDE <dbl>,
#> #   NAD27_LONGITUDE <dbl>, NAD83_LATITUDE <dbl>, NAD83_LONGITUDE <dbl>,
#> #   WWC5_INPUT_SEQ_NUMBERS <dbl>, WRIS_PDIV_ID <int>,
#> #   WIZARD_USGS_ID <dbl>, WELL_STATUS <chr>

# -----------------------------------------------------------------------------
# Ignoring unmatched file
# -----------------------------------------------------------------------------
dt <- mwi("Cowley")
#> There are unmatched records, ignoring them! You can set 'unmatched = TRUE' if you also want that data.
dt
#> # A tibble: 2,337 x 31
#>     WELL_KID LATITUDE LONGITUDE LAT_LONG_DATUM LAT_LONG_SOURCE COUNTY_CODE
#>        <int>    <dbl>     <dbl> <chr>          <chr>                 <int>
#>  1    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#>  2    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#>  3    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#>  4    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#>  5    1.04e⁹     37.2     -97.0 NAD83          GPS                      35
#>  6    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#>  7    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#>  8    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#>  9    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#> 10    1.04e⁹     37.2     -97.0 NAD83          LEO                      35
#> # ... with 2,327 more rows, and 25 more variables: TOWNSHIP <int>,
#> #   TOWNSHIP_DIRECTION <chr>, RANGE <int>, RANGE_DIRECTION <chr>,
#> #   SECTION <int>, SUBDIVISION_1_LARGEST <chr>, SUBDIVISION_2 <chr>,
#> #   SUBDIVISION_3 <chr>, SUBDIVISION_4_SMALLEST <chr>,
#> #   ELEVATION_SURFACE <dbl>, ELEVATION_SURFACE_DATUM <chr>,
#> #   ELEVATION_SURFACE_SOURCE <chr>, ELEVATION_SURFACE_NED <int>,
#> #   ELEVATION_SURFACE_NED_DATUM <chr>, COMPLETION_DATE <dttm>,
#> #   WELL_DEPTH <int>, USES_OF_WATER <chr>, NAD27_LATITUDE <dbl>,
#> #   NAD27_LONGITUDE <dbl>, NAD83_LATITUDE <dbl>, NAD83_LONGITUDE <dbl>,
#> #   WWC5_INPUT_SEQ_NUMBERS <dbl>, WRIS_PDIV_ID <int>,
#> #   WIZARD_USGS_ID <dbl>, WELL_STATUS <chr>

# -----------------------------------------------------------------------------
# Wrong county name
# -----------------------------------------------------------------------------
dt <- mwi("alen")
#> Error in mwi("alen"): There is no county in KS named "alen".

# -----------------------------------------------------------------------------
# Download with given township, range, range direction, and section (optional).
# -----------------------------------------------------------------------------
dt <- mwi_plss(township = "1", range = "1", range_dir = "W", section = "1", unmatched = TRUE)
dt
#> # A tibble: 3 x 31
#>     WELL_KID LATITUDE LONGITUDE LAT_LONG_DATUM LAT_LONG_SOURCE COUNTY_CODE
#>        <int>    <dbl>     <dbl> <chr>          <chr>                 <int>
#> 1 1043457740     40.0     -97.4 NAD83          LEO                     157
#> 2 1043457742     40.0     -97.4 NAD83          LEO                     157
#> 3 1043457741     40.0     -97.4 NAD83          LEO                     157
#> # ... with 25 more variables: TOWNSHIP <int>, TOWNSHIP_DIRECTION <chr>,
#> #   RANGE <int>, RANGE_DIRECTION <chr>, SECTION <int>,
#> #   SUBDIVISION_1_LARGEST <chr>, SUBDIVISION_2 <chr>, SUBDIVISION_3 <chr>,
#> #   SUBDIVISION_4_SMALLEST <chr>, ELEVATION_SURFACE <chr>,
#> #   ELEVATION_SURFACE_DATUM <chr>, ELEVATION_SURFACE_SOURCE <chr>,
#> #   ELEVATION_SURFACE_NED <int>, ELEVATION_SURFACE_NED_DATUM <chr>,
#> #   COMPLETION_DATE <dttm>, WELL_DEPTH <int>, USES_OF_WATER <chr>,
#> #   NAD27_LATITUDE <dbl>, NAD27_LONGITUDE <dbl>, NAD83_LATITUDE <dbl>,
#> #   NAD83_LONGITUDE <dbl>, WWC5_INPUT_SEQ_NUMBERS <int>,
#> #   WRIS_PDIV_ID <chr>, WIZARD_USGS_ID <chr>, WELL_STATUS <chr>
```

### Download data from [Master List of Oil and Gas Wells in Kansas](http://www.kgs.ku.edu/Magellan/Qualified/index.html)

``` r
library(kgsr)
dt <- ogw(township = "1", range = "1")
dt
#> # A tibble: 2 x 40
#>       KID API_NUMBER API_NUM_NODASH LEASE   WELL FIELD  LATITUDE LONGITUDE
#>     <int> <chr>      <chr>          <chr>  <int> <chr>     <dbl>     <dbl>
#> 1  1.01e⁹ <NA>       <NA>           QMB2 …    NA UNKNO…     NA        NA  
#> 2  1.03e⁹ <NA>       <NA>           BOOMH…     1 HINEM…     40.0     -97.4
#> # ... with 32 more variables: LONG_LAT_SOURCE <chr>, TOWNSHIP <int>,
#> #   TWN_DIR <chr>, RANGE <int>, RANGE_DIR <chr>, SECTION <int>,
#> #   SPOT <chr>, FEET_NORTH <chr>, FEET_EAST <chr>, FOOT_REF <chr>,
#> #   ORIG_OPERATOR <chr>, CURR_OPERATOR <chr>, ELEVATION <int>,
#> #   ELEV_REF <chr>, DEPTH <chr>, PRODUCE_FORM <chr>, IP_OIL <chr>,
#> #   IP_GAS <chr>, IP_WATER <chr>, PERMIT <chr>, SPUD <chr>,
#> #   COMPLETION <chr>, PLUGGING <chr>, MODIFIED <chr>, OIL_KID <chr>,
#> #   OIL_DOR_ID <chr>, GAS_KID <chr>, GAS_DOR_ID <chr>, KCC_DOCKET <chr>,
#> #   STATUS <chr>, STATUS2 <chr>, COMMENTS <chr>

dt <- ogw(county = "allen", welltype = "OIL")
dt
#> # A tibble: 10,560 x 40
#>        KID API_NUMBER  API_NUM_NODASH LEASE WELL  FIELD LATITUDE LONGITUDE
#>      <int> <chr>                <dbl> <chr> <chr> <chr>    <dbl>     <dbl>
#>  1  1.01e⁹ <NA>                    NA BURT… 22    <NA>      37.8     -95.5
#>  2  1.01e⁹ <NA>                    NA BURT… 16    <NA>      37.8     -95.5
#>  3  1.01e⁹ <NA>                    NA BURT… 9     <NA>      37.8     -95.5
#>  4  1.01e⁹ <NA>                    NA BURT… 19    <NA>      37.8     -95.5
#>  5  1.01e⁹ <NA>                    NA BURT… 2     <NA>      37.8     -95.5
#>  6  1.01e⁹ <NA>                    NA BURT… 27    <NA>      37.8     -95.5
#>  7  1.01e⁹ <NA>                    NA BURT… 25    <NA>      37.8     -95.5
#>  8  1.01e⁹ <NA>                    NA BURT… 5     <NA>      37.8     -95.5
#>  9  1.01e⁹ <NA>                    NA BURT… 1     <NA>      37.8     -95.5
#> 10  1.01e⁹ 15-001-727… 15001727610000 MONA… OW-4  <NA>      37.8     -95.4
#> # ... with 10,550 more rows, and 32 more variables: LONG_LAT_SOURCE <chr>,
#> #   TOWNSHIP <int>, TWN_DIR <chr>, RANGE <int>, RANGE_DIR <chr>,
#> #   SECTION <int>, SPOT <chr>, FEET_NORTH <int>, FEET_EAST <int>,
#> #   FOOT_REF <chr>, ORIG_OPERATOR <chr>, CURR_OPERATOR <chr>,
#> #   ELEVATION <dbl>, ELEV_REF <chr>, DEPTH <int>, PRODUCE_FORM <chr>,
#> #   IP_OIL <dbl>, IP_GAS <int>, IP_WATER <dbl>, PERMIT <chr>, SPUD <chr>,
#> #   COMPLETION <chr>, PLUGGING <chr>, MODIFIED <chr>, OIL_KID <int>,
#> #   OIL_DOR_ID <int>, GAS_KID <int>, GAS_DOR_ID <int>, KCC_DOCKET <chr>,
#> #   STATUS <chr>, STATUS2 <chr>, COMMENTS <chr>
```

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
