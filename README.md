# AustraliaTourismGeospatialAnalysis

# Enhancing Tourist Experience through Spatial Analysis of Accommodations and Food & Drink Places in Australia

## Overview

This project applies advanced geospatial analysis using QGIS and SQL to optimize and visualize tourism infrastructure in Australia. The analysis is focused on three core datasets—Destinations, Accommodations, and Food & Drink Places—demonstrating how spatial distribution and quality ratings inform business strategies and enhance the visitor experience.

- **Technologies Used:** QGIS, PostgreSQL/PostGIS, SQL, Data Visualization
- **Files Included:** Presentation (PPTX), Dataset SQL scripts, Analytical SQL views, Video walkthrough

## Project Scope

1. **Spatial Analysis:** Visualization and mapping of tourist destinations, accommodations, and dining options across Australian districts.
2. **Decision Factors:** Studying proximity and service diversity to understand influences on tourist choices.
3. **Ratings Integration:** Leveraging user ratings in decision-making to support preference-based recommendations.
4. **Custom SQL Views:** Find top accommodations, top food & drink establishments, and proximity-based suggestions using advanced SQL queries.

## Dataset
- **Source:** Australian Geofabric (OpenStreetMap, QGIS Geopackages)
- SQL scripts provided for creation and population of tables (`Destinations`, `Accommodations`, `FoodNDrinks`), including clustering indices and randomly generated ratings for demo purposes.
- Administrative districts (`Australia` table) are used for region-based analysis.

## Key SQL Views

- **DestinationPerDistrictView:** Counts tourist destinations per district.
- **TopAccommodationsView/TopFoodNDrinksView:** Lists the highest-rated places per region.
- **FavoriteDestinations:** Subset of notable/favorite locations for custom analysis.
- **ClosestAccommodationView/ClosestFoodNDrinkView:** Calculates nearest accommodation and dining options for selected destinations.

## How to Run

1. Import `Datasets.sql` into your PostGIS/PostgreSQL database.
2. Execute queries from `VisualizationQueries.sql` in your SQL client.
3. Visualize results in QGIS or your preferred GIS tool using the exported geometry.
4. Review the included `AustraliaTourism.pptx` for project summary and findings.
5. Refer to the included video for an overview and demonstration.

## About the Author

Created by Vaishnavi Gonekar, this repository showcases practical, analytical, and presentation abilities suited for geospatial analyst, data engineering, or tourism intelligence roles.

---

**Data Analysis • Geospatial Intelligence • QGIS • SQL • Australian Tourism**  
