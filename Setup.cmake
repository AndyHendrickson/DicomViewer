#-------------------------------------------------------------------------------
# Configuration step

if ( BUILDING_QT_APP )
  option( BUILD_WITH_QT5 "Build application using Qt5?" OFF )
endif( BUILDING_QT_APP )

# Path to the prebuilt 3rd party libraries
if( MSVC90 )
    set( TRIDIM_3RDPARTY_DIR "${CMAKE_SOURCE_DIR}/3rdParty" CACHE PATH
         "Directory containing prebuilt 3rd party libraries." )
    set( TRIDIM_MOOQ_DIR "D:" CACHE PATH
         "Additional directory containing prebuilt 3rd party libraries like VPL, OpenMesh, OSG, Qt, etc." )
endif( MSVC90 )
if( MSVC10 )
    set( TRIDIM_3RDPARTY_DIR "${CMAKE_SOURCE_DIR}/3rdParty_VS2010" CACHE PATH
         "Directory containing prebuilt 3rd party libraries." )
    set( TRIDIM_MOOQ_DIR "D:" CACHE PATH
         "Additional directory containing prebuilt 3rd party libraries like VPL, OpenMesh, OSG, Qt, etc." )
endif( MSVC10 )
if( MSVC11 )
    if(CMAKE_CL_64)
    	set( TRIDIM_3RDPARTY_DIR "${CMAKE_SOURCE_DIR}/3rdParty_VS2012_x64" CACHE PATH
        	 "Directory containing prebuilt 3rd party libraries." )
    else(CMAKE_CL_64)
    	set( TRIDIM_3RDPARTY_DIR "${CMAKE_SOURCE_DIR}/3rdParty_VS2012" CACHE PATH
        	 "Directory containing prebuilt 3rd party libraries." )
    endif(CMAKE_CL_64)
    set( TRIDIM_MOOQ_DIR "D:" CACHE PATH
         "Additional directory containing prebuilt 3rd party libraries like VPL, OpenMesh, OSG, Qt, etc." )
endif( MSVC11 )
#if( APPLE )
#    set( TRIDIM_3RDPARTY_DIR "/opt/local" CACHE PATH
#         "Directory containing prebuilt 3rd party libraries." )
#    set( TRIDIM_MOOQ_DIR "/opt/local" CACHE PATH
#         "Additional directory containing prebuilt 3rd party libraries like VPL, OpenMesh, OSG, Qt, etc." )
#else()
    if( UNIX )
        set( TRIDIM_3RDPARTY_DIR "/usr/local" CACHE PATH
             "Directory containing prebuilt 3rd party libraries." )
        set( TRIDIM_MOOQ_DIR "/usr/local" CACHE PATH
             "Additional directory containing prebuilt 3rd party libraries like VPL, OpenMesh, OSG, Qt, etc." )
    endif()
#endif()

if( MSVC )
  # Visual C++ default stack size is 1MB. This is not enough 
  if( NOT (${CMAKE_VERSION} VERSION_LESS 2.8.11) )
    # set stack reserved size to ~10MB
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /STACK:10000000")
  endif()
endif()

# Check if the path exists
if( NOT EXISTS ${TRIDIM_3RDPARTY_DIR}/include OR NOT EXISTS ${TRIDIM_3RDPARTY_DIR}/lib )
    message( SEND_ERROR "The specified directory does not contain prebuilt 3rd party libraries! Please, set the value TRIDIM_3RDPARTY_DIR properly..." )
    set( AUX_FIRST_RUN "1" CACHE STRING "Internal helper flag" FORCE )
    mark_as_advanced( AUX_FIRST_RUN )
    return()
endif()

# Check if the path exists
if( NOT EXISTS ${TRIDIM_MOOQ_DIR} )
    message( SEND_ERROR "The specified directory does not exist! Please, set the value TRIDIM_MOOQ_DIR properly..." )
#    return()
endif()

# Stop after the initial options on the first run
if( NOT AUX_FIRST_RUN )
  set( AUX_FIRST_RUN "1" CACHE STRING "Internal helper flag" FORCE )
  mark_as_advanced( AUX_FIRST_RUN )
  return()
endif()

# Set root dir variable
set( TRIDIM_ROOT_DIR ${CMAKE_SOURCE_DIR} )


#-------------------------------------------------------------------------------
# Mac OS X architecture

if( APPLE )
  if( NOT CMAKE_OSX_ARCHITECTURES )
    set( CMAKE_OSX_ARCHITECTURES x86_64 CACHE STRING
         "Choose the type of Mac OS X architecture, options are: i386 and x86_64." FORCE )
  endif()
  add_definitions( -D_DARWIN_C_SOURCE -D_POSIX_C_SOURCE )
  add_definitions( -Wno-undef )
endif()

if( CMAKE_COMPILER_IS_GNUCXX )
  add_definitions( -Wno-unknown-pragmas )
endif()


