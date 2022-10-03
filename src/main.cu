
#include "functions.h"
/*
 * Host main routine
 * -i invert image
 * -e canny edge detection
 */

int main(int argc, char** argv){
    // check the arguments, the secodn should be the input image file
    if (argc != 3) {
        printf("usage: invert.exe <Image_Path> <option>\n");
        return -1;
    }
    bool edge = false;
    bool invert = false;
    std::string option(argv[2]);
    if(option.compare("-i") == 0){
        invert = true;
        cout << "Inverting Image..." << endl;
    }
    else if(option.compare("-e") == 0){
        edge = true;
        cout << "Edge Detection..." << endl;
    }
    else{
        cout << "Invalid option" << endl;
        return 0;
    }
    // print some infromation about the device and get the current device
    CheckDevice();
    
    if (invert){
         // read image
        string input_name = argv[1];
        cout << "Reading Image From File (" << input_name << ")" << endl;
        Mat image = imread(argv[1], IMREAD_COLOR);
        if (image.empty()) {
            printf("No image data \n");
            exit(EXIT_FAILURE);
        }

        const int rows = image.rows;
        const int columns = image.cols;

        cout << "Picture size: " << image.size() <<  endl;

        ImageInversion(image.data, rows, columns);

        
        char dot = '.';
        size_t pos_dot = input_name.find(dot);
        std::string ouput_name = input_name.insert(pos_dot, "_invert");

        cout << "Saved image: " << ouput_name << endl;

        imwrite(ouput_name, image);
    }
    else if (edge){
        // read image
        string input_name = argv[1];
        if(input_name.substr(input_name.find(".") + 1) != "pgm" && input_name.substr(input_name.find(".") + 1) != "ppm") {
            cout << "The input image is not .pgm or .ppm, we should convert it" << endl;
            Mat input_image = imread(input_name,IMREAD_UNCHANGED);
            Mat conv_image;
            cvtColor(input_image, conv_image,cv::COLOR_BGR2GRAY);
            vector<int> params;
            params.push_back(IMWRITE_PXM_BINARY);
            params.push_back(1);
            string sResultFilename = input_name;
            cout << sResultFilename << endl;
            size_t dot = sResultFilename.rfind('.');
            
            if (dot != 0) {
                sResultFilename = sResultFilename.substr(0, dot);
            }
            sResultFilename += ".ppm";
            cout << sResultFilename << endl;
            imwrite(sResultFilename,conv_image, params);
            EdgeDetection(sResultFilename);
        }
            EdgeDetection(argv[1]);
    }
   
    return 0;
}