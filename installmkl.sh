#!/bin/bash

tee > /tmp/oneAPI.repo << EOF
[oneAPI]
name=Intel® oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF
source scl_source enable gcc-toolset-12
mv /tmp/oneAPI.repo /etc/yum.repos.d

#dnf install intel-oneapi-mkl -y
dnf install intel-oneapi-mkl-devel.x86_64 -y 
source scl_source enable gcc-toolset-12
. /opt/intel/oneapi/setvars.sh
cd /tmp
python -m pip install --upgrade pip
pip install virtualenv
python -m venv  build_python
. ./build_python/bin/activate
pip install --upgrade pip
mkdir /tmp/numpy
cd /tmp/numpy
NP_VERSION=1.26.2
git clone https://github.com/numpy/numpy.git
cd numpy
git checkout v${NP_VERSION}
git submodule update --init
pip install -r build_requirements.txt
#python -m build -Csetup-args=-Dblas=mkl -Csetup-args=-Dlapack=mkl -Csetup-args=-Dmkl-threading=tbb