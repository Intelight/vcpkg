# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/libxml2-2.9.4)
vcpkg_download_distfile(ARCHIVE
    URLS "ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz"
    FILENAME "libxml2-2.9.4.tar.gz"
    SHA512 f5174ab1a3a0ec0037a47f47aa47def36674e02bfb42b57f609563f84c6247c585dbbb133c056953a5adb968d328f18cbc102eb0d00d48eb7c95478389e5daf9
)
vcpkg_extract_source_archive(${ARCHIVE})

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS_DEBUG -DINSTALL_HEADERS=OFF
)

vcpkg_install_cmake()

# Handle copyright
file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libxml2)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/libxml2/COPYING ${CURRENT_PACKAGES_DIR}/share/libxml2/copyright)

vcpkg_copy_pdbs()