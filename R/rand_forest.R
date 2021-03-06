#' Train a random forest model.
#'
#' Train a random forest model for classification or regression tasks.
#'
#' @template supervised-model-inputs
#' @template supervised-model-output
#' @template ellipsis-unused
#' @template cuml-log-level
#' @param mtry The number of predictors that will be randomly sampled at each
#'   split when creating the tree models. Default: the square root of the total
#'   number of predictors.
#' @param trees An integer for the number of trees contained in the ensemble.
#'   Default: 100L.
#' @param min_n An integer for the minimum number of data points in a node that
#'   are required for the node to be split further. Default: 2L.
#' @param bootstrap Whether to perform bootstrap.
#'   If TRUE, each tree in the forest is built on a bootstrapped sample with
#'   replacement.
#'   If FALSE, the whole dataset is used to build each tree.
#' @param max_depth Maximum tree depth. Default: 16L.
#' @param max_leaves Maximum leaf nodes per tree. Soft constraint. Default: Inf
#'   (unlimited).
#' @param max_predictors_per_note_split Number of predictor to consider per node
#'   split. Default: square root of the total number predictors.
#' @param n_bins Number of bins used by the split algorithm. Default: 128L.
#' @param min_samples_leaf The minimum number of data points in each leaf node.
#'   Default: 1L.
#' @param split_criterion The criterion used to split nodes, can be "gini" or
#'   "entropy" for classifications, and "mse" or "mae" for regressions.
#'   Default: "gini" for classification; "mse" for regression.
#' @param min_impurity_decrease Minimum decrease in impurity requried for node
#'   to be spilt. Default: 0.
#' @param max_batch_size Maximum number of nodes that can be processed in a
#'   given batch. Default: 128L.
#' @param n_streams Number of CUDA streams to use for building trees.
#'   Default: 8L.
#'
#' @return A random forest classifier / regressor object that can be used with
#'   the 'predict' S3 generic to make predictions on new data points.
#'
#' @examples
#' library(cuml)
#'
#' # Classification
#'
#' model <- cuml_rand_forest(
#'   formula = Species ~ .,
#'   data = iris,
#'   trees = 100
#' )
#'
#' predictions <- predict(model, iris[-which(names(iris) == "Species")])
#'
#' # Regression
#'
#' model <- cuml_rand_forest(
#'   formula = mpg ~ .,
#'   data = mtcars,
#'   trees = 100
#' )
#'
#' predictions <- predict(model, mtcars[-which(names(mtcars) == "mpg")])
#' @export
cuml_rand_forest <- function(x, ...) {
  UseMethod("cuml_rand_forest")
}

#' @rdname cuml_rand_forest
#' @export
cuml_rand_forest.default <- function(x, ...) {
  report_undefined_fn("cuml_rand_forest", x)
}

#' @rdname cuml_rand_forest
#' @export
cuml_rand_forest.data.frame <- function(x, y, mtry = NULL, trees = NULL,
                                        min_n = 2L, bootstrap = TRUE,
                                        max_depth = 16L, max_leaves = Inf,
                                        max_predictors_per_note_split = NULL,
                                        n_bins = 128L, min_samples_leaf = 1L,
                                        split_criterion = NULL,
                                        min_impurity_decrease = 0,
                                        max_batch_size = 128L, n_streams = 8L,
                                        cuml_log_level = c("off", "critical", "error", "warn", "info", "debug", "trace"),
                                        ...) {
  processed <- hardhat::mold(x, y)

  cuml_rand_forest_bridge(
    processed = processed,
    mtry = mtry,
    trees = trees,
    min_n = min_n,
    bootstrap = bootstrap,
    max_depth = max_depth,
    max_leaves = max_leaves,
    max_predictors_per_note_split = max_predictors_per_note_split,
    n_bins = n_bins,
    min_samples_leaf = min_samples_leaf,
    split_criterion = split_criterion,
    min_impurity_decrease = min_impurity_decrease,
    max_batch_size = max_batch_size,
    n_streams = n_streams,
    cuml_log_level = cuml_log_level
  )
}

