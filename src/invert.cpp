#ifndef __INVERT__
#define __INVERT__

__global__ void kernel(unsigned char* image){

    int threadId = (blockIdx.x + blockIdx.y * gridDim.x) * 3;

   for (int i = 0; i < 3; i++) // loop for BGR channels
    {
        image[threadId + i] = 255 - image[threadId + i];
    }
}

__host__ void ImageInversion(unsigned char * h_image, int rows, int columns){

    cudaError_t err = cudaSuccess;
    unsigned char *d_image = NULL;
    err = cudaMalloc((void**)&d_image, rows*columns*3);
    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device image (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaMemcpy(d_image, h_image, rows*columns*3,cudaMemcpyHostToDevice);
    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy image from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }


    dim3 blocksPerGrid(rows,columns);
    printf("CUDA kernel launch \n");
    cudaEvent_t start, stop;
    float elapsedTime;

    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    kernel<<<blocksPerGrid, 1>>>(d_image);

    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);

    cudaEventElapsedTime(&elapsedTime, start, stop);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    printf("The kernel execution time: %f millisec\n", elapsedTime);

    printf("Copy output data from the CUDA device to the host memory\n");
    err = cudaMemcpy(h_image, d_image, rows*columns*3,cudaMemcpyDeviceToHost);
    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy image from device to host (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    cudaFree(d_image);
}

#endif
