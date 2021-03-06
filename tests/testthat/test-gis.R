test_that("fastMask produces correct results", {
  ## gdal_rasterize and velox have different rounding compared to rasterize
  ##  when polygon splits a raster perfectly in 2
  ##  -- there is one difference here in Sr1 1 instead of 0.9
  Sr1 <- sp::Polygon(cbind(c(2, 4, 4, 1, 2), c(2, 3, 5, 4, 2))) # nolint
  Sr2 <- sp::Polygon(cbind(c(5, 4, 2, 5), c(2, 3, 2, 2))) # nolint
  Sr3 <- sp::Polygon(cbind(c(4, 4, 5, 7.4, 4), c(5, 3, 2, 5, 5))) # nolint

  Srs1 <- sp::Polygons(list(Sr1), "s1") # nolint
  Srs2 <- sp::Polygons(list(Sr2), "s2") # nolint
  Srs3 <- sp::Polygons(list(Sr3), "s3") # nolint

  shp <- sp::SpatialPolygons(list(Srs1, Srs2, Srs3), 1:3)
  d <- data.frame(vals = 1:3, other = letters[1:3])
  row.names(d) <- names(shp)
  shp <- sp::SpatialPolygonsDataFrame(shp, data = d)
  poly <- list()
  poly[[1]] <- raster::raster(raster::extent(shp), vals = 0, res = c(0.5, 0.5))
  poly[[2]] <- raster::raster(raster::extent(shp), vals = 1, res = c(0.5, 0.5))
  origStack <- raster::stack(poly)

  ## mask
  newStack1 <- raster::stack(raster::mask(origStack, mask = shp))
  newStack2 <- fastMask(x = origStack, polygon = shp)
  expect_equal(newStack1, newStack2)

  newStack1 <- raster::mask(origStack[[2]], mask = shp)
  newStack2 <- fastMask(x = origStack[[2]], polygon = shp)
  expect_equal(newStack1, newStack2)
})

test_that("fastCrop works", {
  library(raster)

  Sr1 <- sp::Polygon(cbind(c(2, 4, 4, 1, 2), c(2, 3, 5, 4, 2))) # nolint
  Sr2 <- sp::Polygon(cbind(c(5, 4, 2, 5), c(2, 3, 2, 2))) # nolint
  Sr3 <- sp::Polygon(cbind(c(4, 4, 5, 10, 4), c(5, 3, 2, 5, 5))) # nolint

  Srs1 <- sp::Polygons(list(Sr1), "s1") # nolint
  Srs2 <- sp::Polygons(list(Sr2), "s2") # nolint
  Srs3 <- sp::Polygons(list(Sr3), "s3") # nolint
  shp <- sp::SpatialPolygons(list(Srs1, Srs2, Srs3), 1:3)
  d <- data.frame(vals = 1:3, other = letters[1:3])
  row.names(d) <- names(shp)
  shp <- sp::SpatialPolygonsDataFrame(shp, data = d)
  poly <- list()
  poly[[1]] <- raster::raster(raster::extent(shp), vals = 0, res = c(1, 1))
  poly[[2]] <- raster::raster(raster::extent(shp), vals = 1, res = c(1, 1))
  r <- raster::stack(poly)

  ext <- extent(c(2, 7, 3, 5))
  rc <- stack(crop(r, ext))

  rc2 <- fastCrop(r, ext)
  expect_equivalent(rc, rc2)
})
