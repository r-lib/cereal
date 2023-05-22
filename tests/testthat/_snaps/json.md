# can roundtrip ptype through JSON

    Code
      json
    Output
      {
        "a": {
          "class": "double",
          "details": []
        },
        "b": {
          "class": "integer",
          "details": []
        },
        "c": {
          "class": "Date",
          "details": []
        },
        "d": {
          "class": "POSIXct",
          "details": {
            "tzone": "America/New_York"
          }
        },
        "e": {
          "class": "character",
          "details": []
        },
        "f": {
          "class": "factor",
          "details": {
            "levels": ["blue", "green", "red"]
          }
        },
        "g": {
          "class": "ordered",
          "details": {
            "levels": ["small", "medium", "large"]
          }
        }
      } 

