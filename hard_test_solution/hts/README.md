
**Hard Test Solution – Shiny App Deployment as an R Package**

Evaluating Mentor: Marlon Cobos Student: Mariana Castaneda Guzman Last
updated: 2026-02-23

## Overview

`hts` is a minimal R package that deploys an interactive Shiny
application demonstrating a reproducible geospatial workflow using
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
remotes::install_github("castanedaM/nicheR_GSoC_2026_test_solutions/hard_test_solution/hts")
#> Using GitHub PAT from the git credential store.
#> Downloading GitHub repo castanedaM/nicheR_GSoC_2026_test_solutions@HEAD
#> digest    (0.6.36  -> 0.6.39) [CRAN]
#> htmltools (0.5.8.1 -> 0.5.9 ) [CRAN]
#> Installing 2 packages: digest, htmltools
#> Installing packages into 'C:/Users/mcguz/AppData/Local/R/win-library/4.4'
#> (as 'lib' is unspecified)
#> package 'digest' successfully unpacked and MD5 sums checked
#> Warning: cannot remove prior installation of package 'digest'
#> Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying
#> C:\Users\mcguz\AppData\Local\R\win-library\4.4\00LOCK\digest\libs\x64\digest.dll
#> to C:\Users\mcguz\AppData\Local\R\win-library\4.4\digest\libs\x64\digest.dll:
#> Permission denied
#> Warning: restored 'digest'
#> package 'htmltools' successfully unpacked and MD5 sums checked
#> Warning: cannot remove prior installation of package 'htmltools'
#> Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying
#> C:\Users\mcguz\AppData\Local\R\win-library\4.4\00LOCK\htmltools\libs\x64\htmltools.dll
#> to
#> C:\Users\mcguz\AppData\Local\R\win-library\4.4\htmltools\libs\x64\htmltools.dll:
#> Permission denied
#> Warning: restored 'htmltools'
#> 
#> The downloaded binary packages are in
#>  C:\Users\mcguz\AppData\Local\Temp\RtmpU1gGA5\downloaded_packages
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>       ✔  checking for file 'C:\Users\mcguz\AppData\Local\Temp\RtmpU1gGA5\remotes529c6c2f463b\castanedaM-nicheR_GSoC_2026_test_solutions-78ff3d8\hard_test_solution\hts/DESCRIPTION'
#>       ─  preparing 'hts':
#>    checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>       ─  building 'hts_0.0.1.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/mcguz/AppData/Local/R/win-library/4.4'
#> (as 'lib' is unspecified)
```

## Usage

Launch the Shiny application:

``` r
hts::run_app()
```

Run the processing workflow directly:

``` r
out <- hts::helper_bio(selected_bio = 1)
names(out)
#> [1] "bio_stack"   "bio"         "region"      "bio_cropped" "bio_masked"

terra::plot(out$bio_masked)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

## Package Contents

- `run_app()` - Launches the Shiny interface
- `helper_bio()` - Downloads and processes WorldClim bioclimatic data
- roxygen2 documentation
- DESCRIPTION file
- MIT License
- GitHub Actions configured to pass `R CMD check`
