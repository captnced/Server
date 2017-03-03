BUILD_ARCHIVE_NAME="xCCGServer"
BUILD_PARALLEL_THREADS=12

RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"
POS="\\033[60G"

define ok_msg
echo "${1}${POS}${BLACK}[${GREEN}  OK  ${BLACK}]"
endef

define failed_msg
echo "${1}${POS}${BLACK}[${RED}FAILED${BLACK}]"
endef


all:
	@mkdir ../build && cd ../build
	@cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo .. || $(call failed_msg,"cmake failed")
	@/usr/bin/time -f 'Build time %E' make -j${BUILD_PARALLEL_THREADS} || $(call failed_msg,"make failed")

deps:
	@cd ../dependencies64 && tar xvJf large_files_linux.tar.xz && $(call ok_msg,"deployed ..//dependencies64/cef/bin/linux/libcef.so")|| $(call failed_msg,"could not unpack large_files_linux.tar.xz")

clean:
	@rm -Rf ../build && $(call ok_msg,"cleaned ../build folder")

