vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stripe2933/type_map
    REF "v${VERSION}"
    HEAD_REF main
    SHA512 c2330817766481582b316f8c1e1ed3beb8cf398a74da1c83b4791506418829b91ca2267bc47dca00199ab5288ece157202f171098161d493c23f455cc45569e4
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()

if (NOT VCPKG_BUILD_TYPE STREQUAL "release")
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/share)
    file(RENAME ${CURRENT_PACKAGES_DIR}/debug/cmake/type_map ${CURRENT_PACKAGES_DIR}/debug/share/type_map)
endif()
if (NOT VCPKG_BUILD_TYPE STREQUAL "debug")
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share)
    file(RENAME ${CURRENT_PACKAGES_DIR}/cmake/type_map ${CURRENT_PACKAGES_DIR}/share/type_map)
endif()

vcpkg_cmake_config_fixup(PACKAGE_NAME "type_map")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/cmake" "${CURRENT_PACKAGES_DIR}/debug/cmake")

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
