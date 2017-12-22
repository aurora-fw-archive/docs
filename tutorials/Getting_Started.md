@page getting-started Getting Started

Welcome to the Aurora Framework documentation! In this tutorial we'll start by setting up Aurora Framework on your system so you can use it in your projects.

@note Currently this guide was written only for Linux bases systems. Windows and macOSX instructions will be written soon.

@tableofcontents

@section prerequisites Prerequesites

To compile Aurora, you'll need the following:

- <a href="https://git-scm.com/">git</a>
- <a href="https://ninja-build.org/">ninja</a>
- <a href="https://cmake.org/">cmake</a> (> 3.3)
- <a href="https://source.android.com/source/downloading#installing-repo">repo</a>

Some Aurora modules have dependencies, which you must also have installed:

**Audio Module**

- <a href="http://portaudio.com/">PortAudio</a>
- <a href="http://www.mega-nerd.com/libsndfile/">libsndfile</a>

**GEngine-Core Module**

- <a href="http://www.glfw.org/">GLFW</a> (> 3.2)

**GEngine-OpenGL Module**

- <a href="https://www.opengl.org/">OpenGL</a>
- <a href="http://glew.sourceforge.net/">GLEW</a>

**GUI Module**

- <a href="https://www.gtk.org/">GTK3</a>

**Image Module**

- <a href="http://freeimage.sourceforge.net/">FreeImage</a>

The following modules have some dependecies which are not required to build Aurora:

**GEngine-Vulkan Module**

- <a href="https://www.khronos.org/vulkan/">Vulkan</a>

This guide is made for two type of users:

- The regular users who just want to compile the stable version of Aurora to use in their projects.
- The developers who want to contribute to the development of Aurora.

There are different instructions for both types of users. Pay attention to which instructions you should follow.

@section getting-source-code Getting the source code

To download the source code, run the following commands:

@subsection getting-source-code-user For regular users

```
mkdir aurora-fw
cd aurora-fw
repo init -u https://github.com/aurora-fw/manifest.git -b master
repo sync ```

The source code is now inside the folder `aurora-fw`

@subsection getting-source-code-developer For developers

```
mkdir aurora-fw
cd aurora-fw
repo init -u https://github.com/aurora-fw/manifest.git -b dev
repo sync
repo forall -c repo start dev . ```

The source code is now inside the folder `aurora-fw`

@section compiling Compiling Aurora

To compile Aurora, you must run this CMake command on the root of the project:

@subsection compiling-user For regular users

```cmake
cmake -GNinja .
```

CMake will then generate a `build.ninja` file on the root of the `aurora-fw` folder. Now you just need to run:

```
ninja
```

The binaries will be located in the `bin` folder.

@subsection compiling-developer For developers

```cmake
cmake -DCMAKE_BUILD_TYPE=Debug -GNinja .
```

There are some custom aurora arguments you may use:

- -DAURORA_TARGET_DOCUMENTATION=ON/OFF (Enable documentation target on ninja. Default is ON)
- -DAURORA_DOCUMENTATION_AUTO=ON/OFF (Automatically build documentation when compiling the code. Default is ON)
- -DAURORA_PCH=ON/OFF (Precompile headers. **WARNING:**This feature is still experimental, use it at your own risk. Default is OFF)

You can add more custom arguments to the CMake command:

CMake will then generate a `build.ninja` file on the root of the `aurora-fw` folder. Now you just need to run:

```
ninja
```

The binaries and test-apps will be located in the `bin/dbg` folder.
