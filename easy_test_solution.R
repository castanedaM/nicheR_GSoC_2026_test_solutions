# Title: Easy Test Solution
# Evaluating Mentor: Marlon Cobos
# Student: Mariana Castaneda Guzman
# Date created: 02/06/2026
# Date last updated: 02/09/2026


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

# 2. Download WorldClim bioclimatic variables at 10 arc minute resolution.
bio_data <- geodata::worldclim_global(var = "bio", res = 10, path = tempdir())
names(bio_data)

# 3. Extract BIO1 (Annual Mean Temperature) from the dataset.
bio1 <- bio_data[[1]]

# 4. Crop or mask BIO1 to an extent covering South America (polygon or bounding box acceptable).
if(!require("sf")) install.packages("sf")

# Original shpaefile from: https://earthworks.stanford.edu/catalog/stanford-vc965bq8111
south_america <- sf::st_read("./data/south_america/vc965bq8111.shp")

bio1_cropped <- terra::crop(x = bio1, y = south_america)
bio1_cropped_masked <- terra::mask(x = bio1_cropped, mask = south_america)


# 5. Plot the final processed raster.
terra::plot(bio1_cropped_masked)
