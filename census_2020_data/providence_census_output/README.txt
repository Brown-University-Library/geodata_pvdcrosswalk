2020 Census Data for Providence Neighborhoods and Wards
GeoData@SciLi, Brown University Library
Brian Kao, GIS & Data Assistant
Frank Donnelly, Head of GIS & Data Services
February 4, 2026

----------------------------------------------------------

The data in these files are population and housing estimates for neighborhoods and wards (2022 vintage) from the 2020 Census Demographic Profile for Providence, Rhode Island. There are six CSV files that are published in three sets:

- Population counts and percent totals for neighborhoods
- Population counts and percent totals for wards
- Codebooks that relate variable identifiers to names for the count and percentage files

The data was created using the Providence Census Geography Crosswalk, which is a relational table for taking data for census geographies and apportioning and aggregating it to create estimates for local neighborhoods and wards. A Python notebook was written to take data at the census tract level from the Ocean State Spatial Database (OSSDB) and convert it to neighborhoods and wards using the crosswalk. Population and household variables were apportioned using total population as a weight, while housing units variables were apportioned using total housing units as a weight. See the crosswalk documentation for a more details:

https://github.com/Brown-University-Library/geodata_pvdcrosswalk

The percent totals were calculated using the same numerators and denominators that were employed by the Census Bureau in the original profile table. The simplest way to interpret these figures is to examine the nesting structure in the original table:

https://data.census.gov/table?g=060XX00US4400759000&y=2020&d=DEC+Demographic+Profile

The sum of all neighborhood and ward values may not precisely match the official total counts for the city, due to rounding of values in the apportionment process. Certain variables, such as median age by sex, were excluded from the results. These are derived values that could not be apportioned, nor could they be regenerated from the underlying summary data.

The crosswalk and this dataset that was generated from it are published under a Creative Commons Attribution Noncommercial Sharealike license CC BY-NC-SA 4.0. Every effort was made to ensure that the data, which was compiled from public sources, was processed and presented accurately. The creators and Brown University disclaim any liability for errors, inaccuracies, or omissions that may be contained therein or for any damages that may arise from the foregoing. Users should independently verify the accuracy and fitness of the data for their purposes.




