#' Download and Process WorldClim Bioclim Data
#'
#' Downloads WorldClim bioclimatic variables and extracts a selected BIO
#' layer. The layer is then cropped and masked to a chosen continent
#' (default is South America).
#'
#' @param bio Integer. Index of the BIO variable to extract. Default is 1
#' (BIO1: Annual Mean Temperature).
#' @param region Character. Continent to crop and mask the raster to.
#' Default is "South America".
#' @param res Integer. WorldClim resolution in arc minutes. Default is 10.
#' @param bio_path Character. Directory where WorldClim files are downloaded.
#' Default is \code{tempdir()}.
#'
#' @return A list containing the full bioclim stack, the selected BIO layer,
#' the cropped raster, and the cropped and masked raster.
#'
#' @export
helper_bio <- function(bio = 1,
                       region = "South America",
                       res = 10,
                       bio_path = tempdir()){

  # 2. Download WorldClim bioclimatic variables at 10 arc minute resolution.
  bio_data <- geodata::worldclim_global(var = "bio",
                                        res = res,
                                        path = bio_path)

  # 3. Extract BIO1 (Annual Mean Temperature) from the dataset.
  bio <- as.integer(bio)
  selected_bio <- bio_data[[bio]]

  # 4. Crop or mask BIO1 to an extent covering South America (polygon or bounding box acceptable).
  world <- rnaturalearthdata::sovereignty50

  # Cropping and masking
  continent_vect <-   sf::st_as_sf(world[world$continent == region, ])

  bio_cropped <- terra::crop(x = selected_bio, y = continent_vect)
  bio_cropped_masked <- terra::mask(x = bio_cropped, mask = continent_vect)


  return(list(
    bio_stack = bio_data,
    bio = selected_bio,
    region = region,
    bio_cropped = bio_cropped,
    bio_masked = bio_cropped_masked
  ))
}
