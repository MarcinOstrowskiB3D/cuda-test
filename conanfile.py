from conan import ConanFile
from conan.tools.cmake import CMake
from conan.tools.cmake import cmake_layout


class CudaExampleConan(ConanFile):
    name = "cuda_example"
    version = "1.0"
    settings = "os", "arch", "compiler", "build_type"
    generators = "CMakeDeps", "CMakeToolchain"
    exports_sources = "CMakeLists.txt", "main.cu", "src/*", "include/*", "tests/*"
    test_requires = "gtest/1.14.0"

    def layout(self):
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()
        cmake.test()
