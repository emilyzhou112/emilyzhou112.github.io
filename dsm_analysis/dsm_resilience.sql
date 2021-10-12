/* Select the OSM point features that are water amenities.
Create a table for these selected features. */

CREATE TABLE waterpoint AS
SELECT osm_id, st_transform(way,32737)::geometry(point,32737) as geom, name, amenity, man_made
FROM planet_osm_point
WHERE amenity ILIKE 'drinking_water'
OR amenity ILIKE 'water_point'
OR man_made ILIKE 'water_well'
OR man_made ILIKE 'water_tap';


/* Select the OSM polygons features that are water amenities.
Create a table for these selected features. */

CREATE TABLE waterpoly AS
SELECT osm_id, st_transform(way,32737)::geometry(polygon,32737) as geom, name, amenity, man_made
FROM planet_osm_polygon
WHERE amenity ILIKE 'drinking_water'
OR amenity ILIKE 'water_point'
OR man_made ILIKE 'water_well'
OR man_made ILIKE 'water_tap' ;


/* Create centriod for each feature in waterpoly.
   Combine the waterpoly table and the waterpoint table. */

CREATE TABLE water_amenity AS
SELECT osm_id, geom, name FROM waterpoint
UNION
SELECT osm_id, st_centroid(geom)::geometry(point,32737) as geom, name FROM waterpoly


/* Select the OSM point features that residential buildings.
Create a table for these selected features. */

CREATE TABLE respoint AS
SELECT osm_id,  st_transform(way,32737)::geometry(point,32737) as geom, building, amenity
FROM planet_osm_point
WHERE amenity IS NULL
AND building IS NOT NULL;

ALTER TABLE respoint
ADD COLUMN is_res boolean;

UPDATE respoint
SET is_res = TRUE
WHERE building ILIKE 'yes' OR building ILIKE 'residential';

DELETE FROM respoint
WHERE is_res IS NULL;


/* Select the OSM polygon features that residential buildings.
Create a table for these selected features. */

CREATE TABLE respoly AS
SELECT osm_id,  st_transform(way,32737)::geometry(polygon,32737) as geom, building, amenity
FROM planet_osm_polygon
WHERE amenity IS NULL
AND building IS NOT NULL;

ALTER TABLE respoly
ADD COLUMN is_res boolean;

UPDATE respoly
SET is_res = TRUE
WHERE building ILIKE 'yes' OR building ILIKE 'residential';

DELETE FROM respoly
WHERE is_res IS NULL;


/* Create centriod for each feature in respoly.
   Combine the respoly table and the respoint table. */

CREATE TABLE res AS
SELECT osm_id, geom, building FROM respoint
UNION
SELECT osm_id, st_centroid(geom)::geometry(point,32737) as geom, building FROM respoly


/* Subdivide the flood layer to get much smaller polygons. */

CREATE TABLE flood_divide as
SELECT st_subdivide(geom, 20)::geometry(polygon, 32737) as geom, flood_leve
FROM flood


/* Join the census data to wards. */

CREATE TABLE ward_census AS
SELECT wards.*, total_both as totalpop, total_male as male, total_fema as female
FROM wards LEFT JOIN census
ON wards.ward_name = census.ward_name AND wards.district_n = census.dis_name;


/* Compare water amenity to flood.
Add a column indicating if each water amenity is in the flood zone. */

ALTER TABLE water_amenity
ADD COLUMN isflood boolean;

UPDATE water_amenity
SET isflood = TRUE
FROM flood_divide
WHERE st_intersect(water_amenity.geom, flood_divide.geom);



/* Create service area for each water amenity using voronoi polygons. */

CREATE TABLE service_area AS
SELECT water.osm_id, water.name, water.isflood, vpoly.geom
FROM
    (SELECT (st_dump(st_voronoipolygons(st_collect(geom),0.0, (SELECT st_union(geom) FROM wards)))).geom::geometry(polygon,32737) AS geom FROM water_amenity) AS vpoly

JOIN water_amenity AS water
ON st_within(water.geom, vpoly.geom)


/* Join residential building with service ares.
Examine the accessibility to water amenity of each household during flood. */

CREATE TABLE water_accessibility AS
SELECT res.building, service_area.name, service_area.isflood, st_intersection(res.geom, service_area.geom)::geometry(point, 32737) AS geom
FROM res
LEFT JOIN service_area
ON st_intersects(res.geom, service_area.geom);


/* How many households' accessibility to water are affected during flood? Summarize the total? */

SELECT count(isflood) AS totalflood
FROM water_accessibility
WHERE isflood IS NOT NULL


/* Join residential buildings with ward. */

CREATE TABLE water_access_wards AS
SELECT ward_census.ward_name, water_accessibility.isflood, water_accessibility.building
FROM water_accessibility
LEFT JOIN ward_census
ON st_intersects(ward_census.utmgeom, water_accessibility.geom);


/* Group by ward and summarize count of total houses. */

CREATE TABLE wards_water_summary AS
SELECT ward_name, count(isflood) AS flood_houses, count(building) AS total_houses
FROM water_access_wards
GROUP BY ward_name;


/* Join it back to the ward_census layer for visualization. */

CREATE TABLE wards_water AS
SELECT ward_census.*, flood_houses, total_houses
FROM ward_census
LEFT JOIN wards_water_summary
ON ward_census.ward_name = wards_water_summary.ward_name;