#' @rdname cuml_rand_forest
#' @export
cuml_rand_forest.matrix <- function(x, y, mtry = NULL, trees = NULL, min_n = 2L,
                                    bootstrap = TRUE, max_depth = 16L,
                                    max_leaves = Inf,
                                    max_predictors_per_note_split = NULL,
                                    n_bins = 128L, min_samples_leaf = 1L,
                                    split_criterion = NULL,
                                    min_impurity_decrease = 0,
                                    max_batch_size = 128L, n_streams = 8L,
                                    cuml_log_level = c("off", "critical", "error", "warn", "info", "debug", "trace"),
                                    ...) {
  processed <- hardhat::mold(x, y)

  cuml_rand_forest_bridge(
    processed = processed,
    mtry = mtry,
    trees = trees,
    min_n = min_n,
    bootstrap = bootstrap,
    max_depth = max_depth,
    max_leaves = max_leaves,
    max_predictors_per_note_split = max_predictors_per_note_split,
    n_bins = n_bins,
    min_samples_leaf = min_samples_leaf,
    split_criterion = split_criterion,
    min_impurity_decrease = min_impurity_decrease,
    max_batch_size = max_batch_size,
    n_streams = n_streams,
    cuml_log_level = cuml_log_level
  )
}

#' @rdname cuml_rand_forest
#' @export
cuml_rand_forest.formula <- function(formula, data, mtry = NULL, trees = NULL,
                                     min_n = 2L, bootstrap = TRUE,
                                     max_depth = 16L, max_leaves = Inf,
                                     max_predictors_per_note_split = NULL,
                                     n_bins = 128L, min_samples_leaf = 1L,
                                     split_criterion = NULL,
                                     min_impurity_decrease = 0,
                                     max_batch_size = 128L, n_streams = 8L,
                                     cuml_log_level = c("off", "critical", "error", "warn", "info", "debug", "trace"),
                                     ...) {
  processed <- hardhat::mold(formula, data)

  cuml_rand_forest_bridge(
    processed = processed,
    mtry = mtry,
    trees = trees,
    min_n = min_n,
    bootstrap = bootstrap,
    max_depth = max_depth,
    max_leaves = max_leaves,
    max_predictors_per_note_split = max_predictors_per_note_split,
    n_bins = n_bins,
    min_samples_leaf = min_samples_leaf,
    split_criterion = split_criterion,
    min_impurity_decrease = min_impurity_decrease,
    max_batch_size = max_batch_size,
    n_streams = n_streams,
    cuml_log_level = cuml_log_level
  )
}

#' @rdname cuml_rand_forest
#' @export
cuml_rand_forest.recipe <- function(x, data, mtry = NULL, trees = NULL,
                                    min_n = 2L, bootstrap = TRUE,
                                    max_depth = 16L, max_leaves = Inf,
                                    max_predictors_per_note_split = NULL,
                                    n_bins = 128L, min_samples_leaf = 1L,
                                    split_criterion = NULL,
                                    min_impurity_decrease = 0,
                                    max_batch_size = 128L, n_streams = 8L,
                                    cuml_log_level = c("off", "critical", "error", "warn", "info", "debug", "trace"),
                                    ...) {
  processed <- hardhat::mold(x, data)

  cuml_rand_forest_bridge(
    processed = processed,
    mtry = mtry,
    trees = trees,
    min_n = min_n,
    bootstrap = bootstrap,
    max_depth = max_depth,
    max_leaves = max_leaves,
    max_predictors_per_note_split = max_predictors_per_note_split,
    n_bins = n_bins,
    min_samples_leaf = min_samples_leaf,
    split_criterion = split_criterion,
    min_impurity_decrease = min_impurity_decrease,
    max_batch_size = max_batch_size,
    n_streams = n_streams,
    cuml_log_level = cuml_log_level
  )
}

cuml_rand_forest_bridge <- function(processed, mtry, trees, min_n, bootstrap,
                                    max_depth, max_leaves,
                                    max_predictors_per_note_split, n_bins,
                                    min_samples_leaf, split_criterion,
                                    min_impurity_decrease, max_batch_size,
                                    n_streams, cuml_log_level) {
  hardhat::validate_outcomes_are_univariate(processed$outcomes)
  x <- as.matrix(processed$predictors)
  y <- processed$outcomes[[1]]
  classification <- is.factor(y)
  if (identical(max_leaves, Inf)) {
    max_leaves <- -1L
  }

  # Default value for 'split_criterion' depends on whether a classification or a
  # regression task is being performed.
  split_criterion <- decision_tree_match_split_criterion(
    split_criterion,
    classification
  )
  cuml_log_level <- match_cuml_log_level(cuml_log_level)

  rand_forest_fit_impl <- ifelse(
    classification,
    cuml_rand_forest_impl_classification,
    cuml_rand_forest_impl_regression
  )

  rand_forest_fit_impl(
    processed = processed,
    mtry = mtry,
    trees = trees,
    min_n = min_n,
    bootstrap = bootstrap,
    max_depth = max_depth,
    max_leaves = max_leaves,
    max_predictors_per_note_split = max_predictors_per_note_split,
    n_bins = n_bins,
    min_samples_leaf = min_samples_leaf,
    split_criterion = split_criterion,
    min_impurity_decrease = min_impurity_decrease,
    max_batch_size = max_batch_size,
    n_streams = n_streams,
    cuml_log_level = cuml_log_level
  )
}

