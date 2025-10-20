# can roundtrip ptype through JSON

    Code
      cereal_to_json(df$a)
    Condition
      Error in `cereal_to_json()`:
      ! `data` must be a data frame, not the number 1.

---

    Code
      json
    Output
      {
        "a": {
          "type": "numeric",
          "example": "1",
          "details": []
        },
        "b": {
          "type": "integer",
          "example": "2",
          "details": []
        },
        "c": {
          "type": "Date",
          "example": "2023-01-01",
          "details": []
        },
        "d": {
          "type": "POSIXct",
          "example": "2019-01-01",
          "details": {
            "tzone": "America/New_York"
          }
        },
        "e": {
          "type": "character",
          "example": "x",
          "details": []
        },
        "f": {
          "type": "factor",
          "example": "blue",
          "details": {
            "levels": ["blue", "green", "red"]
          }
        },
        "g": {
          "type": "ordered",
          "example": "small",
          "details": {
            "levels": ["small", "medium", "large"]
          }
        }
      } 

