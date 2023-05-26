# can roundtrip ptype through JSON

    Code
      json
    Output
      {
        "a": {
          "type": "double",
          "details": []
        },
        "b": {
          "type": "integer",
          "details": []
        },
        "c": {
          "type": "Date",
          "details": []
        },
        "d": {
          "type": "POSIXct",
          "details": {
            "tzone": "America/New_York"
          }
        },
        "e": {
          "type": "character",
          "details": []
        },
        "f": {
          "type": "factor",
          "details": {
            "levels": ["blue", "green", "red"]
          }
        },
        "g": {
          "type": "ordered",
          "details": {
            "levels": ["small", "medium", "large"]
          }
        }
      } 

