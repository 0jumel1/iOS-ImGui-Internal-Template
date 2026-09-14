TARGET := iphone:clang:latest:14.0
ARCHS = arm64
# only used by `make do` on a jailbroken device, change to the game's process name
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ImGuiMetalTweak

# git clone https://github.com/ocornut/imgui into ./imgui first
IMGUI = imgui

ImGuiMetalTweak_FILES = Tweak.xm Menu.mm \
	$(IMGUI)/imgui.cpp $(IMGUI)/imgui_draw.cpp $(IMGUI)/imgui_tables.cpp $(IMGUI)/imgui_widgets.cpp \
	$(IMGUI)/backends/imgui_impl_metal.mm
ImGuiMetalTweak_FRAMEWORKS = UIKit QuartzCore Metal MetalKit
ImGuiMetalTweak_CFLAGS = -fobjc-arc -I$(IMGUI) -I$(IMGUI)/backends
ImGuiMetalTweak_CXXFLAGS = -std=c++14

include $(THEOS_MAKE_PATH)/tweak.mk
