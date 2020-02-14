# - Find Qhull
# Find the Qhull library
#
# Specify components:
#
# ::
#   qhull          = Deprecated interface: use imported target Qhull::qhull
#   qhullstatic    = Recommended alternative to re-entrant interface: use imported target Qhull::qhullstatic
#   qhull_r        = Recommended (re-entrant) interface: use imported target Qhull::qhull_r
#   qhullstatic_r  = Recommended (re-entrant) interface: use imported target Qhull::qhullstatic_r
#   qhullcpp       = C++ interface: use imported target Qhull::libqhullcpp
#
#  QHULL_FOUND - True if Qhull was found.
#
# Original Author:
# 2019 Ryan Pavlik <ryan.pavlik@collabora.com> <ryan.pavlik@gmail.com>
#
# Copyright Collabora, Ltd. 2019
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)
#
# SPDX-License-Identifier: BSL-1.0

set(QHULL_ROOT_DIR
    "${QHULL_ROOT_DIR}"
    CACHE PATH "Directory to search for Qhull")

find_path(
    QHULL_qhull_INCLUDE_DIR
    NAMES libqhull/libqhull.h
    PATHS "${QHULL_ROOT_DIR}")
find_path(
    QHULL_qhull_r_INCLUDE_DIR
    NAMES libqhull_r/libqhull_r.h
    PATHS "${QHULL_ROOT_DIR}")
find_path(
    QHULL_qhullcpp_INCLUDE_DIR
    NAMES libqhullcpp/Qhull.h
    PATHS "${QHULL_ROOT_DIR}")
foreach(_qh_lib qhull qhull_r qhullstatic qhullstatic_r qhullcpp)
message("${_qh_lib} lib${_qh_lib}")
    find_library(
        QHULL_${_qh_lib}_LIBRARY
        NAMES ${_qh_lib} lib${_qh_lib}
        PATHS "${QHULL_ROOT_DIR}")
endforeach()

message("
    QHULL_ROOT_DIR: ${QHULL_ROOT_DIR}
    QHULL_qhull_INCLUDE_DIR: ${QHULL_qhull_INCLUDE_DIR}
    QHULL_qhull_LIBRARY: ${QHULL_qhull_LIBRARY}
    QHULL_qhull_r_INCLUDE_DIR: ${QHULL_qhull_r_INCLUDE_DIR}
    QHULL_qhull_r_LIBRARY: ${QHULL_qhull_r_LIBRARY}
    QHULL_qhullcpp_INCLUDE_DIR: ${QHULL_qhullcpp_INCLUDE_DIR}
    QHULL_qhullcpp_LIBRARY: ${QHULL_qhullcpp_LIBRARY}
    QHULL_qhullstatic_LIBRARY: ${QHULL_qhullstatic_LIBRARY}
    QHULL_qhullstatic_r_LIBRARY: ${QHULL_qhullstatic_r_LIBRARY}
")

mark_as_advanced(
    QHULL_qhull_INCLUDE_DIR
    QHULL_qhull_LIBRARY
    QHULL_qhull_r_INCLUDE_DIR
    QHULL_qhull_r_LIBRARY
    QHULL_qhullcpp_INCLUDE_DIR
    QHULL_qhullcpp_LIBRARY
    QHULL_qhullstatic_LIBRARY
    QHULL_qhullstatic_r_LIBRARY)