cuml_rand_forest_impl_classification <- function(processed, mtry, trees, min_n,
                                                 bootstrap, max_depth,
                                                 max_leaves,
                                                 max_predictors_per_note_split,
                                                 n_bins, min_samples_leaf,
                                                 split_criterion,
                                                 min_impurity_decrease,
                                                 max_batch_size, n_streams,
                                                 cuml_log_level) {
  x <- as.matrix(processed$predictors)
  y <- processed$outcomes[[1]]

  model_xptr <- .rf_classifier_fit(
    input = as.matrix(x),
    labels = as.integer(y),
    n_trees = as.integer(trees),
    bootstrap = as.logical(bootstrap),
    max_samples = as.numeric(mtry %||% sqrt(ncol(x))) / ncol(x),
    n_streams = as.integer(n_streams),
    max_depth = as.integer(max_depth),
    max_leaves = as.integer(max_leaves),
    max_features = as.numeric(max_predictors_per_note_split %||% sqrt(ncol(x))) / ncol(x),
    n_bins = as.integer(n_bins),
    min_samples_leaf = as.integer(min_samples_leaf),
    min_samples_split = as.integer(min_n %||% 2L),
    split_criterion = split_criterion,
    min_impurity_decrease = as.numeric(min_impurity_decrease),
    max_batch_size = as.integer(max_batch_size),
    verbosity = cuml_log_level
  )

  new_model(
    cls = "cuml_rand_forest",
    mode = "classification",
    xptr = model_xptr,
    blueprint = processed$blueprint
  )
}

cuml_rand_forest_impl_regression <- function(processed, mtry, trees, min_n,
                                             bootstrap, max_depth, max_leaves,
                                             max_predictors_per_note_split,
                                             n_bins, min_samples_leaf,
                                             split_criterion,
                                             min_impurity_decrease,
                                             max_batch_size, n_streams,
                                             cuml_log_level) {
  x <- as.matrix(processed$predictors)
  y <- processed$outcomes[[1]]

  model_xptr <- .rf_regressor_fit(
    input = as.matrix(x),
    responses = as.numeric(y),
    n_trees = as.integer(trees),
    bootstrap = as.logical(bootstrap),
    max_samples = as.numeric(mtry %||% sqrt(ncol(x))) / ncol(x),
    n_streams = as.integer(n_streams),
    max_depth = as.integer(max_depth),
    max_leaves = as.integer(max_leaves),
    max_features = as.numeric(max_predictors_per_note_split %||% sqrt(ncol(x))) / ncol(x),
    n_bins = as.integer(n_bins),
    min_samples_leaf = as.integer(min_samples_leaf),
    min_samples_split = as.integer(min_n %||% 2L),
    split_criterion = split_criterion,
    min_impurity_decrease = as.numeric(min_impurity_decrease),
    max_batch_size = as.integer(max_batch_size),
    verbosity = cuml_log_level
  )
  new_model(
    cls = "cuml_rand_forest",
    mode = "regression",
    xptr = model_xptr,
    blueprint = processed$blueprint
  )
}

#' Make predictions on new data points.
#'
#' Make predictions on new data points using a CuML random forest model.
#' See \code{\link{cuml_predict}} for full documentation of parameters.
#'
#' @template predict
#'
#' @seealso cuml_predict
#' @importFrom ellipsis check_dots_used
#' @export
predict.cuml_rand_forest <- function(object, ...) {
  check_dots_used()

  x <- ...elt(1)
  output_class_probabilities <- if (...length() > 1) ...elt(2) else NULL
  cuml_log_level <- ifelse(...length() > 2, ...elt(3), "off")

  processed <- hardhat::forge(x, object$blueprint)

  predict_cuml_rand_forest_bridge(
    model = object,
    processed = processed,
    output_class_probabilities = output_class_probabilities,
    cuml_log_level = cuml_log_level
  )
}

