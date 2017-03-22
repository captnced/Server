BUILD_ARCHIVE_NAME="xCCGServer"
BUILD_PARALLEL_THREADS=12
SERVER_FOLDER=${BUILD_ARCHIVE_NAME}

INSTALL_FOLDER=/usr/local/xccg

CEF3=cef_binary_3.2987.1592.gfbafd4e_linux64

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
	test -f Makefile && $(call ok_msg,"Makefile already ready") || cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo .. || $(call failed_msg,"cmake failed")
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
	cp -Rf ../deploy/general/wallpapers $(SERVER_FOLDER)/; \
	cp -Rf ../deploy/general/server/media $(SERVER_FOLDER)/; \
	cp -Rf ../deploy/general/server/template $(SERVER_FOLDER)/; \
	cp -Rf ../deploy/general/server/font $(SERVER_FOLDER)/ || $(call failed_msg,"Could not dependencies")

cef3:
	@test -d ../dependencies64/cef3 && $(call ok_msg,"[cef3] folder already exists") || mkdir ../dependencies64/cef3
	@test -f ../dependencies64/cef3/$(CEF3).tar.bz2 && $(call ok_msg,"cef3 targz file already downloaded") || `cd ../dependencies64/cef3 && wget http://opensource.spotify.com/cefbuilds/$(CEF3).tar.bz2`
	@cd ../dependencies64/cef3/ && tar -xvf $(CEF3).tar.bz2
	@cd ../dependencies64/cef3/$(CEF3)



deps:
	#http://opensource.spotify.com/cefbuilds/cef_binary_3.2987.1592.gfbafd4e_linux64.tar.bz2
	@cd ../dependencies64 && tar xvJf large_files_linux.tar.xz && $(call ok_msg,"deployed ..//dependencies64/cef/bin/linux/libcef.so") || $(call failed_msg,"could not unpack large_files_linux.tar.xz")
	@cd ../dependencies64 && rm -f ./libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb && wget https://launchpad.net/ubuntu/+archive/primary/+files/libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb && sudo dpkg -i ./libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb

clean:
	@rm -Rf ../build && $(call ok_msg,"cleaned ../build folder")

install:
	@test -d /etc/init.d/ && cp ../build/xCCGServer/xccg /etc/init.d/ || $(call failed_msg,"Could not install xccg script in /etc/init.d/")
	@chmod 755 /etc/init.d/xccg
	@test -d /etc/init.d/ && $(call ok_msg,"[/usr/local/xccg] already exists") || mkdir /usr/local/xccg
	@sudo cp ../deploy/linux/xorg_conf_10-nvidia.template /usr/local/xccg/xorg_conf_10-nvidia.template
	@test -d $(INSTALL_FOLDER)/server/ && $(call ok_msg,"[$(INSTALL_FOLDER)/server/] already exists") || mkdir -p $(INSTALL_FOLDER)/server/
	@cd ../build; \
	cp -Rf $(SERVER_FOLDER)/* $(INSTALL_FOLDER)/server/ || $(call failed_msg,"Could not install xccg server in $(INSTALL_FOLDER)/server/")
	@$(call ok_msg,"To start xccg manually :: /etc/init.d/xccg start")
	@$(call ok_msg,"To install in boot sequence :: update-rc.d xccg defaults")

pull:
	@cd ../ && git pull
	@$(call ok_msg,"git pull")

init:
	@sudo apt-get update
	@sudo apt-get install gcc
	@sudo apt-get install make
	@sudo apt-get install cmake
	@sudo apt-get install build-essential
	@sudo apt-get install libxrandr-dev libjpeg-dev libsndfile1-dev libudev-dev libglu1-mesa-dev
	@sudo apt-get install libjpeg-dev libpng-dev libxrandr-dev libxcb-xfixes0-dev libv4l-dev libgtk2.0-0 libxtst6 libnss3 libgconf-2-4 libasound2 libcgmanager0 libraw1394-dev libavc1394-dev libiec61883-dev libxss1

