### -----------------------------
### simon munzert
### intro to web scraping with R
### -----------------------------

## preparations -----------------------
source("packages.r")


## inspect the source code in your browser ---------------

browseURL("http://www.biermap24.de/brauereiliste.php") 


# Chrome:
# 1. right click on page
# 2. select "view source"

# Firefox:
# 1. right click on page
# 2. select "view source"

# Microsoft Edge:
# 1. right click on page
# 2. select "view source"

# Safari
# 1. click on "Safari"
# 2. select "Preferences"
# 3. go to "Advanced"
# 4. check "Show Develop menu in menu bar"
# 5. click on "Develop"
# 6. select "show page source"
# 7. alternatively to 5./6., right click on page and select "view source"



## case study 1: map breweries in Germany -------

##  goal
# get list of breweries in Germany
# import list in R
# geolocate breweries
# put them on a map

# set temporary working directory
tempwd <- ("../data/breweriesGermany")
dir.create(tempwd)
setwd(tempwd)

## step 1: fetch list of cities with breweries
url <- "http://www.biermap24.de/brauereiliste.php"
content <- read_html(url)
anchors <- html_nodes(content, xpath = "//tr/td[2]")
cities <- html_text(anchors)
cities
cities <- str_trim(cities)
cities <- cities[str_detect(cities, "^[[:upper:]]+.")]
cities <- cities[6:length(cities)]
length(cities)
length(unique(cities))
sort(table(cities))


## step 2: geocode cities

# geocoding takes a while -> save results in local cache file
# 2500 requests allowed per day
if ( !file.exists("breweries_geo.RData")){
  pos <- geocode(cities)
  geocodeQueryCheck()
  save(pos, file="breweries_geo.RData")
} else {
  load("breweries_geo.RData")
}
head(pos)

# Geolocate observations with OpenStreetMap API and nominatim package
# devtools::install_github("hrbrmstr/nominatim")
# library(nominatim)
# # get fre API key at browseURL("https://developer.mapquest.com/")
# load("/Users/simonmunzert/rkeys.RDa")
# coordinates_list <- map(cities, osm_geocode, key = openstreetmap)
# coordinates_df <- bind_rows(coordinates_list)
# save(coordinates_df, file = "breweries_geodata.RData")

# just load prepared data
load("breweries_geodata.RData")


## step 3: plot breweries of Germany
ger_bbox <- c(5.98865807458, 47.3024876979, 15.0169958839, 54.983104153)
ger_map <- get_stamenmap(bbox = ger_bbox,
                         zoom = 6, 
                         maptype = "terrain-background")
ggmap(ger_map) + 
  geom_point(data = coordinates_df, aes(x = lon, y = lat), 
             color = "red", size = 1)
