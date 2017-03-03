BUILD_ARCHIVE_NAME="xCCGServer"
BUILD_PARALLEL_THREADS=12
SERVER_FOLDER=${BUILD_ARCHIVE_NAME}

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
exit 0
endef


all:
	@test -d ../build && $(call ok_msg,"[build] folder already exists")|| mkdir ../build
	@$(call ok_msg,"now building from [build] folder...")
	@cd ../build; \
	cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo .. || $(call failed_msg,"cmake failed")
	@cd ../build; \
	/usr/bin/time -f 'Build time %E' make -j$(BUILD_PARALLEL_THREADS) || $(call failed_msg,"make failed")
	@cd ../build; \
    test -d $(SERVER_FOLDER) && $(call ok_msg,"[$(SERVER_FOLDER)] folder already exists") || mkdir $(SERVER_FOLDER); \
	test -d $(SERVER_FOLDER)/bin && $(call ok_msg,"[$(SERVER_FOLDER)/bin] folder already exists") || mkdir $(SERVER_FOLDER)/bin; \
	test -d $(SERVER_FOLDER)/lib && $(call ok_msg,"[$(SERVER_FOLDER)/lib] folder already exists") || mkdir $(SERVER_FOLDER)/lib
    # Copy compiled binaries
	@cd ../build; \
	cp -f  shell/lib* $(SERVER_FOLDER)/lib/; \
	cp -f  shell/*.ttf $(SERVER_FOLDER)/; \
	cp -f  shell/casparcg $(SERVER_FOLDER)/bin/; \
	cp -f  shell/casparcg.config $(SERVER_FOLDER)/; \
	cp -Rf shell/locales $(SERVER_FOLDER)/bin/; \
	cp -f  shell/*.pak $(SERVER_FOLDER)/ || $(call failed_msg,"Could not copy compiled binary resources")
    # Copy binary dependencies
	@cd ../build; \
	cp -Rf ../deploy/linux/* $(SERVER_FOLDER)/; \
	cp -f  ../deploy/general/*.pdf $(SERVER_FOLDER)/; \
	cp -Rf ../deploy/general/wallpapers $(SERVER_FOLDER)/; \
	cp -Rf ../deploy/general/server/media $(SERVER_FOLDER)/; \
	cp -Rf ../deploy/general/server/template $(SERVER_FOLDER)/; \
	cp -Rf ../deploy/general/server/font $(SERVER_FOLDER)/ || $(call failed_msg,"Could not dependencies")

deps:
	@cd ../dependencies64 && tar xvJf large_files_linux.tar.xz && $(call ok_msg,"deployed ..//dependencies64/cef/bin/linux/libcef.so")|| $(call failed_msg,"could not unpack large_files_linux.tar.xz")

clean:
	@rm -Rf ../build && $(call ok_msg,"cleaned ../build folder")

install:
	@test -d /etc/init.d/ && cp ..//build/xCCGServer/xccg /etc/init.d/ || $(call failed_msg,"Could not install xccg script in /etc/init.d/")
	@update-rc.d xccg defaults || $(call failed_msg,"Could not install /etc/init.d/xccg in boot sequence")

