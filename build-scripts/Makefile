BUILD_ARCHIVE_NAME="xCCGServer"
BUILD_PARALLEL_THREADS=12
SERVER_FOLDER=${BUILD_ARCHIVE_NAME}

INSTALL_FOLDER=/usr/local/xccg

CEF3=cef_binary_3.2987.1597.gffc5773_linux64
#03/28/2017
#CEF3=cef_binary_3.2987.1592.gfbafd4e_linux64 #03/17/2017
#CEF3=cef_binary_3.2785.1485.g2b5c3a7_linux64 #10/12/2016
#CEF3=cef_binary_3.2883.1542.gf264ab9_linux64 #01/11/2017

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
	cp -R ../dependencies64/cef3/$(CEF3)/Resources/* $(SERVER_FOLDER)/bin/
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
	@cd ../dependencies64/cef3/ && tar -xvf $(CEF3).tar.bz2 && $(call ok_msg,"cef3 downloaded ok")
	@test -d ../dependencies64/cef3/$(CEF3)/build && rm -Rf ../dependencies64/cef3/$(CEF3)/build/ || $(call ok_msg,"cef3 ready to build")
	@cd ../dependencies64/cef3/$(CEF3) && mkdir build
	@cd ../dependencies64/cef3/$(CEF3)/build && cmake .. && make -j6 libcef_dll_wrapper && $(call ok_msg,"cef3 libcef_dll_wrapper compiled ok")
	@test -d ../dependencies64/cef/lib/linux/ || mkdir -p ../dependencies64/cef/lib/linux/
	@test -d ../dependencies64/cef/bin/linux/ || mkdir -p ../dependencies64/cef/bin/linux/
	@test -d ../dependencies64/cef/include/ || mkdir -p ../dependencies64/cef/include/
	@test -d ../dependencies64/cef/bin/linux/locales/ || mkdir -p ../dependencies64/cef/bin/linux/locales/
	@test -d ../dependencies64/cef/lib/linux/libcef_dll_wrapper/ || mkdir -p ../dependencies64/cef/lib/linux/libcef_dll_wrapper/
	cp ../dependencies64/cef3/$(CEF3)/Release/* ../dependencies64/cef/bin/linux/
	cp -R ../dependencies64/cef3/$(CEF3)/Resources/locales/* ../dependencies64/cef/bin/linux/locales/
	cp -R ../dependencies64/cef3/$(CEF3)/Resources/*.pak ../dependencies64/cef/bin/linux/
	cp -R ../dependencies64/cef3/$(CEF3)/include/* ../dependencies64/cef/include/
	cp ../dependencies64/cef3/$(CEF3)/Release/libcef.so ../dependencies64/cef/lib/linux/
	cp ../dependencies64/cef3/$(CEF3)/Release/libcef.so ../dependencies64/cef/bin/linux/
	cp -R ../dependencies64/cef3/$(CEF3)/build/libcef_dll_wrapper/* ../dependencies64/cef/lib/linux/libcef_dll_wrapper/
	mv ../dependencies64/cef/lib/linux/libcef_dll_wrapper/libcef_dll_wrapper.a ../dependencies64/cef/lib/linux/

deps: cef3
	#http://opensource.spotify.com/cefbuilds/cef_binary_3.2987.1592.gfbafd4e_linux64.tar.bz2
	#@cd ../dependencies64 && tar xvJf large_files_linux.tar.xz && $(call ok_msg,"deployed ..//dependencies64/cef/bin/linux/libcef.so") || $(call failed_msg,"could not unpack large_files_linux.tar.xz")
	@cd ../dependencies64 && rm -f ./libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb && wget https://launchpad.net/ubuntu/+archive/primary/+files/libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb && sudo dpkg -i ./libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb

clean:
	@rm -Rf ../build && $(call ok_msg,"cleaned ../build folder")
	@rm -Rf ../dependencies64/cef3/* && $(call ok_msg,"cleaned cef3 dependency folder")

install:
	#@test -d /etc/init.d/ && cp ../build/xCCGServer/xccg /etc/init.d/ || $(call failed_msg,"Could not install xccg script in /etc/init.d/")
	#@chmod 755 /etc/init.d/xccg
	@test -d /usr/local/xccg && $(call ok_msg,"[/usr/local/xccg] already exists") || mkdir /usr/local/xccg
	@sudo cp ../deploy/linux/xorg_conf_10-nvidia.tpl /usr/local/xccg/xorg_conf_10-nvidia.template
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
	@sudo apt-get install -y gcc
	@sudo apt-get install -y make
	@sudo apt-get install -y cmake
	@sudo apt-get install -y build-essential
	@sudo apt-get install -y libxrandr-dev libjpeg-dev libsndfile1-dev libudev-dev libglu1-mesa-dev
	@sudo apt-get install -y libjpeg-dev libpng-dev libxrandr-dev libxcb-xfixes0-dev libv4l-dev libgtk2.0-0 libxtst6 libnss3 libgconf-2-4 libasound2 libcgmanager0 libraw1394-dev libavc1394-dev libiec61883-dev libxss1
	@sudo apt-get install -y gnome-themes-standard

