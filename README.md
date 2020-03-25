# INDONESIA POSTAL CODE

This is collections of Indonesia area & postal codes.

This repository contains **THOUSANDS** & Binary Data!

**Before clone, make sure you know what you'll do.**


## COLLECTIONS

 - Postal Code   : `14955`
 - Villages      : `83342`
 - Sub-Districts : `7228`
 - Cities        : `514`
 - Provinces     : `34`
 - Countries     : `1` (Indonesia Only)

## STRUCTURES

> Data Directory

```text
data/
    ├─── csv/
    |   └─── 62/                                        (Country csv directory)
    |       ├─── countries.csv                          (Countries csv data)
    |       ├─── provinces.csv                          (Provinces csv data)
    |       ├─── cities.csv                             (Cities csv data)
    |       ├─── subDistricts.csv                       (Sub-Districts csv data)
    |       ├─── villages.csv                           (Villages csv data)
    |       ├─── postalCodes.csv                        (Postal Codes csv data)
    |       └─── translations.csv                       (Translations csv data)
    ├─── database/
    |   ├─── records.sqlite.db                          (SQLite Binary Database - geometry records has been set to null)
    |   ├─── ddl.sql                                    (DDL)
    |   ├─── ddl.uml
    |   └─── ddl.uml.png
    ├─── json/
    |   ├─── area/
    |   |   └─── 62/                                    (country root directory)
    |   |       ├─── 62.json                            (country json info)
    |   |       └─── [0-9]{2}/                          (provinces root directory)
    |   |           ├─── [0-9]{2}.json                  (province json info)
    |   |           └─── [0-9]{4}/                      (cities root directory)
    |   |               ├─── [0-9]{4}.json              (city json info)
    |   |               └─── [0-9]{7}/                  (sub-districts root directory)
    |   |                   └─── [0-9]{7}.json          (sub-district json info)
    |   |                       └─── [0-9]{11}/         (villages root directory - contain single file)
    |   |                           └─── [0-9]{11}.json (village json info)
    |   ├─── postal/                                    (country postal codes root directory)
    |   |   └─── 62.json                                (list of country postal codes)
    |   └─── translations/
    |       └─── 62/                                    (country translations root directory)
    |           └─── en.json                            (list of available areas translations)    
    └─── geojson/
       └─── 62/                                         (country geojson root directory)
           ├─── 62.json                                 (country geojson)
           └─── [0-9]{2}/                               (provinces geojson root directory)
               ├─── [0-9]{2}.json                       (province geojson)
               └─── [0-9]{4}/                           (cities geojson root directory)
                   ├─── [0-9]{4}.json                   (city geojson)
                   └─── [0-9]{7}/                       (sub-districts geojson root directory)
                       └─── [0-9]{7}.json               (sub-district geojson)


```

> Json Areas

```json
{
  "code": "integer",
  "name": "string",
  "parent": "integer",
  "latitude": "float|null",
  "longitude": "float|null",
  "postal": ["array<integer>"],
  "children": ["array<integer>"]
}
```

> GEO-JSON

Geo-JSON only available from Country to Sub-Districts, villages are not available. 

Read More About **[GeoJSON](https://geojson.org/)**



```json
{
  "type": "FeatureCollections",
  "features": ["array<object>"]
}
```

Example :

```json
{
  "type": "FeatureCollections",
  "features": [
    {
      "type": "Feature",
      "code": "integer",
      "properties" : {
        "Kind"  : "string",
        "Code"  : "integer",
        "Name"  : "string",
        "Year"  : "integer|string",
        "Source": "BPS",
        "Parent": "integer"
      },
      "geometry": {
        "type": "MultiPolygon",
        "coordinates" : [
          [
            [
                [
                  91.0000001,
                  1.00000001
                ],
                [
                  92.0000002,
                  2.00000002
                ]
            ]
          ]
        ]
      }
    }
  ]
}
```

## DATA SOURCE

[Badan Pusat Statistik Indonesia (BPS)](https://bps.go.id/)


## NOTE

- [Badan Pusat Statistik Indonesia (BPS)](https://bps.go.id/) contains detailed polygons, it will make this repository contains huge data.
- Some of GeoJson not available 
- Database Files on all columns with `xxxx_geometry` has been set to null.
 Please insert manually from [data/geojson](data/geojson), Trees file name as code

## LICENSE

[MIT LICENSE](LICENSE)
