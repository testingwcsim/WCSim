#! /usr/bin/env sh

# Written by Benjamin Richards (b.richards@qmul.ac.uk)
#
# Continuous integration script for TraviCI build. The script is run by the .travis.yml

################################## Trick to stop build timeout ##################

#./buildextender.sh &
#PID=$!
#echo PID test $PID

#################################################################################



if [ $1 = "Setup" ]
then
echo here ben
ls /usr/include/root
ls /usr/include/TFile.h
echo `root-config --libs --cflags`	
echo Checking dependancy state `pwd`
    cd /home/travis/dependancies
    echo cd `pwd`
    if [ ! -d "./CLHEP/build" ];
    then
	rm -rf CLHEP
	git clone https://github.com/hyperk/CLHEP.git CLHEP
	cd CLHEP/
	mkdir build
	cd build
	cmake -DCMAKE_INSTALL_PREFIX= ../source/2.2.0.4/CLHEP | tee ../../../logs/CLHEP.log
	cd ../../
    fi

echo filetest
ls ./geant4.10.01.p03/build/
echo filetest 1.1
ls ./geant4.10.01.p03/
echo filetest1.2
ls ./geant4.10.01.p03/config/
echo filetest1.3
ls ./geant4.10.01.p03/config/sys/
echo filetest2
ls /usr/local/
echo filetest3
ls /usr/local/bin/
echo filetest4
ls /usr/lib/x86_64-linux-gnu/
    if [ ! -d "./geant4.10.01.p03/build" ];
    then
	rm -rf geant4.10.01.p03
	#wget http://geant4.web.cern.ch/geant4/support/source/geant4.10.01.p03.tar.gz
	wget http://geant4.cern.ch/support/source/geant4.10.01.p03.tar.gz
	tar -zxf geant4.10.01.p03.tar.gz
	cd geant4.10.01.p03
	mkdir build
	cd build
	cmake -DGEANT4_INSTALL_DATA=ON -DGEANT4_INSTALL_DATADIR=./Data -DCMAKE_INSTALL_PREFIX=./install -DCLHEP_VERSION_OK=${CLHEP_VERSION} -DCLHEP_LIBRARIES= ./lib -DCLHEP_INCLUDE_DIRS= ./include ../ | tee ../../../logs/Geant4.log
	cd ../..
    fi
    
#    if [ ! -f "./cmake-3.9.0/Makefile" ];
#    then
#	rm -rf cmake-3.9.0
#	wget https://cmake.org/files/v3.9/cmake-3.9.0.tar.gz  --no-check-certificate
#	tar zxf cmake-3.9.0.tar.gz
#	cd cmake-3.9.0/
	 #sudo apt-get purge cmake
#	cd ../
 #   fi
    
   # if [ ! -d "./root-6.10.00/Build" ];
   # then
#	rm -rf root-6.10.00
#	wget https://root.cern.ch/download/root_v6.10.00.source.tar.gz
#	tar -zxf root_v6.10.00.source.tar.gz
#	cd root-6.10.00
#	mkdir Build
#	cd Build
#	cmake ../ | tee ../../../logs/root.log
#	cmake -j8 | tee ../../../logs/root.log
#	cd ../../
#  fi
    
    
fi


if [ $1 = "CLHEP" ]
then
    echo STARTING CLHEP BUILD `pwd`
    cd /home/travis/dependancies/CLHEP/build
    make -j8 | tee ../../../logs/CLHEP.log
    #cd ../../../WCSim
fi

if [ $1 = "Geant4" ]
then
    echo STARTING Geant4 BUILD `pwd`
    cd /home/travis/dependancies/geant4.10.01.p03/build
    make -j8 | tee ../../../logs/Geant4.log
    echo file test
    ls /home/travis/dependancies/geant4.10.01.p03/bin/
    ls /home/travis/dependancies/geant4.10.01.p03/build/
    ls /home/travis/dependancies/geant4.10.01.p03/config/sys/.gmk
    ls -l /home/travis/dependancies/geant4.10.01.p03/config/sys/.gmk
    #cd ../../../WCSim
fi



if [ $1 = "cmake" ]
then
    echo STARTING cmake BUILD `pwd`
    sudo apt-get purge cmake
    cd /home/travis/dependancies/cmake-3.9.0/
    ./bootstrap | tee ../../logs/cmake.log
    make -j8 | tee ../../logs/cmake.log
    #cd ../../WCSim
fi


if [ $1 = "root1" ]
then
    echo STARTING ROOT BUILD `pwd`
#    sudo apt-get purge cmake
    cd /home/travis/dependancies/cmake-3.9.0/bin
 #   sudo make install
    export PATH=/home/travis/dependancies/cmake-3.9.0/bin:$PATH
    echo `which cmake`
    cd /home/travis/dependancies/root-6.10.00/Build
    cmake ../ | tee ../../../logs/root.log
    make -j8 | tee ../../../logs/root.log
