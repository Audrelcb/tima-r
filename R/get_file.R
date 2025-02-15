#' @title Get file
#'
#' @description This function get files
#'
#' @param url URL of the file to be downloaded
#' @param export File path where the file should be saved
#' @param limit Timeout limit (in seconds)
#'
#' @return NULL
#'
#' @export
#'
#' @examples
#' git <- "https://github.com/"
#' org <- "taxonomicallyinformedannotation"
#' repo <- "tima-example-files"
#' branch <- "main"
#' file <- "example_metadata.tsv"
#' get_file(
#'   url = paste(git, org, repo, "raw", branch, file, sep = "/"),
#'   export = "data/source/example_metadata.tsv"
#' )
get_file <-
  function(url,
           export,
           limit = 3600) {
    if (!file.exists(export)) {
      options(timeout = limit)
      create_dir(export = export)
      utils::download.file(
        url = url,
        destfile = export
      )
    } else {
      message("File already exists. Skipping.")
    }
    return(export)
  }
