# Hello CUDA

본 프로젝트는 간단한 CUDA 튜토리얼을 위한 코드를 포함하고 있습니다.

# 코드

* `kernel_01()`
    - `kernel_01()`은 쿠다 커널을 C++에서 활용하는 예제 함수입니다. `.cu` 파일에 정의(+선언)언)한 커널함수를 다른 소스파일(`main.cpp`)에서 `extern`를 이용해 호출할 수 있습니다.
* `kernel_02()`
    -  `kernel_01()`은 쿠다 커널을 위해 `cudaMalloc`과 `cudaMemcpy`를 활용하는 예제 함수입니다. 호스트 및 디바이스에 메모리를 할당하고 미리 정의된 커널함수를 통해 병렬처리된 결과를 확인할 수 있습니다.
* `kernel_03()`
    - `kernel_03`은 다수의 점군 데이터로 이루어진 데이터를 쿠다 커널에 활용하는 예제 함수입니다. 세로폭(Height)가 32인 점군 데이터(x,y,z)를 입력으로, `kernel_02()` 기능을 포함한 쿠다 커널을 통한 병렬 처리 결과를 확인 할 수 있습니다. 추가로, 블럭(Block)과 스레드(Thread) 크기 선언에 관한 내용도 포함합니다.

---

#### 참고

- 예제로 배우는 CUDA 프로그래밍
- [NVIDIA Developer Blog](https://devblogs.nvidia.com/easy-introduction-cuda-c-and-c/)
- [stack overflow](https://stackoverflow.com/questions/13245258/handle-error-not-found-error-in-cuda)
