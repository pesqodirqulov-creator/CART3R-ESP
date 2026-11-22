ARCHS = arm64
TARGET = iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CART3R

CART3R_FILES = ESPScanner.m \
               ESPOverlay.m \
               ESPController.m

CART3R_FRAMEWORKS = UIKit Foundation Vision

include $(THEOS_MAKE_PATH)/tweak.mk
