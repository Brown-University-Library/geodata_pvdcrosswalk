-- Tracts to Neighborhoods
CREATE VIEW v_tract2020_to_nbhood2020 AS
WITH crosswalk AS (
  SELECT "1400000US"||substr(geoid20,1,11) AS geoid_long, substr(geoid20,1,11) AS geoid_short, tractce20, cast(rtrim(rtrim(tractce20 /100.0, '0'), '.') as text) as tract_short, nbhood_2020, 
  SUM(pop20) AS pop, SUM(housing20) as houses,
  ROUND(SUM(aland20)/2589988.11,4) AS land_sqmi, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as area_sqmi
  FROM pvd_blocks_2020
  GROUP BY tractce20, nbhood_2020
),
area_totals AS (
  SELECT tractce20, SUM(pop20) AS all_pop, SUM(housing20) as all_houses,
  ROUND(SUM(aland20)/2589988.11,4) AS all_land, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as all_area
  FROM pvd_blocks_2020
  GROUP BY tractce20
)
SELECT 
  c.geoid_long, c.geoid_short, c.tractce20, c.tract_short, c.nbhood_2020, 
  c.pop, ROUND(cast(c.pop AS real) / cast(a.all_pop AS real),3) AS pct_pop,
  c.houses, ROUND(cast(c.houses AS real) / cast(a.all_houses AS real),3) AS pct_hous,
  c.land_sqmi, ROUND(c.land_sqmi / a.all_land,3) AS pct_land,
  c.area_sqmi, ROUND(c.area_sqmi / a.all_area,3) AS pct_area
FROM crosswalk c, area_totals a
WHERE c.tractce20=a.tractce20;

-- Tracts to Wards
CREATE VIEW v_tract2020_to_ward2022 AS
WITH crosswalk AS (
  SELECT "1400000US"||substr(geoid20,1,11) AS geoid_long, substr(geoid20,1,11) AS geoid_short, tractce20, cast(rtrim(rtrim(tractce20 /100.0, '0'), '.') as text) as tract_short, ward_2022, 
  SUM(pop20) AS pop, SUM(housing20) as houses,
  ROUND(SUM(aland20)/2589988.11,4) AS land_sqmi, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as area_sqmi
  FROM pvd_blocks_2020
  GROUP BY tractce20, ward_2022
),
area_totals AS (
  SELECT tractce20, SUM(pop20) AS all_pop, SUM(housing20) as all_houses,
  ROUND(SUM(aland20)/2589988.11,4) AS all_land, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as all_area
  FROM pvd_blocks_2020
  GROUP BY tractce20
)
SELECT 
  c.geoid_long, c.geoid_short, c.tractce20, c.tract_short, c.ward_2022, 
  c.pop, ROUND(cast(c.pop AS real) / cast(a.all_pop AS real),3) AS pct_pop,
  c.houses, ROUND(cast(c.houses AS real) / cast(a.all_houses AS real),3) AS pct_hous,
  c.land_sqmi, ROUND(c.land_sqmi / a.all_land,3) AS pct_land,
  c.area_sqmi, ROUND(c.area_sqmi / a.all_area,3) AS pct_area
FROM crosswalk c, area_totals a
WHERE c.tractce20=a.tractce20;

-- ZCTAs to Neighborhoods
CREATE VIEW v_zcta2020_to_nbhood2020 AS
WITH crosswalk AS (
  SELECT "860Z200US"||zcta_2020 as geoid_long, zcta_2020, nbhood_2020, 
  SUM(pop20) AS pop, SUM(housing20) as houses,
  ROUND(SUM(aland20)/2589988.11,4) AS land_sqmi, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as area_sqmi
  FROM pvd_blocks_2020
  GROUP BY zcta_2020, nbhood_2020
),
area_totals AS (
  SELECT ZCTA AS zcta_2020, POP AS all_pop, HUNITS as all_houses,
  ROUND(AREALAND/2589988.11,4) AS all_land, 
  ROUND((AREALAND + AREAWATR)/2589988.11,4) as all_area
  FROM pvd_zctas_2020_poptotals
)
SELECT 
  c.geoid_long, c.zcta_2020, c.nbhood_2020, 
  c.pop, ROUND(cast(c.pop AS real) / cast(a.all_pop AS real),3) AS pct_pop,
  c.houses, ROUND(cast(c.houses AS real) / cast(a.all_houses AS real),3) AS pct_hous,
  c.land_sqmi, ROUND(c.land_sqmi / a.all_land,3) AS pct_land,
  c.area_sqmi, ROUND(c.area_sqmi / a.all_area,3) AS pct_area
FROM crosswalk c, area_totals a
WHERE c.zcta_2020=a.zcta_2020;

