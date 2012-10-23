# Copyright (C) 2012 Sochi Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

######################################################################
# Setup
######################################################################

ifeq ($(TARGET_CC),)
TARGET_CC = g++
endif

ifeq ($(TARGET_OUT),)
TARGET_OUT = out
endif

ifeq ($(TARGET_BUILD),)
TARGET_BUILD = true
endif

ifeq ($(TARGET_NAME),)
$(error TARGET_NAME must be set!)
endif

_TARGET_OBJ_DIR := obj/$(TARGET_NAME)
_CFLAGS := -c $(TARGET_CFLAGS) $(addprefix -I,$(TARGET_INCLUDE_PATH))
_LDFLAGS := $(TARGET_LDFLAGS)
_SRC := $(TARGET_SRC)
_OBJ := $(addprefix obj/$(TARGET_NAME)/,$(_SRC:.cpp=.o))
_EXT :=

ifeq ($(TARGET_TYPE),)
TARGET_TYPE := binary
endif

# Shared library
ifeq ($(TARGET_TYPE),shared_library)
_EXT := .$(SO)
_TYPE_VALID := true
_LDFLAGS := $(_LDFLAGS) -shared
endif

# Binary
ifeq ($(TARGET_TYPE),binary)
_TYPE_VALID := true
endif

_OUT_FILE := $(TARGET_OUT)/$(TARGET_NAME)$(_EXT)

######################################################################
# Targets
######################################################################

define make_target

$(_OUT_FILE): $(_OBJ)
	@echo $(TARGET_NAME): Linking target...
	@$(TARGET_CC) $(_LDFLAGS) $(_OBJ) -o $(_OUT_FILE)
	@echo $(TARGET_NAME): Build successful: $(_OUT_FILE)
$(TARGET_NAME): $(_OUT_FILE)

clean-$(_OUT_FILE):
	@$(call rm, $(_OUT_FILE))
	@$(call rm, $(_TARGET_OBJ_DIR))
	@echo $(TARGET_NAME): Cleaned.
clean-$(TARGET_NAME): clean-$(_OUT_FILE)

endef

define make_obj_target
$2: $1
	@echo $(TARGET_NAME): Target C++: $(1)
	$(call mkdir,$(dir $2))
	@$(TARGET_CC) $(_CFLAGS) $1 -o $2
endef

$(foreach src,$(_SRC), \
	$(eval $(call make_obj_target,$(src),$(addprefix $(_TARGET_OBJ_DIR)/,$(src:.cpp=.o)))) \
)
$(eval $(call make_target))

ifeq ($(TARGET_BUILD),true)
ALL_TARGETS := $(ALL_TARGETS) $(_OUT_FILE)
endif
