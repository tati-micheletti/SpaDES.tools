% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/downloadInputs.R
\name{prepInputs}
\alias{prepInputs}
\title{Download and optionally reproject, crop, mask raw data and output module
inputs}
\usage{
prepInputs(targetFile, archive = NULL, modulePath, moduleName,
  fun = "raster", pkg = "raster", studyArea = NULL,
  rasterToMatch = NULL, rasterInterpMethod = "bilinear",
  rasterDatatype = "INT2U", writeCropped = TRUE, addTagsByObject = NULL,
  quick = FALSE, cacheTags = "stable")
}
\arguments{
\item{targetFile}{Character string giving the path of the raw data.}

\item{archive}{Optional character string giving the path of an archive
containing \code{targetFile}.}

\item{modulePath}{Character string giving the path to the module directory.}

\item{moduleName}{Character string giving the name of the module.}

\item{fun}{Character string indicating the function to use to load
\code{targetFile}.}

\item{pkg}{Character string indicating the package in which to find \code{fun}.}

\item{studyArea}{spatial* or sf object used for cropping and masking.}

\item{rasterToMatch}{Template Raster* object used for reprojecting and
cropping.}

\item{rasterInterpMethod}{Method used to compute values for the new
RasterLayer. See \code{\link[raster]{projectRaster}}. Defaults to bilinear.}

\item{rasterDatatype}{Output data type. Passed to \code{\link[raster]{writeRaster}}.}

\item{writeCropped}{Write the output on disk ?}

\item{addTagsByObject}{Pass any object in there for which there is a
.tagsByClass function}

\item{quick}{Logical. If \code{sideEffect = TRUE}, setting this to \code{TRUE},
will hash the file's metadata (i.e., filename and file size) instead of
hashing the contents of the file(s). If set to \code{FALSE} (default),
the contents of the file(s) are hashed.
\emph{NOTE: this argument is experimental and may change in future releases.}}

\item{cacheTags}{Character vector with Tags. These Tags will be added to the
repository along with the artifact.}
}
\description{
This function can be used to prepare module inputs from raw data. It
runs several other functions, conditionally:
\code{extractFromArchive}.
}
\author{
Eliot McIntire

Jean Marchal
}
