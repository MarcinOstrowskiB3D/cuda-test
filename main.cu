#include <cuda_runtime.h>
#include <iostream>

__global__ void addKernel(int *c, const int *a, const int *b, int size) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < size) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    constexpr int kSize = 10;
    const int bytes = kSize * sizeof(int);

    int h_a[kSize] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int h_b[kSize] = {10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
    int h_c[kSize];

    int *d_a, *d_b, *d_c;
    cudaMalloc(&d_a, bytes);
    cudaMalloc(&d_b, bytes);
    cudaMalloc(&d_c, bytes);

    cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice);

    addKernel<<<1, kSize>>>(d_c, d_a, d_b, kSize);

    cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost);

    std::cout << "Result:\n";
    for (int i = 0; i < kSize; ++i) {
        std::cout << h_c[i] << " ";
    }
    std::cout << std::endl;

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
