
if (!dir.exists("tag")) {
  dir.create("tag")
}

base_json <- jsonlite::fromJSON("base.json")
base_json$label <- "Ask a question"

tags <- c(
  "actionbutton", "activedirectory", "addins", "anaconda", "anova",
  "apis", "async", "authentication", "aws", "base-r", "best-practices",
  "big-data", "bioconductor", "blogdown", "bof", "bookdown", "bookdown-contest",
  "bookmark", "broom", "bug", "c", "cairo", "car", "caret", "case_when",
  "chromebook", "cli", "cloud", "cloudml", "code-chunks", "collaboration",
  "colors", "community", "conference", "config", "connection",
  "cran", "crash-report", "cronr", "crosstalk", "css", "curl",
  "daily", "database", "databases", "datascience", "datasets",
  "datatable", "date-time", "dbi", "dbplyr", "dependencies", "devtools",
  "docker", "documentation", "dplyr", "dt", "dygraphs", "ega",
  "encoding", "enhancement", "excel", "extensions", "factors",
  "faq", "faq-discussion", "fatal-error", "feature-request", "filter",
  "flexdashboard", "flextable", "fonts", "forcats", "forecast",
  "forecasting", "forloops", "formattable", "functions", "future",
  "geomorph", "gganimate", "ggmap", "ggplot2", "ggpubr", "git",
  "github", "glue", "gmailr", "google", "googlesheets", "graphics",
  "group_by", "gt", "h2o", "help-pane", "here", "hidpi-monitor",
  "highcharter", "highcharts", "highlight", "homework", "html",
  "htmlwidget", "htmlwidgets", "httr", "hugo", "ide", "ide-bug",
  "ide-debugger", "ide-error", "ide-issue", "igraph", "install",
  "install_github", "job-post", "jobs", "json", "jsonlite", "jupyter-notebook",
  "kableextra", "keras", "keybindings", "knit", "knitr", "latex",
  "lattice", "leaflet", "learnr", "linux", "linuxvswindows", "listcolumn",
  "lm", "logging", "lubridate", "mac", "machinelearning", "macos",
  "magrittr", "mailr", "maps", "matrix", "memory", "merge", "meta",
  "modaldialog", "mutate", "mysql", "network", "networkd3", "nlme",
  "nse", "odbc", "officer", "package", "package-dependencies",
  "package-installation", "package-manager", "packagemanagement",
  "packages", "packageupdate", "packrat", "pandoc", "parallel",
  "pdf", "pdflatex", "performance", "permissions", "pipe", "pkgdown",
  "plot", "plotly", "plumber", "plyr", "pool", "postgres", "postgresql",
  "powerpoint", "presentation", "probability", "production", "projects",
  "promises", "purrr", "python", "quickstart", "r", "r-installation",
  "r-user-group", "r2d3", "r4ds", "randomforest", "raster", "rcpp",
  "read_csv", "readr", "readxl", "recipes", "recode", "recommendations",
  "redshift", "regex", "reprex", "reproducible", "reticulate",
  "rgdal", "rhandsontable", "rjava", "rjdbc", "rlang", "rmarkdown",
  "rmd", "rmgarch", "rnotebook", "rodbc", "roxygen2", "rpres",
  "rproj", "rpubs", "rsample", "rsconnect", "rselenium", "rstan",
  "rstudio", "rstudio-connect", "rstudio-preview", "rstudio-server",
  "rstudio-server-pro", "rstudioapi", "rstudiocloud", "rtools",
  "rvest", "rweka", "s3", "scraping", "screencast", "security",
  "self-answered", "sentiment-analysis", "server", "sf", "shiny",
  "shiny-contest", "shiny-deploy", "shiny-error", "shiny-modules",
  "shiny-server", "shinyappsio", "shinydashboard", "shinyjs", "shinymaterial",
  "snippets", "sp", "spark", "sparklyr", "spatial", "sql", "ssh",
  "ssl", "start-up", "statistics", "stringi", "stringr", "surveys",
  "svg", "tabulizer", "tbl", "teaching", "template", "tensorflow",
  "terminal", "testthat", "text", "textmining", "themes", "tibble",
  "tidyeval", "tidymodels", "tidyr", "tidyverse", "time-series",
  "tinytex", "travis-ci", "ubuntu", "unit-testing", "usethis",
  "viewer", "vignette", "visualization", "web-scraping", "webinar",
  "windows", "word", "wordcloud", "workflow", "workshop", "xaringan",
  "xgboost", "xlsx", "xml2", "yaml"
)

# categories <- tibble::tribble(
#   ~ id, ~ url_category, ~ name,
#   1, "uncategorized", "Uncategorized",
#   2, "lounge", "Lounge",
#   3, "meta", "meta",
#   4, "staff", "Staff",
#   5, "r-admin", "R Admins",
#   6, "tidyverse", "tidyverse",
#   7, "rstudio-conf", "rstudio::conf",
#   8, "shiny", "Shiny",
#   9, "rstudio-ide", "RStudio IDE",
#   10, "R-Markdown", "R Markdown",
#   11, "package-development", "Package development",
#   # 12, "", "RStudioClientTestGroup",
#   13, "teaching", "Teaching",
#   14, "rstudio-cloud", "RStudio Cloud",
#   15, "ml", "Machine Learning and Modeling",
#   16, "publications", "Publications",
#   17, "general", "General",
#   18, "irl", "Events",
#   # 19, "", "Test Job Board",
#   # 21, "", "Package Management",
#   # 22, "", "Guides & FAQs",
#   20, "jobs", "Jobs and Gigs"
# )

dt <- tibble::tibble(
  tag = tags
)
mapply(
  dt$tag,
  SIMPLIFY = TRUE,
  FUN = function(tag) {

    item_json <- base_json
    item_json$message <- tag

    # save file
    jsonlite::write_json(
      item_json,
      paste0("tag/", tag, ".json"),
      pretty = TRUE,
      auto_unbox = TRUE
    )

    NULL
  }
)
dt$shield_md <- mapply(
  dt$tag,
  SIMPLIFY = TRUE,
  FUN = function(tag) {
    paste0(
      "![RStudio Ask a question: ", tag, "](https://img.shields.io/endpoint?url=https://rstudio.github.io/rstudio-shields/tag/", httpuv::encodeURIComponent(tag), ".json)"
    )
  }
)



# https://community.rstudio.com/c/teaching




cat(
  file = "tag/Readme.md",
  paste0(
    "# Tag Shields\n\n",
    "-------------------\n\n",
    paste0(
      "* ", dt$shield_md, "\n  - `", dt$shield_md, "`",
      collapse = "\n"
    )
  )
)
