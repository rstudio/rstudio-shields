# Update the base.json file with the latest base_logo.svg

base_json <- jsonlite::fromJSON("base.json")

base_json$logoSvg <- paste0(
  readLines("base_logo.svg"),
  collapse = "\n"
)

jsonlite::write_json(
  base_json,
  "base.json",
  pretty = TRUE,
  auto_unbox = TRUE
)