#-------------------------------------------------------------------------------
# Eigen/VPL/etc. options

add_definitions( "-DEIGEN_DONT_PARALLELIZE" ) 
add_definitions( "-DEIGEN_PERMANENTLY_DISABLE_STUPID_WARNINGS" )

include( CheckCXXCompilerFlag )

if( CMAKE_COMPILER_IS_GNUCXX )
  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wnon-virtual-dtor -Wno-long-long -ansi -Wundef -Wcast-align -Wchar-subscripts -Wall -W -Wpointer-arith -Wwrite-strings -Wformat-security -fexceptions -fno-check-new -fno-common -fstrict-aliasing" )
  set( CMAKE_CXX_FLAGS_DEBUG "-g3" )
  set( CMAKE_CXX_FLAGS_RELEASE "-g0 -O2" )

  check_cxx_compiler_flag( "-Wno-variadic-macros" COMPILER_SUPPORT_WNOVARIADICMACRO )
  if( COMPILER_SUPPORT_WNOVARIADICMACRO )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-variadic-macros" )
  endif()

  check_cxx_compiler_flag( "-Wextra" COMPILER_SUPPORT_WEXTRA )
  if( COMPILER_SUPPORT_WEXTRA )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wextra" )
  endif()

  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pedantic" )
  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused-parameter -Wno-switch" )

  option( EIGEN_ENABLE_SSE2 "Enable/Disable SSE2 in the Eigen library" OFF )
  if( EIGEN_ENABLE_SSE2 )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse2" )
    message(STATUS "Enabling SSE2 in the Eigen library")
  endif()

  option( EIGEN_ENABLE_SSE3 "Enable/Disable SSE3 in the Eigen library" OFF )
  if( EIGEN_ENABLE_SSE3 )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse3" )
    message( STATUS "Enabling SSE3 in the Eigen library" )
  endif()

  option( EIGEN_ENABLE_SSSE3 "Enable/Disable SSSE3 in the Eigen library" OFF )
  if( EIGEN_ENABLE_SSSE3 )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mssse3" )
    message( STATUS "Enabling SSSE3 in the Eigen library" )
  endif()

  check_cxx_compiler_flag("-fopenmp" COMPILER_SUPPORT_OPENMP)
  if( COMPILER_SUPPORT_OPENMP )
    option( TRIDIM_OPENMP_ENABLED "Enables OpenMP support." ON )
    if( TRIDIM_OPENMP_ENABLED )
      set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp" )
      message( STATUS "Enabling OpenMP support" )
    endif()
  endif()
endif( CMAKE_COMPILER_IS_GNUCXX )

if( MSVC )
  # C4127 - conditional expression is constant
  # C4714 - marked as __forceinline not inlined (I failed to deactivate it selectively)
  #         We can disable this warning in the unit tests since it is clear that it occurs
  #         because we are oftentimes returning objects that have a destructor or may
  #         throw exceptions - in particular in the unit tests we are throwing extra many
  #         exceptions to cover indexing errors.
  # C4505 - unreferenced local function has been removed (impossible to deactive selectively)
  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc /wd4127 /wd4505 /wd4714" )
  
  # C4201 - nameless struct/union
  # C4100 - unreferenced formal parameter
  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4100 /wd4201" )

  # C4512 - assignment operator could not be generated
  # C4702 - unreachable code
  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4512 /wd4702" )
  
  # C4068 - unknown pragma
  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4068" )

  # replace all /Wx by /W4
  string( REGEX REPLACE "/W[0-9]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" )

  check_cxx_compiler_flag("/openmp" COMPILER_SUPPORT_OPENMP)
  if( COMPILER_SUPPORT_OPENMP )
    option( TRIDIM_OPENMP_ENABLED "Enables OpenMP support." ON )
    if( TRIDIM_OPENMP_ENABLED )
      set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /openmp" )
      message( STATUS "Enabling OpenMP support" )
    endif()
  endif()
  
  check_cxx_compiler_flag("/MP" COMPILER_SUPPORT_MULTICORE_COMPILATION)
  if( COMPILER_SUPPORT_MULTICORE_COMPILATION )
    option( TRIDIM_MPCOMPILATION_ENABLED "Enables multicore compilation." ON )
    if( TRIDIM_MPCOMPILATION_ENABLED )
      set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP" )
      message( STATUS "Enabling multicore compilation support" )
    endif()
  endif()  

  if( NOT CMAKE_CL_64 )
    check_cxx_compiler_flag("/arch:SSE2" COMPILER_SUPPORT_SSE2)
    if( COMPILER_SUPPORT_SSE2 )
      option( TRIDIM_SSE2_ENABLED "Enables SSE2 support." ON )
      if( TRIDIM_SSE2_ENABLED )
        set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /arch:SSE2" )
        message( STATUS "Enabling SSE2 support" )
      endif()
    endif()  
  endif( NOT CMAKE_CL_64 )

endif( MSVC )