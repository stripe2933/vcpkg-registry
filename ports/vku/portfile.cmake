vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stripe2933/vku
    REF "v${VERSION}"
    HEAD_REF main
    SHA512 0cab6dc17e292af98941144121d8c5a11b48832f21180a739fedb366e53c0ef8b686cd3d1c5976ec9d2c2588fa0f49bc74fc2d8f28a03e506cdd244b07e92d0e
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()

if (NOT VCPKG_BUILD_TYPE STREQUAL "release")
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/share)
    file(RENAME ${CURRENT_PACKAGES_DIR}/debug/cmake/vku ${CURRENT_PACKAGES_DIR}/debug/share/vku)
endif()
if (NOT VCPKG_BUILD_TYPE STREQUAL "debug")
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share)
    file(RENAME ${CURRENT_PACKAGES_DIR}/cmake/vku ${CURRENT_PACKAGES_DIR}/share/vku)
endif()

vcpkg_cmake_config_fixup(PACKAGE_NAME "vku")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/cmake" "${CURRENT_PACKAGES_DIR}/debug/cmake")

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
