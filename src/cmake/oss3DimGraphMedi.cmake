#===============================================================================
# $Id$
#
# 3DimViewer
# Lightweight 3D DICOM viewer.
#
# Copyright 2008-2012 3Dim Laboratory s.r.o.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#===============================================================================

# Create library
ADD_TRIDIM_LIBRARY( 3DimGraphMedi )

# Options
set( TRIDIM_GRAPHMEDI_LIB_INCLUDE include/3dim/graphmedi )
set( TRIDIM_GRAPHMEDI_LIB_SRC src/graphmedi )

INCLUDE_BASIC_OSS_HEADERS()
INCLUDE_MEDICORE_OSS_HEADERS()

target_compile_definitions(${TRIDIM_CURRENT_TARGET} PUBLIC _UNICODE UNICODE)

target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/${TRIDIM_GRAPHMEDI_LIB_INCLUDE} )

if( TRIDIM_LIBRARY_EXT )
    set( TRIDIM_GRAPHMEDI_LIB_INCLUDE_EXT ${TRIDIM_GRAPHMEDI_LIB_INCLUDE}${TRIDIM_LIBRARY_EXT} )
    set( TRIDIM_GRAPHMEDI_LIB_SRC_EXT ${TRIDIM_GRAPHMEDI_LIB_SRC}${TRIDIM_LIBRARY_EXT} )

    target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/${TRIDIM_GRAPHMEDI_LIB_INCLUDE_EXT} )

endif()

target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/bluedent )
target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/geometry/ )
target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/graphmedi${TRIDIM_LIBRARY_EXT} )
target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/qtgui${TRIDIM_LIBRARY_EXT} )
target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/qtgui/ )

if(BUILD_PLUGINS)
    target_include_directories(${TRIDIM_LIBRARY_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/qtplugin )
endif()

ADD_LIB_QT()
ADD_LIB_VPL()
ADD_LIB_GLEW()
ADD_LIB_OSG()
ADD_LIB_EIGEN()
ADD_LIB_OPENMESH()
ADD_LIB_LEAPMOTION()
ADD_LIB_FLANN()

if( APPLE )
  ADD_LIB_OPENGL()
endif()

#-------------------------------------------------------------------------------
# Add Headers and Sources

ADD_LIBRARY_HEADER_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GRAPHMEDI_LIB_INCLUDE} )
ADD_LIBRARY_SOURCE_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GRAPHMEDI_LIB_SRC} )

if( TRIDIM_LIBRARY_EXT )
  ADD_LIBRARY_HEADER_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GRAPHMEDI_LIB_INCLUDE_EXT} )
  ADD_LIBRARY_SOURCE_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GRAPHMEDI_LIB_SRC_EXT} ) 
endif()

#-------------------------------------------------------------------------------
# Create source groups

ADD_SOURCE_GROUPS( ${TRIDIM_GRAPHMEDI_LIB_INCLUDE}
                   ${TRIDIM_GRAPHMEDI_LIB_SRC}
                   data drawing osg render shaders shaders2 widgets
                   )

if( TRIDIM_LIBRARY_EXT )
  ADD_SOURCE_GROUPS( ${TRIDIM_GRAPHMEDI_LIB_INCLUDE_EXT}
                     ${TRIDIM_GRAPHMEDI_LIB_SRC_EXT}
                     drawing osg render shaders2 widgets guide
                     )
endif()

#-------------------------------------------------------------------------------
# Finalize library
target_sources(${TRIDIM_CURRENT_TARGET} PRIVATE "${TRIDIM_LIBRARY_HEADERS}" "${TRIDIM_LIBRARY_SOURCES}")


set_target_properties( ${TRIDIM_CURRENT_TARGET} PROPERTIES
                        PROJECT_LABEL ${TRIDIM_CURRENT_TARGET}
                        DEBUG_POSTFIX d
                        LINK_FLAGS "${TRIDIM_LINK_FLAGS}"
                        )

pop_target_stack()
