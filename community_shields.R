
if (!dir.exists("category")) {
  dir.create("category")
}

base_json <- jsonlite::fromJSON("base.json")
base_json$label <- "Community Support"

dt <- tibble::tribble(
  ~ id, ~ url_category, ~ name,
  1, "uncategorized", "Uncategorized",
  2, "lounge", "Lounge",
  3, "meta", "meta",
  4, "staff", "Staff",
  5, "r-admin", "R Admins",
  6, "tidyverse", "tidyverse",
  7, "rstudio-conf", "rstudio::conf",
  8, "shiny", "Shiny",
  9, "rstudio-ide", "RStudio IDE",
  10, "R-Markdown", "R Markdown",
  11, "package-development", "Package development",
  # 12, "", "RStudioClientTestGroup",
  13, "teaching", "Teaching",
  14, "rstudio-cloud", "RStudio Cloud",
  15, "ml", "Machine Learning and Modeling",
  16, "publications", "Publications",
  17, "general", "General",
  18, "irl", "Events",
  # 19, "", "Test Job Board",
  # 21, "", "Package Management",
  # 22, "", "Guides & FAQs",
  20, "jobs", "Jobs and Gigs"
)
dt$url_community <- mapply(
  dt$id,
  dt$url_category,
  dt$name,
  SIMPLIFY = TRUE,
  FUN = function(id, url_category, name) {

    url_community <- paste0("https://community.rstudio.com/c/", url_category)
    item_json <- base_json
    item_json$message <- name
    item_json$link <- c(url_community, url_community)
    item_json$link <- NULL

    # save file
    jsonlite::write_json(
      item_json,
      paste0("category/", url_category, ".json"),
      pretty = TRUE,
      auto_unbox = TRUE
    )

    url_community
  }
)
dt$url_github <- mapply(
  dt$url_category,
  SIMPLIFY = TRUE,
  FUN = function(url_category) {
    paste0("https://rstudio.github.io/rstudio-shields/category/", url_category, ".json")
  }
)
dt$shield_md <- mapply(
  dt$url_github,
  dt$name,
  dt$url_community,
  SIMPLIFY = TRUE,
  FUN = function(url_github, name, url_community) {
    paste0(
      "[![RStudio Community: ", name, "](https://img.shields.io/endpoint?url=", httpuv::encodeURIComponent(url_github), ")](", url_community,")"
    )
  }
)



# https://community.rstudio.com/c/teaching




cat(
  file = "category/Readme.md",
  paste0(
    "# Category Shields\n\n",
    "-------------------\n\n",
    paste0(
      "* ", dt$shield_md, "\n  - `", dt$shield_md, "`",
      collapse = "\n"
    )
  )
)
