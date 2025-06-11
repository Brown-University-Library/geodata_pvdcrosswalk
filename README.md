# Providence Census Geography Crosswalk

## Introduction

The Providence Census Geography Crosswalk is a set of spreadsheet tables and a series of maps that relate census geographies with local geographies in Providence, Rhode Island. Census tracts, block groups, and ZIP Code Tabulation Areas (ZCTAs) for 2020 were related to Providence neighborhood boundaries and wards; the City's official neighborhood boundaries were regenerated using 2020 census blocks for this analysis. There is one crosswalk table for each pair, and each record represents an instance where a census geography and local geography overlap. The tables can be used for apportioning and aggregating census data from tracts, block groups, and ZCTAs to neighborhoods and wards. The ZCTA information is included primarily for illustrative purposes; given the poor relationship between ZCTAs and other geographies its use is not recommended. A list of census blocks that constitute all of the geographies is also included, and can be used for aggregating block-level census data.

Columns in the crosswalk include values and percent totals for population, housing units, land area, and total area for the portion of the census geography that falls within the local geography. Population and housing counts are from the 2020 census, while area is from the 2023 Census TIGER Line files and is represented in square miles.

The original release of December 2024 was updated in March 2025 to include census block groups in the crosswalk.

Project Leads: 

- Frank Donnelly, Head of GIS & Data Services, Brown University Library

- Dan Turner, Asst Director of Community-Engaged Data and Evaluation Collaborative (CEDEC), Brown University

Map creation:

- Eric Xia '26, GIS & Data Assistant, Brown University Library

## Rights and Use

This product was produced as part of Brown University's [Community-Engaged Data and Evaluation Collaborative](https://swearer.brown.edu/faculty-staff/data-and-evaluation-partnerships) (CEDEC), an initiative of the Swearer Center for Public Service that brings partners from the University and Rhode Island communities together to advance data-oriented projects. The Crosswalk was created by the [GeoData@SciLi](https://libguides.brown.edu/geodata) team, which is part of the Center for Library Exploration and Research (CLEAR) at the Brown University Library. The crosswalk and maps are published under a Creative Commons Attribution Noncommercial Sharealike license CC BY-NC-SA 4.0 ![](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/blob/main/images/cc_license.png).

*Disclaimer: Every effort was made to ensure that the data, which was compiled from public sources, was processed and presented accurately. The creators and Brown University disclaim any liability for errors, inaccuracies, or omissions that may be contained therein or for any damages that may arise from the foregoing. Users should independently verify the accuracy and fitness of the data for their purposes.*

## Download

### Crosswalk

- [Providence Census Geography Crosswalk and Documentation (ZIP)](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/crosswalk.zip)

- [Providence Census Geography Crosswalk (XLSX)](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/crosswalk/pvd_census_geog_crosswalk.xlsx)

- [Crosswalk Documentation (PDF)](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/crosswalk/pvd_census_geog_crosswalk.pdf)

- [Source Materials (folder)](source_data)

### Video Tutorial

- [Providence Census Geography Crosswalk (Vimeo)]([Providence Census Geography Crosswalk Tutorial](https://vimeo.com/1091899543))

### Maps (PDF)

- [All Maps (ZIP)](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps.zip)

- [2020 Census Tracts to 2020 Neighborhoods](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps/pvd_tracts2020_nbhoods2020.pdf)

- [2020 Census Tracts to 2022 Wards](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps/pvd_tracts2020_wards2022.pdf)

- [2020 Census Block Groups to 2020 Neighborhoods](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps/pvd_bgroups2020_nbhoods2020.pdf)

- [2020 Census Block Groups to 2022 Wards](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps/pvd_bgroups2020_wards2022.pdf)

- [2020 ZCTAs to 2020 Neighborhoods](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps/pvd_zctas2020_nbhoods2020.pdf)

- [2020 ZCTAs to 2022 Wards](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps/pvd_zctas2020_wards2022.pdf)

- [2020 Neighborhoods vs Official Neighborhoods](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/raw/main/maps/pvd_nbhoods_nbhoods2020.pdf)

![](https://github.com/Brown-University-Library/geodata_pvdcrosswalk/blob/main/images/tract_table_example.png)

*EXAMPLE: Census tract 1.01 is listed once in the tract2020\_to\_nbhood2020 crosswalk, which means it is fully contained within Washington Park. It's pct\_pop value is 1, which means 100% of the population of tract 1.01 falls within Washington Park. Census tract 1.02 is listed twice, as it is split between South Elmwood and Washington Park. The total population of this tract is 5,527; 31.5% (1,741 people) live in South Elmwood, while 68.5% (3,786 people) live in Washington Park.*
