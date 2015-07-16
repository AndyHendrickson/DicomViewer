    **********************************************************************
    * This file is part of
    * 
    * 3DimViewer - A lightweight 3D DICOM viewer.
    * Copyright 2008-2014 3Dim Laboratory s.r.o.
    * All rights reserved.
    * 
    * Licensed under the Apache License, Version 2.0 (the "License");
    * you may not use this file except in compliance with the License.
    * You may obtain a copy of the License at
    * 
    *   http://www.apache.org/licenses/LICENSE-2.0
    * 
    * Unless required by applicable law or agreed to in writing, software
    * distributed under the License is distributed on an "AS IS" BASIS,
    * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    * See the License for the specific language governing permissions and
    * limitations under the License.
    **********************************************************************

Table of Contents

1. What is 3DimViewer?
    1. Basic Features
2. Installation
    1. Compilation using MS Visual Studio
    2. Compilation on Linux
    3. Patch for OpenMesh 3.x
3. Bug Reporting
4. Contacts


1 What is 3DimViewer?
=====================

3DimViewer is a lightweight 3D viewer of medical DICOM datasets that is
distributed as open source software (see ''LICENSE.txt''). The viewer
is multiplatform software written in C++ that runs on Windows and Linux
systems.


1.1 Basic Features
------------------

* Genuine 3D viewer of volumetric data. 
* Multiplanar view (three orthogonal slices through the data). 
* Adjustable density window. 
* Strong DICOM dataset import. 
* Distance and density measuring. 
* High quality Volume rendering for direct 3D visualization.
* Tissue segmentation based on thresholding. 
* Surface reconstruction of any segmented tissue. 
* 3D surface rendering. 
* Advanced functions available via extension plugins. 


---

2 Installation
==============

First of all, you should have the CMake utility installed on your system to 
compile the 3DimViewer:

  * CMake (Cross-platform Make, http://www.cmake.org/) is an open-source build 
  system. "CMake is used to control the software compilation process using 
  simple platform and compiler independent configuration files. CMake generates 
  native makefiles and workspaces that can be used in the compiler environment 
  of your choice."


2.1 Compilation using MS Visual Studio
--------------------------------------

All required prebuilt 3rd party libraries can be downloaded separately in a 
single package. Alternatively, you can build them on your own. In that case, 
we recommend you to build at least OpenSceneGraph, Qt and VPL
libraries. A more comprehensive guide can be found in 
''doc/Installation.htm''. For a complete list of required 3rd party libraries 
take a look at ''3rdParty.txt''.

* Where appropriate, download the package of prebuilt 3rd party libraries and 
unpack it into the ''3rdParty'' directory.

* Use the utility ''CMakeSetup'' (or ''cmake-gui'' recently) to generate 
project and solution files for your MS Visual Studio.

* Setup a build directory different (e.g. ''build'') from the source 
directory. Advantage of such out-of-source build is that temporary files 
created by CMake and compiler won't disturb the source directory. Also, it 
makes possible to have multiple independent build targets by creating 
multiple build 
directories.

* Open the solution ''3Dim.sln'' which will be placed in the build directory 
and compile the project '3DimViewer'...

* Final executable will be placed directly in the 
'applications/3DimViewer/bin' directory and loadable plugins in the 
''applications/3DimViewer/plugins'' directory.

* Set working directory of the '3DimViewer' project to be 
''applications/3DimViewer'' by opening project properties and setting 
''Debugging->Working Directory'' option.

* Add ''3rdParty\bin'' directory into your PATH, or copy all dll-libraries 
into the ''applications/3DimViewer/bin'' directory.

* Now, you can run the 3DimViewer directly from Visual Studio. All icons, 
images, etc. will be correctly found.


2.2 Compilation on Linux
------------------------

Compilation on Linux is supported providing "almost all" functionality of the 
original windows application! The following guide describes how to compile the 
viewer on Ubuntu 10.10 (32-bit version):

* Install CMake and ccmake utilities first
 sudo apt-get install cmake cmake-curses-gui

* Install GLEW library to the system
 sudo apt-get install libglew-dev glew-utils

* Install CURL library
 sudo apt-get install libcurl4-openssl-dev

* Compile and install MDSTk, OpenSceneGraph and wxWidgets libraries
  (see the ''doc/Installation.htm'' for a complete guide).

* Unpack sources of the 3DimViewer into your home directory ''~/3DimViewer-x.y''

* Create a new directory for an out-of-source build
  (''~/3DimViewer-x.y/build'') and use CMake to generate makefiles
 cd ~/3DimViewer-x.y
 mkdir build
 cd build
 ccmake ..

* Build the viewer
 make

* Final executable will be placed directly in the 
''applications/3DimViewer/bin' directory and loadable plugins in the 
''applications/3DimViewer/plugins'' directory.


2.3 Patch for OpenMesh 3.x
--------------------------

A simple patch has to be applied to OpenMesh's *PolyConnectivity* files.
Move implementations of the below methods from the *.cc* file to the corresponding *.hh* file.

    /// Begin iterator for vertices
    VertexIter vertices_begin() { return VertexIter(*this, VertexHandle(0)); }
    /// Const begin iterator for vertices
    ConstVertexIter vertices_begin() const { return VertexIter(*this, VertexHandle(0)); }
    /// End iterator for vertices
    VertexIter vertices_end() { return ConstVertexIter(*this, VertexHandle(int(n_vertices()))); }
    /// Const end iterator for vertices
    ConstVertexIter vertices_end() const { return ConstVertexIter(*this, VertexHandle(int(n_vertices()))); }


---

3 Bug Reporting
===============

We don't promise that this software is completely bug free. If you encounter
any issue, please let us now.

- Report the bug using 
  [Bitbucket's issue tracker](https://bitbucket.org/3dimlab/3dimviewer/issues),
- mail your bug reports to info(at)3dim-laboratory.cz,

or

- fork the repository, fix it, and send us a pull request.


---

4 Contacts
==========

3Dim Laboratory s.r.o.
E-mail: info@3dim-laboratory.cz
Web: http://www.3dim-laboratory.cz/
