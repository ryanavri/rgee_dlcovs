# Load the required libraries
library(rgee)
library(sf)
library(raster)

# Initialize the Earth Engine API
ee_Initialize()

# Define a region of interest (Riau Province) using its name in GAUL dataset
riau <- ee$FeatureCollection('FAO/GAUL/2015/level1')$
  filter(ee$Filter$eq('ADM1_NAME', 'Riau'))

# Load datasets from GEE
mangroves <- ee$ImageCollection('LANDSAT/MANGROVE_FORESTS')$mosaic()$clip(riau)
elevation <- ee$Image('CGIAR/SRTM90_V4')$clip(riau)
slope <- ee$Terrain$slope(elevation)$clip(riau)

# Set visualization parameters (optional)
mangroves_vis <- list(min = 0, max = 1.0, palette = c('d40115'))
elevation_vis <- list(min = 0, max = 3000)
slope_vis <- list(min = 0, max = 60)
temperature_vis <- list(min = 250, max = 320, palette = c('blue', 'green', 'red'))

# Display datasets in R
Map$centerObject(riau, 7)
Map$addLayer(mangroves, mangroves_vis, 'Mangroves in Riau')
Map$addLayer(elevation, elevation_vis, 'Elevation in Riau')
Map$addLayer(slope, slope_vis, 'Slope in Riau')

# Define the file path and export parameters
output_path <- "path_to_save_files"  # Specify your output path

# Function to export each dataset to local drive
download_gee_to_local <- function(ee_image, region, scale, file_name) {
  ee_as_raster(
    image = ee_image,
    region = region$geometry(),
    scale = scale,
    dsn = file.path(output_path, file_name)
  )
}

# Download datasets
download_gee_to_local(mangroves, riau, 30, 'Mangroves_Riau.tif')
download_gee_to_local(elevation, riau, 90, 'Elevation_Riau.tif')
download_gee_to_local(slope, riau, 90, 'Slope_Riau.tif')
download_gee_to_local(temperature, riau, 10000, 'Annual_Temperature_Riau.tif')
