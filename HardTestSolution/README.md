
# Hard Test Solution – Shiny App as an R Package

Evaluating Mentor: Marlon Cobos

Student: Mariana Castaneda Guzman

Last updated: 2026-03-02

## Test Promt:

1.  Create an R package that deploys the Shiny app developed above.

2.  Include:

    - A function (e.g., `run_app()`) to launch the interface  
    - Helper functions for downloading and processing bioclim data  
    - Documentation using `roxygen2`  
    - A `DESCRIPTION` file and license  
    - A `README` with installation and usage instructions  
    - GitHub Actions configured to run `R CMD check` with no errors,
      warnings, or notes

## Overview

`HardTestSolution` is a minimal R package that deploys an interactive
Shiny application demonstrating a reproducible geospatial workflow using
WorldClim bioclimatic data.

The application performs the following steps:

1.  Downloads WorldClim global bioclimatic variables
2.  Extracts a selected BIO variable (default = BIO1)
3.  Crops the raster to South America
4.  Masks the raster using a South America boundary shapefile
5.  Visualizes the raster at each processing step

The processing workflow is handled by `helper_bio()`, while `run_app()`
launches the Shiny interface.

## Installation

Install the development version from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("castanedaM/nicheR_GSoC_2026_test_solutions/HardTestSolution")
```

## Usage

Launch the Shiny application:

``` r
HardTestSolution::run_app()
```

Run the processing workflow directly:

``` r
out <- HardTestSolution::helper_bio(selected_bio = 1)
names(out)
#> [1] "bio_stack"   "bio"         "region"      "bio_cropped" "bio_masked"

terra::plot(out$bio_masked)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

## Package Contents

- `run_app()` - Launches the Shiny interface
- `helper_bio()` - Downloads and processes WorldClim bioclimatic data
- roxygen2 documentation
- DESCRIPTION file
- MIT License
- GitHub Actions configured to pass `R CMD check`

<!-- badges: start -->

[![R-CMD-check](https://github.com/castanedaM/nicheR_GSoC_2026_test_solutions/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/castanedaM/nicheR_GSoC_2026_test_solutions/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->
