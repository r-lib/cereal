# can roundtrip ptype through JSON

    Code
      json
    Output
      {
        "a": {
          "type": "numeric",
          "default": "1",
          "details": []
        },
        "b": {
          "type": "integer",
          "default": "2",
          "details": []
        },
        "c": {
          "type": "Date",
          "default": "2023-01-01",
          "details": []
        },
        "d": {
          "type": "POSIXct",
          "default": "2019-01-01",
          "details": {
            "tzone": "America/New_York"
          }
        },
        "e": {
          "type": "character",
          "default": "x",
          "details": []
        },
        "f": {
          "type": "factor",
          "default": "blue",
          "details": {
            "levels": ["blue", "green", "red"]
          }
        },
        "g": {
          "type": "ordered",
          "default": "small",
          "details": {
            "levels": ["small", "medium", "large"]
          }
        }
      } 

