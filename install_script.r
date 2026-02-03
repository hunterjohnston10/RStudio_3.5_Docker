args <- commandArgs(trailingOnly = TRUE)

print(args)

if (length(args) != 2) {
    stop("Error: Incorrect amount of arguments supplied. There should only be 2.")
}

cran_installs <- unlist(strsplit(args[1], ","))
github_installs <- unlist(strsplit(args[2], ","))

## install pak for better downloading
install.packages("pak", repos = sprintf("https://r-lib.github.io/p/pak/stable/%s/%s/%s", .Platform$pkgType, R.Version()$os, R.Version()$arch))
require(pak)

require(devtools)
if (length(cran_installs) > 0) {
    pak::pkg_install(cran_installs)
}

if (length(github_installs) > 0) {
    pak::pkg_install(github_installs)
}
