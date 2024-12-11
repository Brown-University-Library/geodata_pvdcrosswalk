/*
Spatial Joins - Create new columns in blocks table, and assign identifiers
of other geographies to the blocks. ZCTAs and neighborhoods work perfectly as 
they are built from same geography. Wards required a few manual fixes after 
executing.
*/

ALTER TABLE pvd_blocks_2020
ADD COLUMN zcta_2020 TEXT;

UPDATE pvd_blocks_2020
SET zcta_2020 = z.zcta5ce20
FROM (SELECT zcta5ce20, geom FROM pvd_zctas_2020) AS z
WHERE ST_Within(pvd_blocks_2020.geom,z.geom);

ALTER TABLE pvd_blocks_2020
ADD COLUMN nbhood_2020 TEXT;

UPDATE pvd_blocks_2020
SET nbhood_2020 = n.nbhood
FROM (SELECT nbhood, geom FROM pvd_nbhoods_2020) AS n
WHERE ST_Within(pvd_blocks_2020.geom,n.geom);

ALTER TABLE pvd_blocks_2020
ADD COLUMN ward_2022 TEXT;

UPDATE pvd_blocks_2020
SET ward_2022 = d.district
FROM (SELECT district, geom FROM pvd_wards_2022) AS d
WHERE ST_Within(ST_Centroid(pvd_blocks_2020.geom),d.geom);

UPDATE geometry_columns_statistics set last_verified = 0;
SELECT UpdateLayerStatistics();