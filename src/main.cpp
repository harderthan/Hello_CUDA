// Harderthan, kheo1772@gmail.com
#include <iostream>

extern void kernelFunction_01(void);
extern void kernelFunction_02(void);
extern void kernelFunction_03(void);

int main() {
    kernelFunction_01();
    kernelFunction_02();
    kernelFunction_03();

    std::cout << "Hello, World!" << std::endl;
    return 0;
}