-- ZCTAs to Wards
CREATE VIEW v_zcta2020_to_ward2022 AS
WITH crosswalk AS (
  SELECT "860Z200US"||zcta_2020 as geoid_long, zcta_2020, ward_2022, 
  SUM(pop20) AS pop, SUM(housing20) as houses,
  ROUND(SUM(aland20)/2589988.11,4) AS land_sqmi, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as area_sqmi
  FROM pvd_blocks_2020
  GROUP BY zcta_2020, ward_2022
),
area_totals AS (
  SELECT ZCTA AS zcta_2020, POP AS all_pop, HUNITS as all_houses,
  ROUND(AREALAND/2589988.11,4) AS all_land, 
  ROUND((AREALAND + AREAWATR)/2589988.11,4) as all_area
  FROM pvd_zctas_2020_poptotals
)
SELECT 
  c.geoid_long, c.zcta_2020, c.ward_2022, 
  c.pop, ROUND(cast(c.pop AS real) / cast(a.all_pop AS real),3) AS pct_pop,
  c.houses, ROUND(cast(c.houses AS real) / cast(a.all_houses AS real),3) AS pct_hous,
  c.land_sqmi, ROUND(c.land_sqmi / a.all_land,3) AS pct_land,
  c.area_sqmi, ROUND(c.area_sqmi / a.all_area,3) AS pct_area
FROM crosswalk c, area_totals a
WHERE c.zcta_2020=a.zcta_2020;

-- Block List
CREATE VIEW v_blocks2020_pvd AS
SELECT geoidfq20 as geoid_long, geoid20 as geoid_short, tractce20, blockce20,
pop20, housing20,  ROUND(aland20/2589988.11,4) AS land_sqmi, ROUND((aland20 + awater20)/2589988.11,4) as area_sqmi,  
cast(rtrim(rtrim(tractce20 /100.0, '0'), '.') as text) as tract_short, zcta_2020, nbhood_2020, ward_2022
FROM pvd_blocks_2020
ORDER BY geoid_long;

-- Block Groups to Neighborhoods
CREATE VIEW v_bgroup2020_to_nbhood2020 AS
WITH crosswalk AS (
  SELECT "1500000US"||substr(geoid20,1,12) AS geoid_long, substr(geoid20,1,12) AS geoid_short, tractce20 || substr(blockce20,1,1) AS tract_bg, substr(blockce20,1,1) AS bgroup, nbhood_2020, 
  SUM(pop20) AS pop, SUM(housing20) as houses,
  ROUND(SUM(aland20)/2589988.11,4) AS land_sqmi, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as area_sqmi
  FROM pvd_blocks_2020
  GROUP BY tract_bg, nbhood_2020
),
area_totals AS (
  SELECT tractce20 || substr(blockce20,1,1) as tract_bg, SUM(pop20) AS all_pop, SUM(housing20) as all_houses,
  ROUND(SUM(aland20)/2589988.11,4) AS all_land, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as all_area
  FROM pvd_blocks_2020
  GROUP BY tract_bg
)
SELECT 
  c.geoid_long, c.geoid_short, c.tract_bg, c.bgroup, c.nbhood_2020, 
  c.pop, ROUND(cast(c.pop AS real) / cast(a.all_pop AS real),3) AS pct_pop,
  c.houses, ROUND(cast(c.houses AS real) / cast(a.all_houses AS real),3) AS pct_hous,
  c.land_sqmi, ROUND(c.land_sqmi / a.all_land,3) AS pct_land,
  c.area_sqmi, ROUND(c.area_sqmi / a.all_area,3) AS pct_area
FROM crosswalk c, area_totals a
WHERE c.tract_bg=a.tract_bg;

-- Block Groups to Wards
CREATE VIEW v_bgroup2020_to_ward2022 AS
WITH crosswalk AS (
  SELECT "1500000US"||substr(geoid20,1,12) AS geoid_long, substr(geoid20,1,12) AS geoid_short, tractce20 || substr(blockce20,1,1) AS tract_bg, substr(blockce20,1,1) AS bgroup, ward_2022, 
  SUM(pop20) AS pop, SUM(housing20) as houses,
  ROUND(SUM(aland20)/2589988.11,4) AS land_sqmi, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as area_sqmi
  FROM pvd_blocks_2020
  GROUP BY tract_bg, ward_2022
),
area_totals AS (
  SELECT tractce20 || substr(blockce20,1,1) as tract_bg, SUM(pop20) AS all_pop, SUM(housing20) as all_houses,
  ROUND(SUM(aland20)/2589988.11,4) AS all_land, 
  ROUND(SUM(aland20 + awater20)/2589988.11,4) as all_area
  FROM pvd_blocks_2020
  GROUP BY tract_bg
)
SELECT 
  c.geoid_long, c.geoid_short, c.tract_bg, c.bgroup, c.ward_2022, 
  c.pop, ROUND(cast(c.pop AS real) / cast(a.all_pop AS real),3) AS pct_pop,
  c.houses, ROUND(cast(c.houses AS real) / cast(a.all_houses AS real),3) AS pct_hous,
  c.land_sqmi, ROUND(c.land_sqmi / a.all_land,3) AS pct_land,
  c.area_sqmi, ROUND(c.area_sqmi / a.all_area,3) AS pct_area
FROM crosswalk c, area_totals a
WHERE c.tract_bg=a.tract_bg;