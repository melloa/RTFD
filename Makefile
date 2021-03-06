GCC := g++

RM = rm -f

# Specify Caffe Installation
CaffeLocation = /opt/caffe
CaffeLIB = -L$(CaffeLocation)/build/lib
CaffeINC = -I$(CaffeLocation)/include/

# Specify opencv Installation
#opencvLocation = /usr/local/opencv
opencvLIB= -L/usr/lib
opencvINC = -I/usr/include
BlasLIB = -I/usr/local/cuda-9.0/targets/x86_64-linux/include/

NetLocation = ./net

NetLIB = -L$(NetLocation)

# g++ main.cpp queue.cpp -lpthread -lopencv_core -lopencv_imgproc -lopencv_highgui -lncurses
GccFLAGS =  -pthread -std=c++11 -O3 $(BlasLIB)
GccLibs = $(CaffeLIB) $(CaffeINC) $(NetLIB) $(opencvLIB) $(opencvINC)

GccLinkFLAGS = -lpthread -lprotobuf -lglog `pkg-config opencv --cflags --libs` -lboost_system -lcaffe-nv -lnet -lncurses

debug: GccFLAGS += -DDEBUG -g -Wall
debug: all

# Doing only one compilation, for speed purposes
Dependencies = src/pthreads.cpp src/auxiliar.cpp src/pnet_threads.cpp src/rnet_threads.cpp src/onet_threads.cpp src/data.cpp

# The build target executable
TARGET = face_detector

all: build

build: $(TARGET)

# Create executable
$(TARGET): src/main.cpp $(Dependencies) include/def.h net/libnet.so
	$(GCC) $(GccLibs) -Wl,-rpath=$(NetLocation) $< $(Dependencies) -o $@ $(GccFLAGS) $(GccLinkFLAGS)

# Create Shared library for net objects
net/libnet.so: net/bnet.o net/pnet.o net/rnet.o net/onet.o
	$(GCC) $(CaffeINC) $(GccFLAGS) -shared $< net/pnet.o net/rnet.o net/onet.o -o $@

net/bnet.o: net/bnet.cpp
	$(GCC) $(CaffeINC) $(GccFLAGS) -c -fpic $< -o $@

net/pnet.o: net/pnet.cpp
	$(GCC) $(CaffeINC) $(GccFLAGS) -c -fpic $< -o $@

net/rnet.o: net/rnet.cpp
	$(GCC) $(CaffeINC) $(GccFLAGS) -c -fpic $< -o $@

net/onet.o: net/onet.cpp
	$(GCC) $(CaffeINC) $(GccFLAGS) -c -fpic $< -o $@

clean:
	$(RM) $(TARGET) *.o net/*.so net/*.o *.tar* *.core*
