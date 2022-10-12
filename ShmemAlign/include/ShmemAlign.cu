#include <assert.h>
#include <cuda_runtime.h>
#include <stdio.h>
#include "gtest/gtest.h"

__global__ void exec_kernel()
{
    __shared__ char char_ptr[16];

    extern __shared__ char char_ptr_dyn[];

    printf("\n char_ptr= %p, char_ptr+16= %p, char_ptr_dyn= %p\n",
           (void*)char_ptr,
           (void*)(char_ptr + 16),
           (void*)char_ptr_dyn);
}

TEST(Test, exe)
{
    exec_kernel<<<1, 1>>>();
    auto err = cudaDeviceSynchronize();
    EXPECT_EQ(err, cudaSuccess);
}


int main(int argc, char** argv)
{
    ::testing::InitGoogleTest(&argc, argv);

    return RUN_ALL_TESTS();
}
