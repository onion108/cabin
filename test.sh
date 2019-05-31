#!/bin/bash

ROOT_DIR=$PWD

pushd ./test/poac


pushd ./core/deper
g++ -std=c++1z -I${ROOT_DIR}/include -I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib -lboost_unit_test_framework -lboost_filesystem -lssl -lcrypto -ldl -lyaml-cpp -fprofile-arcs -ftest-coverage -DPOAC_VERSION=\"0.2.0\" -DPOAC_PROJECT_ROOT=\"${ROOT_DIR}\" -o resolver-test resolver.cpp
./resolver-test
g++ -std=c++1z -I${ROOT_DIR}/include -lboost_unit_test_framework -fprofile-arcs -ftest-coverage -o sat-test sat.cpp
./sat-test
g++ -std=c++1z -I${ROOT_DIR}/include -lboost_unit_test_framework -fprofile-arcs -ftest-coverage -o semver-test semver.cpp
./semver-test
popd

#pushd ./core/stroite/field
#g++ -std=c++1z -I${ROOT_DIR}/include -lboost_unit_test_framework -fprofile-arcs -ftest-coverage -o standard-test standard.cpp
#./standard-test
#popd

pushd ./core
g++ -std=c++1z -I${ROOT_DIR}/include -lboost_unit_test_framework -fprofile-arcs -ftest-coverage -o exception-test except.cpp
./exception-test
g++ -std=c++1z -I${ROOT_DIR}/include -I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib -lboost_unit_test_framework -lboost_filesystem -lssl -lcrypto -ldl -lyaml-cpp -fprofile-arcs -ftest-coverage -DPOAC_VERSION=\"0.2.0\" -DPOAC_PROJECT_ROOT=\"${ROOT_DIR}\" -o infer-test infer.cpp
./infer-test
g++ -std=c++1z -I${ROOT_DIR}/include -lboost_unit_test_framework -lboost_filesystem -lyaml-cpp -fprofile-arcs -ftest-coverage -o naming-test naming.cpp
./naming-test
popd

pushd ./util
g++ -std=c++1z -I${ROOT_DIR}/include -lboost_unit_test_framework -fprofile-arcs -ftest-coverage -o pretty-test pretty.cpp
./pretty-test
popd


popd

# Run gcov and upload report to coveralls
coveralls --exclude build --gcov-options '\-lp' -t ${COVERALLS_TOKEN}
bash <(curl -s https://codecov.io/bash)
