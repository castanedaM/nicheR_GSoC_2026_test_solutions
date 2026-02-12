#' Download and Process WorldClim Bioclim Data
#'
#' Downloads WorldClim global bioclimatic variables and processes
#' a selected BIO layer by cropping and masking it to South America.
#'
#' @param selected_bio Integer. Index of the BIO variable to extract.
#' Default is 1 (BIO1: Annual Mean Temperature).
#' @param shp_path Character. Path to the South America shapefile.
#' Default is \code{"./data/south_america/vc965bq8111.shp"}.
#' @param res Integer. WorldClim resolution in arc-minutes. Default is 10.
#' @param path Character. Directory where WorldClim files are downloaded.
#' Default is \code{tempdir()}.
#'
#' @details
#' The function:
#' \enumerate{
#'   \item Downloads WorldClim bioclim variables at the requested resolution.
#'   \item Extracts the selected BIO layer.
#'   \item Reads a South America shapefile.
#'   \item Crops and masks the BIO raster to South America.
#' }
#'
#' @return A named list with elements:
#' \describe{
#'   \item{bio_stack}{Full SpatRaster stack of WorldClim bioclim variables.}
#'   \item{bio}{Selected BIO layer (SpatRaster).}
#'   \item{region}{South America boundary as a terra SpatVector.}
#'   \item{bio_cropped}{Cropped BIO raster (SpatRaster).}
#'   \item{bio_masked}{Cropped and masked BIO raster (SpatRaster).}
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
                       shp_path = "./data/south_america/vc965bq8111.shp",
                       res = 10,
                       path = tempdir()){

  # Download WorldClim bioclimatic variables
  bio_stack <- geodata::worldclim_global(var = "bio", res = res, path = path)

  # Extract selected BIO layer
  bio <- bio_stack[[selected_bio]]

  # Read and convert region boundary
  region_sf <- sf::st_read(shp_path, quiet = TRUE)
  region <- terra::vect(region_sf)

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
