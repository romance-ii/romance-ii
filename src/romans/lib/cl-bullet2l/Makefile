all: bullet.lisp libcl-bullet2l.so

clean:	
	rm -f $(shell cat .gitignore)
	$(MAKE) -C ../bullet2 clean

bullet.lisp: $(shell find ../bullet2/ -name \*.h) cl-bullet2l.i
	swig -c++ -Wall \
		-I../bullet2/ld/include/bullet -I../bullet2/src \
		-outcurrentdir \
		-v -cffi cl-bullet2l.i

../bullet2/configure:	../bullet2/autogen.sh
	cd ../bullet2; ./autogen.sh

../bullet2/Makefile:	../bullet2/configure
	cd ../bullet2; ./configure --prefix=$(pwd)/ld

../bullet2/ld/lib/libBulletCollision.a: ../bullet2/Makefile
	$(MAKE) -C ../bullet2
	$(MAKE) -C ../bullet2 install

cl-bullet2l_wrap.cxx: ../bullet2/ld/lib/libBulletCollision.a \
	../bullet2/ld/lib/libBulletDynamics.a \
	cl-bullet2l.i
	swig -c++ -Wall \
		-I../bullet2/ld/include/bullet -I../bullet2/src \
		-outcurrentdir \
		-v -cffi cl-bullet2l.i

CXXFLAGS += -I ../bullet2/ld/include/bullet
CXXFLAGS += -I ../bullet2/src
CXXFLAGS += -l ../bullet2/ld/lib
CXXFLAGS += -fPIC

libcl-bullet2l.so:	cl-bullet2l_wrap.o	\
	../bullet2/ld/lib/libLinearMath.so	\
	../bullet2/ld/lib/libBulletCollision.so	\
	../bullet2/ld/lib/libBulletDynamics.so	\
	../bullet2/ld/lib/libBulletSoftBody.so
	cp -f	../bullet2/ld/lib/libLinearMath.so	\
		../bullet2/ld/lib/libBulletCollision.so	\
		../bullet2/ld/lib/libBulletDynamics.so	\
		../bullet2/ld/lib/libBulletSoftBody.so	.
	$(CXX) -shared \
		cl-bullet2l_wrap.o \
		-o $@

cl-bullet2l_wrap.o:	cl-bullet2l_wrap.cxx
	$(CXX) $(CXXFLAGS) -c $^ -o $@

