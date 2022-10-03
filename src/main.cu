
#include "functions.h"

/*
 * Host main routine
 * -i invert image
 * -e canny edge detection
 */

int main(int argc, char** argv){
    // check the arguments, the first should be the input image file
    if (argc != 3) {
        printf("usage: invert.exe <Image_Path> <option>\n");
        return -1;
    }
    bool edge = false;
    bool invert = false;
    std::string option(argv[2]); // the second argument is the option
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
    // print some information about the device
    CheckDevice();
    
    if (invert){ // in case of invert, the inverted image is created on GPU
        // name of the image is the first argument
        string input_name = argv[1];
        cout << "Reading Image From File (" << input_name << ")" << endl;
        
        // check the file extension, in case of pgm, the code still does not work
        if(input_name.substr(input_name.find(".") + 1) == "pgm") {
            cout << "Sorry, but it is not implemented for this file extension";
            return 0;
        }
        // read image
        Mat image = imread(argv[1], IMREAD_COLOR); 

        if (image.empty()) {
            printf("No image data \n");
            exit(EXIT_FAILURE);
        }

        const int rows = image.rows;
        const int columns = image.cols;

        cout << "Picture size: " << image.size() <<  endl;

        // call image inversion kernel
        ImageInversion(image.data, rows, columns);

        // output filename is in same place as input and the name with _invert
        char dot = '.';
        size_t pos_dot = input_name.find(dot);
        std::string ouput_name = input_name.insert(pos_dot, "_invert");

        cout << "Saved image: " << ouput_name << endl;

        imwrite(ouput_name, image); // write image file
    }
    else if (edge){ // in case of edge, the canny edge detection is used by NPP
        // name of the image is the first argument
        string input_name = argv[1];
        // check the type of the input image, if it is not pgm, we convert a pgm from input image
        if(input_name.substr(input_name.find(".") + 1) != "pgm") {
            cout << "The input image is not .pgm, we should convert it!" << endl;

            Mat input_image = imread(input_name,0); // read image, only in the gray channel
            // compression parameters for writing binary PGM file
            vector<int> params;
            params.push_back(IMWRITE_PXM_BINARY);
            params.push_back(1);
            // set up input filename for edge detector
            string sResultFilename = input_name;
            size_t dot = sResultFilename.rfind('.');
            if (dot != 0) {
                sResultFilename = sResultFilename.substr(0, dot);
            }
            sResultFilename += ".pgm";
            imwrite(sResultFilename,input_image, params); // write pgm file

            // call canny edge detection
            EdgeDetection(sResultFilename);
        }
        // if picture is pgm, we can call canny edge detection directly
            EdgeDetection(argv[1]);
    }
    return 0;
}
