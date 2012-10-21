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

# Definitions
ifneq (SystemRoot,)
WIN32 := true
endif

# Platform specific definitions
ifeq ($(WIN32),true)
SO := dll
SLASH := \\
else
SO := so
SLASH := /
endif

# Shortcut to $(SLASH), just use $(/)
/ := $(SLASH)
slashes = $(subst /,$(/),$(1))

# Platform specific functions
ifeq ($(WIN32),true)
cp = copy $(call slashes,$(1)) $(call slashes,$(2))
mv = move $(call slashes,$(1)) $(call slashes,$(2))
rm = del $(call slashes,$(1))
mkdir = md $(call slashes,$(1))
else
cp = cp $(call slashes,$(1)) $(call slashes,$(2))
mv = mv $(call slashes,$(1)) $(call slashes,$(2))
rm = rm $(call slashes,$(1))
mkdir = mkdir -p $(call slashes,$(1))
endif
