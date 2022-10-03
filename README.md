# **CUDA at Scale For The Enterprise Course Project**

This repository contains source code for the course project for the CUDA at Scale for the Enterprise

## **Project Description**

Using GPU CUDA and C++ programming language, in this work the color of an input image is inverted. OpenCV is necessary for this program to work. 
The program reads the image file from the standard input, thus for the code running the user should give the full path for the image file and the name of the image file such as:
    
                    ./invert.exe <path/filename.type>

## **Code Organization**

_bin/_ This folder containes the executable code, in the current case the executable is _invert.exe_ .

_data/_ This folder holds all example image files. Image files were downloaded from https://search.creativecommons.org

_src/_ The source code was placed here.

## **Installation**

For the installation process, the _CMAKE_ is used which generates a _Makefile_ for compiling the code. 