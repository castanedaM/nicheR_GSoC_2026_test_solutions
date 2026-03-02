#' Download and Process WorldClim Bioclimatic Data
#'
#' Downloads WorldClim global bioclimatic variables and processes a selected
#' BIO layer by cropping and masking it to a South America boundary.
#'
#' @param selected_bio Integer. Index of the BIO variable to extract.
#'   Default is 1 (BIO1: Annual Mean Temperature).
#' @param shp_path Character or NULL. Path to a South America shapefile. If NULL,
#'   a packaged boundary file is used (see Details).
#' @param res Integer. WorldClim resolution in arc minutes. Default is 10.
#' @param path Character. Directory where WorldClim files are downloaded.
#'   Default is \code{tempdir()}.
#'
#' @details
#' The function:
#' \enumerate{
#'   \item Downloads WorldClim bioclimatic variables at the requested resolution.
#'   \item Extracts the selected BIO layer by index.
#'   \item Loads a South America boundary from \code{shp_path} when provided,
#'   otherwise loads a packaged \code{.rds} boundary file.
#'   \item Crops and masks the BIO raster to the boundary.
#' }
#'
#' If \code{shp_path} is NULL, the function expects a boundary file named
#' \code{"south_america.rds"} to be available. In an R package, store this file
#' in \code{inst/extdata/} and load it with \code{system.file()} (recommended).
#'
#' @return A named list with:
#' \describe{
#'   \item{bio_stack}{SpatRaster. Full stack of WorldClim bioclimatic variables.}
#'   \item{bio}{SpatRaster. Selected BIO layer.}
#'   \item{region}{SpatVector. South America boundary.}
#'   \item{bio_cropped}{SpatRaster. Cropped BIO raster.}
#'   \item{bio_masked}{SpatRaster. Cropped and masked BIO raster.}
#' }
#'
#' @examples
#' \dontrun{
#' out <- helper_bio()
#' plot(out$bio_masked)
#' }
#'
#' @export
helper_bio <- function(selected_bio = 1,
                       shp_path = NULL,
                       res = 10,
                       path = tempdir()){

  # Download WorldClim bioclimatic variables
  bio_stack <- geodata::worldclim_global(var = "bio", res = res, path = path)

  # Extract selected BIO layer
  bio <- bio_stack[[selected_bio]]

  # Read and convert region boundary
  if(!is.null(shp_path)){
    region_sf <- sf::st_read(shp_path, quiet = TRUE)
    region <- terra::vect(region_sf)
  }else{
    region <- readRDS("./inst/extdata/south_america.rds")
  }

  # Crop + mask
  bio_cropped <- terra::crop(x = bio, y = region)
  bio_masked  <- terra::mask(x = bio_cropped, mask = region)

  return(list(
    bio_stack = bio_stack,
    bio = bio,
    region = region,
    bio_cropped = bio_cropped,
    bio_masked = bio_masked
  ))
}
