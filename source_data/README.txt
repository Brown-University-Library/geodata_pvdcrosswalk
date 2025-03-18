Providence Census Geography Crosswalk
Frank Donnelly, Head of GIS & Data Services
Brown University Library
October 28, 2024 / Revised Mar 17, 2025

---------------------------------------------

This document describes the process for creating the Providence Census Geography Crosswalk, which relates 2020 census tract and ZIP Code Tabulation Area (ZCTA) geographies to neighborhood and ward boundaries for Providence, Rhode Island. Block groups were added as an additional geography, in a second version released in spring 2025.

DATA PREPARATION

1. Downloaded 2023 TIGER Line Files (2020 census geography) for census blocks, tracts, and county subdivisions for Rhode Island and ZCTAs for the US
https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2023.html

2. Downloaded 2022 Wards and Neighborhoods from Providence GIS
https://providence-gis-hub-pvdgis.hub.arcgis.com/

3. In QGIS, created a new Spatialite database called pvd_geo_crosswalk.sqlite

4. Added the county subdivisions, and selected the City of Providence

5. Used Vector - Research Tools - Select by Location, selected all census blocks that are within the city (selected feature only from the county subdivisions). 

6. In the DB Manager, opened the pvd_geo_crosswalk database, and imported only the selected features from the blocks. Checked default primary key and geometry column, default source SRID, changed target SRID to EPSG 3438 NAD83 / Rhode Island (ft/US), and checked spatial index. New layer: pvd_blocks_2020.

7. Repeated steps 5 and 6 for tracts layer, created new layer: pvd_tracts_2020.

8. Repeated steps 5 and 6 for ZCTAs, but when selecting used intersect instead of within, and manually removed ZCTAs that were wholly outside of Providence. Created new layer: pvd_zctas_2020.

9. Imported the county subdivision layer with just Providence selected into the database as new layer: pvd_bndy_census_2020.

10. Imported the entire RI county subdivision layer into the database as new layer: ri_csubdiv_2020.

11. Imported the wards boundaries into the database, transformed to EPSG 3438 as pvd_wards_2022.

12. In the processing toolbox, used Define shapefile projection to set the system for the neighborhoods to EPSG 3438, as it was not properly defined. Imported the neighborhoods into the database, as pvd_nbhoods_orig.

13. Used data.census.gov to downloaded ZCTA-level population and housing units counts from the 2020 census, and geographic information on area from the 2023 Geoinfo table for the 13 ZCTAs that fall wholly or partially within Providence. Combined this data in one spreadsheet called pvd_zctas_2020census.xlsx, and imported into the database as a table called pvd_zctas_2020_poptotals.

NEIGHBORHOOD RECREATION

The boundaries for the neighborhoods do not align perfectly with the 2020 census blocks, as they were created based on older census geography. Before creating the crosswalk, new neighborhood boundaries were generated from the 2020 blocks.

1. Ran the SQL script blks_to_nbhoods_orig.sql, to create a new spatial layer called blk_nbhood_orig where blocks were assigned the name of the neighborhood based on where the center of the block fell.

2. Block 1005, id 110, in the far southeastern corner of Providence was dropped after step 1 was executed because its centroid fell outside the boundary of the Washington Park. It was manually copied and pasted from the original block layer to blk_nbhood_orig.

3. Scrutinized the overlap between blocks and neighborhood boundaries, and in the attribute table re-assigned blocks in cases where the centroid assignment was not ideal, or the blocks created oddly shaped areas that no longer reflected the original neighborhood boundaries. ALso overlaid the census tract boundary, and assigned unpopulated blocks that were highway or water slivers to a neighborhood to avoid tract splitting when possible. When reassigning, the neighborhood name was changed, and the reassign field changed from FALSE to TRUE. In all but two cases, blocks that were reassigned were not populated, and contained either expressways or water bodies.

4. Ran Vector - Geoprocessing Tools - Dissolve on blk_nbhood_orig, selected the nbhood field to dissolve blocks into neighborhoods. Saved as a shapefile called temporary_new_nbhoods. Went into the attribute table, entered edit mode, and deleted all the columns except for the neighborhood name.

5. Went into the DB Manager, and imported the temporary_new_nbhoods shapefile as a new table called: pvd_nbhoods_2020. Took defaults for primary key, geometry, SRIDs, and added spatial index.

CREATING CROSSWALK

The crosswalks were created by using subqueries. Four characteristics were captured: 2020 population, 2020 housing units, land area, and total area (land and water). The area characteristics were converted from square meters to square miles. Tract crosswalks were created by selecting and aggregtaing / grouping the blocks that fell within each distinct tract / neighboorhood and ward combination in the crosswalk subsuqery. The area_totals subquery grouped the block characteristics by tract to obtain tract-level totals. The SELECT statement drew from both queries, divding the portion areas by the total tract areas to obtain percentages. ZCTA crosswalks were created in a similar fashion, except that the areas_total subquery drew pre-existing ZCTA characteristic totals from the pvd_zctas_2020_poptotals table. This was necessary because large portions of the ZCTAs fall outside the Providence boundary and are thus not captured in the Providence block statistics. ZCTA totals were need to correctly calculate the percentage of the total ZCTA that fell within each neighborhood or ward.

1. Ran the SQL statements in spatial_joins.sql to create new columns in pvd_blocks_2020 and assign them the ZCTA, neighborhood, and ward IDs based on where the block geometry falls within those areas. Used Within for ZCTAs and neighborhoods since they were built from the same base geography. There was a mismatch with wards, so did block centroids within instead.

2. Block centroids within led to a mismatch in ward assignment for a small number of oddly shaped blocks, checked them and edited the attribute table directly to fix assignments. Visually verified match between block categorization and their assigned areas.

3. Ran the SQL statements in create_crosswalks.sql to create four views in the database: v_tract2020_to_nbhood2020, v_tract2020_to_ward2022, v_zcta2020_to_nbhood2020, v_zcta2020_to_ward2022.

4. After manually verifying a sample of the output, exported each view as CSV files, imported them into Excel as separate sheets. Modified various aspects of the Excel file for stylistic purposes.

UPDATES MARCH 2025

Census block groups were added as an additional geography in an update to the crosswalk in spring 2025. Steps in DATA PREPARATION were repeated to add a new block group layer called pvd_bgroups_2020 to the spatial database. Steps in CREATING CROSSWALK were repeated to create two new views in the database: v_bgroup2020_to_nbhood2020, v_bgroup2020_to_ward2022. The SQL queries were modified versions of the existing queries for tracts. The primary distinction is that identifiers were created to uniquely identify block groups within a tract.
