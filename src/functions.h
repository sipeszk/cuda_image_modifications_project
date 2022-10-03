#include <stdio.h>
#include <iostream>
#include <string.h>
#include <fstream>
#include <vector>

#include <opencv2/opencv.hpp>

#include <Exceptions.h>
#include <ImageIO.h>
#include <ImagesCPU.h>
#include <ImagesNPP.h>

#include <cuda_runtime.h>
#include <npp.h>
#include <helper_cuda.h>
#include <helper_string.h>

using namespace std;
using namespace cv;

#include "getDevice.cpp"
#include "invert.cpp"
#include "cannyEdgeDetectorNPP.cpp"
