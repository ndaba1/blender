# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright 2022 Blender Foundation. All rights reserved.

# Auto update existing CMake caches for new libraries

function(unset_cache_variables pattern)
  get_cmake_property(_cache_variables CACHE_VARIABLES)
  foreach (_cache_variable ${_cache_variables})
    if("${_cache_variable}" MATCHES "${pattern}")
      unset(${_cache_variable} CACHE)
    endif()
  endforeach()
endfunction()

# Detect update from 3.1 to 3.2 libs.
if(UNIX AND
   DEFINED OPENEXR_VERSION AND
   OPENEXR_VERSION VERSION_LESS "3.0.0" AND
   EXISTS ${LIBDIR}/imath)
  message(STATUS "Auto updating CMake configuration for Blender 3.2 libraries")

  unset_cache_variables("^OPENIMAGEIO")
  unset_cache_variables("^OPENEXR")
  unset_cache_variables("^IMATH")
  unset_cache_variables("^PNG")
  unset_cache_variables("^USD")
  unset_cache_variables("^WEBP")
endif()

# Automatically set WebP on/off depending if libraries are available.
if(EXISTS ${LIBDIR}/webp)
  if(WITH_OPENIMAGEIO)
    set(WITH_IMAGE_WEBP ON CACHE BOOL "" FORCE)
  endif()
else()
  set(WITH_IMAGE_WEBP OFF)
endif()
