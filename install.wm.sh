sudo dnf update
sudo dnf install wireguard-tools libfuse-devel

# compile wlroots

sudo dnf install
	libinput-devel \
	libxkbcommon-devel \
	wlroots-devel \
	wayland-protocols-devel \
	libxcb-devel \
	xcb-util-wm-devel \
	xcb-util-renderutil-devel \
	xcb-util-errors-devel \
	libdrm-devel \
	libglvnd-devel \
	mesa-libgbm-devel \
	vulkan-loader-devel \
	vulkan-headers \
	glslang-devel  \
	spirv-headers-devel \
	spirv-tools \
	mesa-vulkan-drivers \
	libseat-devel \
	pixman-devel \
	hwdata-devel \
	libdisplay-info-devel \
	libliftoff-devel \
	xorg-x11-server-Xwayland-devel \
	colord colord-libs \
	lcms2-devel \
	icc-profiles-openicc \
	make git meson clang

git clone https://gitlab.freedesktop.org/wlroots/wlroots.git wlroots

cd wlroots
meson setup build/
ninja -C build/
sudo ninja -C build/ install
# /usr/local/lib64 not included in default ldconfig path for fear
# of conflicts with system packages, therefore symlink is necessary
ln -s /usr/local/lib64/libwlroots-0.19.so /lib64/libwlroots-0.19.so
cd ..

# compile dwl

git clone https://github.com/LQR471814/dwl.git dwl

cd dwl
make
sudo make install
cd ..

