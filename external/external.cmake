# Copyright (C) 2016-2019 Jonathan Müller <jonathanmueller.dev@gmail.com>
# This file is subject to the license terms in the LICENSE file
# found in the top-level directory of this distribution.

if(NOT TYPE_SAFE_DEBUG_ASSERT_REPO_URL)
    set(TYPE_SAFE_DEBUG_ASSERT_REPO_URL "https://github.com/foonathan/debug_assert")
endif()
if(NOT TYPE_SAFE_DEBUG_ASSERT_VERSION)
    set(TYPE_SAFE_DEBUG_ASSERT_VERSION "130adcbb393befa29d70036d93905f7bd94aa110")
endif()

include(FetchContent)

FetchContent_Declare(
    debug_assert
    GIT_REPOSITORY "${TYPE_SAFE_DEBUG_ASSERT_REPO_URL}"
    GIT_TAG "${TYPE_SAFE_DEBUG_ASSERT_VERSION}"
)

find_package(debug_assert QUIET)
if(debug_assert_FOUND)
    set(TYPE_SAFE_HAS_IMPORTED_TARGETS ON)
else()
    set(TYPE_SAFE_HAS_IMPORTED_TARGETS OFF)

    FetchContent_GetProperties(debug_assert)

    if(NOT debug_assert_POPULATED)
        FetchContent_Populate(debug_assert)
        add_subdirectory("${debug_assert_SOURCE_DIR}" "${debug_assert_BINARY_DIR}" EXCLUDE_FROM_ALL)
    endif()
endif()
