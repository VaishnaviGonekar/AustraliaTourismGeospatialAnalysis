--Queries -- Create Views Instead of All Tables --

--View to find all destinations within each Austrlian district
DROP VIEW IF EXISTS DestinationPerDistrictView;
CREATE OR REPLACE VIEW DestinationPerDistrictView AS
SELECT Au.id, Au.geom, Au.name, count(*) as DestinationsCount
FROM Australia Au, Destinations D
WHERE ST_Contains(Au.geom, D.wkb_geometry)
GROUP BY Au.id;

---Top Accommodations Per District
DROP VIEW IF EXISTS TopAccommodationsView;
CREATE OR REPLACE VIEW TopAccommodationsView AS
WITH RankedAccommodations AS (
    SELECT
        Au.name AS name,
		A.ogc_fid Accommodation_id,
        A.name AS accommodation_name,
        A.rating AS rating,
	    A.wkb_geometry as accommodation_geometry,
        ROW_NUMBER() OVER (PARTITION BY Au.id ORDER BY A.rating DESC) AS rnk
    FROM
        Australia Au,
        Accommodation A
    WHERE
        ST_Contains(Au.geom, A.wkb_geometry)
)
SELECT
    name,
	Accommodation_id,
    accommodation_name,
	rating,
	accommodation_geometry
FROM
    RankedAccommodations
WHERE
    rnk <= 10;
	
select * from TopAccommodationsView;

--Top Food and Drink Places per district
DROP VIEW IF EXISTS TopFoodNDrinksView;
CREATE OR REPLACE VIEW TopFoodNDrinksView AS
WITH RankedFoodNDrinks AS (
    SELECT
        Au.name AS name,
	    FD.ogc_fid as place_id,
        FD.name AS place_name,
        FD.rating AS rating,
	    FD.wkb_geometry as place_geometry,
        ROW_NUMBER() OVER (PARTITION BY Au.id ORDER BY FD.rating DESC) AS rnk
    FROM
        Australia Au,
        FoodNDrinks FD
    WHERE
        ST_Contains(Au.geom, FD.wkb_geometry)
)
SELECT
    name,
	place_id,
    place_name,
    rating,
	place_geometry
FROM
    RankedFoodNDrinks
WHERE
    rnk <= 10;
	
select * from TopFoodNDrinksView;

----Interested Destinations
DROP VIEW IF EXISTS FavoriteDestinations;
CREATE OR REPLACE VIEW FavoriteDestinations AS
SELECT ogc_fid, wkb_geometry, name 
FROM Destinations
WHERE name IN ('Red Rock Walking Trail Carpark', 'Blue Mountains Lavender Farm', 'Bay of Islands', 
                 'Wooden bridge', 'historical museum', 'Central Coast Zoo', 'Golden Gate Reef');

------------
DROP VIEW IF EXISTS ClosestAccommodationView;
CREATE OR REPLACE VIEW ClosestAccommodationView AS
WITH DestinationList AS (
    SELECT
		wkb_geometry as destination_geometry,
        name AS destination_name
    FROM
        Destinations
    WHERE
        name IN ('Red Rock Walking Trail Carpark', 'Blue Mountains Lavender Farm', 'Bay of Islands', 
                 'Wooden bridge', 'historical museum', 'Central Coast Zoo', 'Golden Gate Reef')
)

SELECT
    DL.destination_name,
    DL.destination_geometry,
    A.ogc_fid AS accommodation_id,
    A.name AS accommodation_name,
    A.wkb_geometry AS accommodation_geometry,
    ST_Distance(DL.destination_geometry, A.wkb_geometry) AS accommodation_distance
FROM
    DestinationList DL
CROSS JOIN LATERAL (
    SELECT
        ogc_fid,
        name,
        wkb_geometry
    FROM
        Accommodation
    ORDER BY
        DL.destination_geometry <-> wkb_geometry
    LIMIT 5
) A
ORDER BY DL.destination_name;


select * from ClosestAccommodationView;

---------------
DROP VIEW IF EXISTS ClosestFoodNDrinkView;
CREATE OR REPLACE VIEW ClosestFoodNDrinkView AS
WITH DestinationList AS (
    SELECT
        wkb_geometry AS destination_geometry,
        name AS destination_name
    FROM
        Destinations
    WHERE
        name IN ('Red Rock Walking Trail Carpark', 'Blue Mountains Lavender Farm', 'Bay of Islands', 
                 'Wooden bridge', 'historical museum', 'Central Coast Zoo', 'Golden Gate Reef')
)

SELECT
    DL.destination_name,
    DL.destination_geometry,
    FD.ogc_fid AS food_drink_id,
    FD.name AS food_drink_name,
    FD.wkb_geometry AS food_drink_geometry,
    ST_Distance(DL.destination_geometry, FD.wkb_geometry) AS food_drink_distance
FROM
    DestinationList DL
CROSS JOIN LATERAL (
    SELECT
        ogc_fid,
        name,
        wkb_geometry
    FROM
        FoodNDrinks
    ORDER BY
        DL.destination_geometry <-> wkb_geometry
    LIMIT 5
) FD
ORDER BY DL.destination_name;


select * from ClosestFoodNDrinkView;
