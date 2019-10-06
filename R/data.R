#' A subset of the HF-ACTION study data on non-ischemic heart failure patients
#'
#' @description These are a subset of the data on the non-ischemic patients in the HF-ACTION study.
#' @format A data frame with 751 rows and 16 variables:
#' \describe{
#'   \item{ID}{subject IDs}
#'   \item{time}{event times}
#'   \item{status}{event status}
#'   \item{trt_ab}{treatment indicator: 1=exercise training; 0=usual care}
#'   \item{age}{patient age in years}
#'   \item{sex}{1=female; 2=male}
#'   \item{Black.vs.White}{1=black; 0=otherwise}
#'   \item{Other.vs.White}{1=race other than black or white; 0=otherwise}
#'   \item{bmi}{body mass index}
#'   \item{bipllvef}{(biplane) left-ventricular ejection fraction}
#'   \item{hyperten}{indicator for history of hypertension}
#'   \item{COPD}{indicator for history of COPD}
#'   \item{diabetes}{indicator for history of diabetes}
#'   \item{acei}{indicator for current use of ACE inhibitors}
#'   \item{betab }{indicator for current use of beta blockers}
#'   \item{smokecurr }{indicator for current smoker}
#'   }
#' @references O'Connor, C. M., Whellan, D. J., Lee, K. L., Keteyian, S. J., Cooper, L. S., Ellis, S. J.,
#' Leifer, E. S., Kraus, W. E., Kitzman, D. W., Blumenthal, J. A. et al. (2009). "Efficacy and
#' safety of exercise training in patients with chronic heart failure: HF-ACTION randomized
#' controlled trial". Journal of the American Medical Association, 301, 1439--1450.
"non_ischemic"
