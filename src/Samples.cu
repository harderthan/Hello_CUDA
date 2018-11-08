// Harderthan, kheo1772@gmail.com
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

static void HandleError( cudaError_t err,
                         const char *file,
                         int line ) {
    if (err != cudaSuccess) {
        printf( "%s in %s at line %d\n", cudaGetErrorString( err ),
                file, line );
        exit( EXIT_FAILURE );
    }
}
#define HANDLE_ERROR( err ) (HandleError( err, __FILE__, __LINE__ ))

// kernelFunction_01
__global__ void kernel_01(void){

}
void kernelFunction_01(void){
    kernel_01<<<1,1>>>();
}

// kernelFunction_02
__global__ void kernel_02(int a, int b, int *c){
    *c = a + b;
}
void kernelFunction_02(void){
    int c;
    int *dev_c;

    HANDLE_ERROR( cudaMalloc( (void**) &dev_c, sizeof(int) ) );

    kernel_02<<<1,1>>>(2,7,dev_c);

    HANDLE_ERROR( cudaMemcpy( &c, dev_c, sizeof(int), cudaMemcpyDeviceToHost) );
    printf( "2 + 7 = %d \n", c);
    cudaFree( dev_c );

    return;
}

// kernelFunction_03
static int POINTS_HEIGHT = 32;
static int POINTS_WIDTH = 1;
static int POINTS_NUM = POINTS_WIDTH * POINTS_HEIGHT;
static int POINTS_STEP = 3;

__global__ void kernel_03(float *src_dev_points, float *dst_dev_points, int points_num, int step_size){
	int idx = threadIdx.x + blockIdx.x * blockDim.x;
	if(idx < points_num){
		dst_dev_points[idx * step_size + 0] = src_dev_points[idx * step_size + 0] * 10;
		dst_dev_points[idx * step_size + 1] = src_dev_points[idx * step_size + 1] * 10;
		dst_dev_points[idx * step_size + 2] = src_dev_points[idx * step_size + 2] * 10;
	}
}
void kernelFunction_03(){
    float *src_points;
    float *dst_points;
    src_points = (float *) malloc(sizeof(float) * POINTS_NUM * POINTS_STEP);
    dst_points = (float *) malloc(sizeof(float) * POINTS_NUM * POINTS_STEP);

    for(int idx = 0; idx < POINTS_NUM; ++idx){
    	src_points[idx * POINTS_STEP + 0] = (float) rand();
    	src_points[idx * POINTS_STEP + 1] = (float) rand();
    	src_points[idx * POINTS_STEP + 2] = (float) rand();
    }

    {
    	    float *src_dev_points;
    	    float *dst_dev_points;
    	    HANDLE_ERROR( cudaMalloc( (void**) &src_dev_points, sizeof(float) * POINTS_NUM * POINTS_STEP ) );
    	    HANDLE_ERROR( cudaMalloc( (void**) &dst_dev_points, sizeof(float) * POINTS_NUM * POINTS_STEP ) );

    	    HANDLE_ERROR( cudaMemcpy( src_dev_points, src_points, sizeof(float) * POINTS_NUM * POINTS_STEP, cudaMemcpyHostToDevice));

    	    int thread_size = POINTS_HEIGHT;
    	    int block_size = (POINTS_HEIGHT * POINTS_WIDTH + POINTS_HEIGHT - 1 ) / POINTS_HEIGHT;
    	    kernel_03<<<block_size,thread_size>>>(src_dev_points, dst_dev_points, POINTS_NUM, POINTS_STEP);

    	    HANDLE_ERROR( cudaMemcpy( dst_points, dst_dev_points, sizeof(float) * POINTS_NUM * POINTS_STEP, cudaMemcpyDeviceToHost));

    	    for(int idx = 0; idx < POINTS_NUM; ++idx){
    	    	printf("id: %d\n", idx);
    	    	printf("%f", src_points[idx * POINTS_STEP + 0]);
    	    	printf(", %f", src_points[idx * POINTS_STEP + 1]);
    	    	printf(", %f \n", src_points[idx * POINTS_STEP + 2]);
    	        printf("%f", dst_points[idx * POINTS_STEP + 0]);
    	        printf(", %f", dst_points[idx * POINTS_STEP + 1]);
    	        printf(", %f \n", dst_points[idx * POINTS_STEP + 2]);
    	    }

    	    cudaFree( src_dev_points );
    	    cudaFree( dst_dev_points );
    }
}