predict_cuml_rand_forest_bridge <- function(model,
                                            processed,
                                            output_class_probabilities,
                                            cuml_log_level) {
  cuml_log_level <- match_cuml_log_level(cuml_log_level)

  out <- switch(model$mode,
    classification = {
      predict_cuml_rand_forest_classification_impl(
        model = model,
        processed = processed,
        output_class_probabilities = output_class_probabilities %||% FALSE,
        cuml_log_level = cuml_log_level
      )
    },
    regression = {
      if (!is.null(output_class_probabilities)) {
        stop("'output_class_probabilities' is not applicable for regression tasks!")
      }

      predict_cuml_rand_forest_regression_impl(
        model = model,
        processed = processed,
        cuml_log_level = cuml_log_level
      )
    }
  )
  hardhat::validate_prediction_size(out, processed$predictors)

  out
}

predict_cuml_rand_forest_classification_impl <- function(model,
                                                         processed,
                                                         output_class_probabilities,
                                                         cuml_log_level) {
  if (output_class_probabilities) {
    .rf_classifier_predict_class_probabilities(
      model_xptr = model$xptr,
      input = as.matrix(processed$predictors)
    ) %>%
      postprocess_class_probabilities(model)
  } else {
    .rf_classifier_predict(
      model_xptr = model$xptr,
      input = as.matrix(processed$predictors),
      verbosity = cuml_log_level
    ) %>%
      postprocess_classification_results(model)
  }
}

predict_cuml_rand_forest_regression_impl <- function(model, processed,
                                                     cuml_log_level) {
  .rf_regressor_predict(
    model_xptr = model$xptr,
    input = as.matrix(processed$predictors),
    verbosity = cuml_log_level
  ) %>%
    postprocess_regression_results()
}

# register the CuML-based rand_forest model for parsnip
register_rand_forest_model <- function(pkgname) {
  for (mode in c("classification", "regression")) {
    parsnip::set_model_engine(
      model = "rand_forest", mode = mode, eng = "cuml"
    )
  }

  parsnip::set_dependency(model = "rand_forest", eng = "cuml", pkg = pkgname)

  parsnip::set_model_arg(
    model = "rand_forest",
    eng = "cuml",
    parsnip = "mtry",
    original = "mtry",
    func = list(pkg = "dials", fun = "mtry"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "rand_forest",
    eng = "cuml",
    parsnip = "trees",
    original = "trees",
    func = list(pkg = "dials", fun = "trees"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "rand_forest",
    eng = "cuml",
    parsnip = "min_n",
    original = "min_n",
    func = list(pkg = "dials", fun = "min_n"),
    has_submodel = FALSE
  )

  for (mode in c("classification", "regression")) {
    parsnip::set_fit(
      model = "rand_forest",
      eng = "cuml",
      mode = mode,
      value = list(
        interface = "formula",
        protect = c("formula", "data"),
        func = c(pkg = pkgname, fun = "cuml_rand_forest"),
        defaults = list(
          bootstrap = TRUE,
          max_depth = 16L,
          max_leaves = Inf,
          max_predictors_per_note_split = NULL,
          n_bins = 128L,
          min_samples_leaf = 1L,
          split_criterion = NULL,
          min_impurity_decrease = 0,
          max_batch_size = 128L,
          n_streams = 8L,
          cuml_log_level = "off"
        )
      )
    )

    parsnip::set_encoding(
      model = "rand_forest",
      eng = "cuml",
      mode = mode,
      options = list(
        predictor_indicators = "none",
        compute_intercept = FALSE,
        remove_intercept = FALSE,
        allow_sparse_x = TRUE
      )
    )
  }

  for (type in c("class", "prob")) {
    parsnip::set_pred(
      model = "rand_forest",
      eng = "cuml",
      mode = "classification",
      type = type,
      value = list(
        pre = NULL,
        post = NULL,
        func = c(fun = "predict"),
        args = list(
          quote(object$fit),
          quote(new_data),
          identical(type, "prob") # output_class_probabilities
        )
      )
    )
  }

  parsnip::set_pred(
    model = "rand_forest",
    eng = "cuml",
    mode = "regression",
    type = "numeric",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(fun = "predict"),
      args = list(
        quote(object$fit),
        quote(new_data)
      )
    )
  )
}
