#' @title Prepare features components
#'
#' @description This function prepares the components
#'    (clusters in molecular network) for further use
#'
#' @param input Input file
#' @param output Output file
#'
#' @return NULL
#'
#' @export
#'
#' @examples NULL
prepare_features_components <-
  function(input = get_params(step = "prepare_features_components")$files$networks$spectral$components$raw,
           output = get_params(step = "prepare_features_components")$files$networks$spectral$components$prepared) {
    stopifnot(
      "Input file(s) do(es) not exist" = rep(TRUE, length(input)) == lapply(X = input, FUN = file.exists)
    )

    log_debug(x = "Loading files ...")
    log_debug(x = "... components table")
    table <- lapply(
      X = input,
      FUN = tidytable::fread,
      na.strings = c("", "NA"),
      colClasses = "character"
    ) |>
      tidytable::bind_rows() |>
      tidytable::select(
        feature_id = `cluster index`,
        component_id = componentindex
      ) |>
      tidytable::distinct()

    log_debug(x = "Exporting ...")
    export_params(parameters = get_params(step = "prepare_features_components"), step = "prepare_features_components")
    export_output(x = table, file = output)
    rm(table)

    return(output)
  }
