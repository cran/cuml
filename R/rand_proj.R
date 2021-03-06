#' Random projection for dimensionality reduction.
#'
#' Generate a random projection matrix for dimensionality reduction, and
#' optionally transform input data to a projection in a lower dimension space
#' using the generated random matrix.
#'
#' @template model-with-numeric-input
#' @param n_components Dimensionality of the target projection space. If NULL,
#'   then the parameter is deducted using the Johnson-Lindenstrauss lemma,
#'   taking into consideration the number of samples and the \code{eps}
#'   parameter. Default: NULL.
#' @param eps Error tolerance during projection. Default: 0.1.
#' @param gaussian_method If TRUE, then use the Gaussian random projection
#'   method. Otherwise, use the sparse random projection method.
#'   See https://en.wikipedia.org/wiki/Random_projection for details.
#'   Default: TRUE.
#' @param density Ratio of non-zero component in the random projection matrix.
#'   If NULL, then the value is set to the minimum density as recommended by
#'   Ping Li et al.: 1 / sqrt(n_features). Default: NULL.
#' @param transform_input Whether to project input data onto a lower dimension
#'   space using the random matrix. Default: TRUE.
#' @param seed Seed for the pseudorandom number generator. Default: 0L.
#'
#' @return A context object containing GPU pointer to a random matrix that can
#'   be used as input to the \code{cuml_transform()} function.
#'   If \code{transform_input} is set to TRUE, then the context object will also
#'   contain a "transformed_data" attribute containing the lower dimensional
#'   projection of the input data.
#'
#' @examples
#' library(cuml)
#' library(mlbench)
#'
#' data(Vehicle)
#' vehicle_data <- Vehicle[order(Vehicle$Class), which(names(Vehicle) != "Class")]
#'
#' ctx <- cuml_rand_proj(vehicle_data, n_components = 4)
#'
#' set.seed(0L)
#' print(kmeans(ctx$transformed_data, centers = 4, iter.max = 1000))
#' @export
cuml_rand_proj <- function(x, n_components = NULL, eps = 0.1,
                           gaussian_method = TRUE, density = NULL,
                           transform_input = TRUE, seed = 0L) {
  n_components <- n_components %||%
    .rproj_johnson_lindenstrauss_min_dim(
      n_samples = nrow(x), eps = as.numeric(eps)
    )
  density <- density %||% 1.0 / sqrt(ncol(x))

  rproj_ctx <- .rproj_fit(
    n_samples = nrow(x),
    n_features = ncol(x),
    n_components = as.integer(n_components),
    eps = as.numeric(eps),
    gaussian_method = gaussian_method,
    density = as.numeric(density),
    random_state = as.integer(seed)
  )

  ctx <- list(rproj_ctx = rproj_ctx)
  class(ctx) <- c("cuml_rand_proj_ctx", class(ctx))

  if (transform_input) {
    ctx$transformed_data <- cuml_transform(ctx, x)
  }

  ctx
}

#' @export
cuml_transform.cuml_rand_proj_ctx <- function(model, x, ...) {
  .rproj_transform(model$rproj_ctx, as.matrix(x))
}