#    make -j8 LLVMCore | tee ../../../logs/root.log
 #   make -j8 llvm-lib | tee ../../../logs/root.log
  #  make -j8 clangBasic | tee ../../../logs/root.log
  #  make -j8 clangASTMatchers | tee ../../../logs/root.log
  #  make -j8 clangLex | tee ../../../logs/root.log
  #  make -j8 clangAnalysis | tee ../../../logs/root.log
  #  make -j8 clangToolingCore | tee ../../../logs/root.log
  #  make -j8 clangTooling | tee ../../../logs/root.log
  #  make -j8 clangDriver | tee ../../../logs/root.log
  #  make -j8 clangSerialization | tee ../../../logs/root.log
  #  make -j8 clangParse | tee ../../../logs/root.log
  #  make -j8 clangIndex | tee ../../../logs/root.log
fi

if [ $1 = "root2" ]
then
    #sudo apt-get purge cmake
    cd /home/travis/dependancies/cmake-3.9.0/
    #sudo make install
    cd /home/travis/dependancies/root-6.10.00/Build
    #make -j8 clangFrontend | tee ../../../logs/root.log
    #make -j8 clangEdit | tee ../../../logs/root.log
    #make -j8 clangFormat | tee ../../../logs/root.log
    #make -j8 libclang | tee ../../../logs/root.log
    #make -j8 move_header_core_clib | tee ../../../logs/root.log
    #make -j8 MathCore | tee ../../../logs/root.log
fi

if [ $1 = "root3" ]
then
    #sudo apt-get purge cmake
    cd /home/travis/dependancies/cmake-3.9.0/
    #sudo make install
    cd /home/travis/dependancies/root-6.10.00/Build    
    #make -j8 TMVA | tee ../../../logs/root.log
fi

if [ $1 = "root4" ]
then
    #sudo apt-get purge cmake
    cd /home/travis/dependancies/cmake-3.9.0/
    #sudo make install
    cd /home/travis/dependancies/root-6.10.00/Build
    #make -j8 Core | tee ../../../logs/root.log
fi

if [ $1 = "root5" ]
then
    #sudo apt-get purge cmake
    cd /home/travis/dependancies/cmake-3.9.0/
    #sudo make install
    cd /home/travis/dependancies/root-6.10.00/Build
    #make -j8 AFTERIMAGE | tee ../../../logs/root.log
    #make -j8 Cont | tee ../../../logs/root.log
    #make -j8 TextInput | tee ../../../logs/root.log
    #make -j8 obj.clingUtils | tee ../../../logs/root.log
    #make -j8 obj.clingMetaProcessor | tee ../../../logs/root.log
    #make -j8 clangAST | tee ../../../logs/root.log
    #make -j8 obj.clingInterpreter | tee ../../../logs/root.log
    m#ake -j8 clangSema | tee ../../../logs/root.log
    #make -j8 LLVMObjCARCOpts | tee ../../../logs/root.log
    #make -j8 MetaCling | tee ../../../logs/root.log
    #make -j8 clangFrontend | tee ../../../logs/root.log
    #make -j8 clangCodeGen | tee ../../../logs/root.log
   # make -j8 GX11 | tee ../../../logs/root.log
   # make -j8 GenVector | tee ../../../logs/root.log
   # make -j8 XMLIO | tee ../../../logs/root.log
   # make -j8 Net | tee ../../../logs/root.log
   # make -j8 SQLIO | tee ../../../logs/root.log
   # make -j8 Matrix | tee ../../../logs/root.log
   # make -j8 Tree | tee ../../../logs/root.log
   # make -j8 Physics | tee ../../../logs/root.log
  #  make -j8 base | tee ../../../logs/root.log
  #  make -j8 PyROOT | tee ../../../logs/root.log
  #  make -j8 Proof | tee ../../../logs/root.log
  #  make -j8 Foam | tee ../../../logs/root.log
  #  make -j8 Spectrum | tee ../../../logs/root.log
  #  make -j8 SpectrumPainter | tee ../../../logs/root.log
fi

if [ $1 = "root6" ]
then
    sudo apt-get purge cmake
    cd /home/travis/dependancies/cmake-3.9.0/
    sudo make install
    cd /home/travis/dependancies/root-6.10.00/Build
 #   make -j8 | tee ../../../logs/root.log
fi


if [ $1 = "build" ]
then
    echo STARTING CLHEP install `pwd`
    dpkg -L root-system
    wcsim=`pwd`
    cd /home/travis/dependancies/CLHEP/
    echo `ls`
    cd /home/travis/dependancies/CLHEP/build
    sudo make install > log
    cd /home/travis/dependancies/geant4.10.01.p03/build
    echo STARTING geant install `pwd`  
    export G4INSTALL=/home/travis/dependancies/geant4.10.01.p03
    export G4SYSTEM=Linux-g++
    export G4WORKDIR=/home/travis/dependancies/geant4.10.01.p03
    sudo make install > log
    make -j8 > log
    cd  $wcsim
    echo STARTING WCSim BUILD `pwd`
    
    #  mkdir build
  #  cd build
  #  cmake ../
   #echo `root --version -q`
   echo `root-config --incdir`
   echo `root-config --libs --cflags`
   tar -xf roottest.tar
   sudo cp usr/include/root/* /usr/include/root/
   make clean
    #make shared
    make rootcint
    echo finnished root cint `pwd`
    
    make -j 8
 #   make -j8 | tee ../../../logs/root.log
fi

################################# Kill build timeout trick ######################

#kill -9 $PID

################################################################################
