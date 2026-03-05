# Title: Easy Test Solution
# Evaluating Mentor: Marlon Cobos
# Contributor: Mariana Castaneda Guzman
# Date last updated: 03/05/2026

# Test Prompt and Level ---------------------------------------------------

# Test Level: Easy

# Test Promt: 
# 1. Install and load the packages terra and geodata.
# 2. Download WorldClim bioclimatic variables at 10 arc minute resolution.
# 3. Extract BIO1 (Annual Mean Temperature) from the dataset.
# 4. Crop or mask BIO1 to an extent covering South America (polygon or bounding box acceptable).
# 5. Plot the final processed raster.


# Test Solution -----------------------------------------------------------

# 1. Install and load the packages terra and geodata.
if(!require("terra")) install.packages("terra")
if(!require("geodata")) install.packages("geodata")
if(!require("sf")) install.packages("sf")
if(!require("rnaturalearthdata")) install.packages("rnaturalearthdata")

# 2. Download WorldClim bioclimatic variables at 10 arc minute resolution.
bio_data <- geodata::worldclim_global(var = "bio", res = 10, path = tempdir())
names(bio_data)
bio <- 1

# 3. Extract BIO1 (Annual Mean Temperature) from the dataset.
selected_bio <- bio_data[[bio]]

# 4. Crop or mask BIO1 to an extent covering South America (polygon or bounding box acceptable).
world <- rnaturalearthdata::sovereignty50
continent_selection <- "South America"

# Cropping and masking
continent_vect <-   sf::st_as_sf(world[world$continent == continent_selection, ])

bio_cropped <- terra::crop(x = selected_bio, y = continent_vect)
bio_cropped_masked <- terra::mask(x = bio_cropped, mask = continent_vect)

# 5. Plot the final processed raster.
terra::plot(bio_cropped_masked)
