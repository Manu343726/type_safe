# Copyright (C) 2016-2019 Jonathan Müller <jonathanmueller.dev@gmail.com>
# This file is subject to the license terms in the LICENSE file
# found in the top-level directory of this distribution.

option(TYPE_SAFE_OVERRIDE_SUBMODULE_URLS "Override submodule URLs using cmake config variables" TRUE)

if(NOT TYPE_SAFE_DEBUG_ASSERT_URL)
    set(TYPE_SAFE_DEBUG_ASSERT_URL https://github.com/foonathan/debug_assert)
endif()

function(configure_submodule module)
    message(STATUS "Installing ${module} via git submodule")

    string(TOUPPER "${module}" moduleUpperCase)
    set(urlVariable "TYPE_SAFE_${moduleUpperCase}_URL")

    find_package(Git REQUIRED)

    if(TYPE_SAFE_OVERRIDE_SUBMODULE_URLS AND ${urlVariable})
        message(STATUS "Overriding ${module} submodule URL, using ${${urlVariable}}")

        execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory external/${module}
            WORKING_DIRECTORY ${TYPE_SAFE_SOURCE_DIR})

        execute_process(COMMAND ${GIT_EXECUTABLE} config --file=.gitmodules submodule.${module}.url ${${urlVariable}}
            WORKING_DIRECTORY ${TYPE_SAFE_SOURCE_DIR})

        execute_process(COMMAND ${GIT_EXECUTABLE} submodule sync -- external/${module}
            WORKING_DIRECTORY ${TYPE_SAFE_SOURCE_DIR})
    endif()

    execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init -- external/${module}
        WORKING_DIRECTORY ${TYPE_SAFE_SOURCE_DIR})
endfunction()


find_package(debug_assert QUIET)
if(debug_assert_FOUND)
    set(TYPE_SAFE_HAS_IMPORTED_TARGETS ON)
else()
    set(TYPE_SAFE_HAS_IMPORTED_TARGETS OFF)
    if(TARGET debug_assert)
        message(STATUS "Using inherited debug_assert target")
    else()
        configure_submodule(debug_assert)
        add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/external/debug_assert EXCLUDE_FROM_ALL)
    endif()
endif()
