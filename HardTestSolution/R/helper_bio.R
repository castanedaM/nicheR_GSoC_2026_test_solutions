#' Download and Process WorldClim Bioclimatic Data
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
  selected_bio <- bio_data[[bio]]

  # 4. Crop or mask BIO1 to an extent covering South America (polygon or bounding box acceptable).
  world <- rnaturalearthdata::sovereignty50
  unique(world$continent)
  continent_selection <- region

  # Cropping and masking
  continent_vect <-   sf::st_as_sf(world[world$continent == continent_selection, ])

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
