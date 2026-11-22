
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CART3R_ESP

CART3R_ESP_FILES = Tweak.x ESPOverlay.m ESPScanner.m ESPPicker.m

CART3R_ESP_CFLAGS = -fobjc-arc
CART3R_ESP_FRAMEWORKS = UIKit PhotosUI Vision

CART3R_ESP_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS_MAKE_PATH)/tweak.mk
