#ifndef __GETDEVICE__
#define __GETDEVICE__

__host__ void CheckDevice(){
  
  int nDevices;

  cudaGetDeviceCount(&nDevices);
  printf("Number of GPU Devices: %d\n", nDevices);

  for (int i = 0; i < nDevices; i++) {
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, i);
    printf("  Device Number: %d\n", i);
    printf("  Device name: %s\n", prop.name);
    printf("  Max Thread Dimensions: [%d][%d][%d]\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
    printf("  Max Threads Per Block: %d\n", prop.maxThreadsPerBlock);
    printf("  Number of Multiprocessors: %d\n", prop.multiProcessorCount);
    printf("  Device Clock Rate (KHz): %d\n", prop.clockRate);
    printf("  Registers Per Block: %d\n", prop.regsPerBlock);
    printf("  Registers Per Multiprocessor: %d\n", prop.regsPerMultiprocessor);
    printf("  Shared Memory Per Block: %zu\n", prop.sharedMemPerBlock);
    printf("  Shared Memory Per Multiprocessor: %zu\n", prop.sharedMemPerMultiprocessor);
    printf("  Total Constant Memory (bytes): %zu\n", prop.totalConstMem);
    printf("  Total Global Memory (bytes): %zu\n", prop.totalGlobalMem);
    printf("  Warp Size: %d\n\n", prop.warpSize);
    
  }
}

#endif