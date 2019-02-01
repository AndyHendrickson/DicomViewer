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
ADD_TRIDIM_LIBRARY( 3DimGuiQtMedi )

INCLUDE_BASIC_OSS_HEADERS()
INCLUDE_MEDICORE_OSS_HEADERS()


set( TRIDIM_GUIQTMEDI_LIB_INCLUDE include/3dim/qtguimedi )
set( TRIDIM_GUIQTMEDI_LIB_SRC src/qtguimedi )



target_include_directories(${TRIDIM_CURRENT_TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/${TRIDIM_GUIQTMEDI_LIB_INCLUDE} )

if( TRIDIM_LIBRARY_EXT )
    set( TRIDIM_GUIQTMEDI_LIB_INCLUDE_EXT ${TRIDIM_GUIQTMEDI_LIB_INCLUDE}${TRIDIM_LIBRARY_EXT} )
    set( TRIDIM_GUIQTMEDI_LIB_SRC_EXT ${TRIDIM_GUIQTMEDI_LIB_SRC}${TRIDIM_LIBRARY_EXT} )

    target_include_directories(${TRIDIM_CURRENT_TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/${TRIDIM_GUIQTMEDI_LIB_INCLUDE_EXT} )
endif()


target_include_directories(${TRIDIM_CURRENT_TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/qtgui${TRIDIM_LIBRARY_EXT}/ )
target_include_directories(${TRIDIM_CURRENT_TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/qtgui/ )
target_include_directories(${TRIDIM_CURRENT_TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/include/3dim/qtplugin/ )

ADD_LIB_QT()
ADD_LIB_OSG()
ADD_LIB_VPL()
ADD_LIB_EIGEN()
ADD_LIB_OPENMESH()


#-------------------------------------------------------------------------------
# Add Headers and Sources

ADD_HEADER_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GUIQTMEDI_LIB_INCLUDE} )
ADD_SOURCE_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GUIQTMEDI_LIB_SRC} )

if( TRIDIM_LIBRARY_EXT )
  ADD_HEADER_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GUIQTMEDI_LIB_INCLUDE_EXT} )
  ADD_SOURCE_DIRECTORY( ${CMAKE_SOURCE_DIR}/${TRIDIM_GUIQTMEDI_LIB_SRC_EXT} )
endif()

#-------------------------------------------------------------------------------
# Create source groups

ADD_SOURCE_GROUPS( ${TRIDIM_GUIQTMEDI_LIB_INCLUDE}
                   ${TRIDIM_GUIQTMEDI_LIB_SRC}
                   controls osg
                   )

if( TRIDIM_LIBRARY_EXT )
  ADD_SOURCE_GROUPS( ${TRIDIM_GUIQTMEDI_LIB_INCLUDE_EXT}
                     ${TRIDIM_GUIQTMEDI_LIB_SRC_EXT}
                     osg
                     )
endif()

#-------------------------------------------------------------------------------
# Finalize library
target_sources(${TRIDIM_CURRENT_TARGET} PRIVATE "${${TRIDIM_CURRENT_TARGET}_HEADERS}" "${${TRIDIM_CURRENT_TARGET}_SOURCES}")


set_target_properties( ${TRIDIM_CURRENT_TARGET} PROPERTIES
                        PROJECT_LABEL lib${TRIDIM_CURRENT_TARGET}
                        DEBUG_POSTFIX d
                        LINK_FLAGS "${TRIDIM_LINK_FLAGS}"
                        )

pop_target_stack()
