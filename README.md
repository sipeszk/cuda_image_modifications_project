# **CUDA at Scale For The Enterprise Course Project**

This repository contains source code for the course project for the CUDA at Scale for the Enterprise

## **Project Description**

Using GPU CUDA and C++ programming language, in this work two basic picture manipulations are demonstrated. OpenCV and NPP is necessary for this program to work. There is user defined options, in case of `-i` option, the code will generate the inverted picture from the input picture, in the second case using `-e` option the edge of the input picture is determined using NPP canny edge detection. 
The program reads the image file and the corresponding option from the standard input, thus for the code running the user should give the full path for the image file and the choosed option as:
    <center> `bin/imageconvert.exe <path/filename.type> <option>` </center>
, where the possible options:  <br />
                    _-i_    invert the input image  <br />
                    _-e_    create edge of the input image 

## **Code Organization**

_bin/_ This folder containes the executable code, in the current case the executable is _imageconvert.exe_ .

_data/_ This folder holds all example image files. Image files were downloaded from https://search.creativecommons.org as well as from the Coursera laboratory examples.

_src/_ The source code was placed here.

_lib/_ - This folder containes the linked library, it is needed for compiling

_CMakeLists.txt_ - cmake file for compiling. 

## **Installation**

For the installation process, the _Cmake_ is used which generates a _Makefile_ for compiling the code. The installations steps:  
      `mkdir -p build && cd build`   
      `cmake ..`   
      `make`   
      `cd ..`  
After the succesfull installation, the executable (_imageconvert.exe_ ) can be found in the bin directory. 