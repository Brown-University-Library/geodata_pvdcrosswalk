/*
Create a new table where names from the original neighborhood file are assigned 
to census blocks where the center of the block falls within the neighborhood.
Once complete, the file was visually inspected and blocks were manually re-assigned
if the centroid assignment was a poor match.
*/

CREATE TABLE blk_nbhood_orig (
id INTEGER NOT NULL PRIMARY KEY,
geoid20 TEXT,
geoidfq20 TEXT,
name20 TEXT,
housing20 INTEGER,
pop20 INTEGER,
nbhood TEXT,
reassign TEXT CHECK(reassign IN ('TRUE','FALSE'))
);

SELECT AddGeometryColumn('blk_nbhood_orig', 'geom', 3438, 'MULTIPOLYGON', 'XY');

SELECT CreateSpatialIndex ('blk_nbhood_orig','geom');

INSERT INTO blk_nbhood_orig
SELECT b.id, b.geoid20, b.geoidfq20, b.name20, b.housing20, b.pop20, n.lname, 'FALSE', b.geom
FROM pvd_blocks_2020 b, pvd_nbhoods_orig n
WHERE ST_Within(ST_Centroid(b.geom),n.geom);
