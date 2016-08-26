#!/bin/bash
# add next line to new run script in XCode Build Phase before compile source
#
# cd $SRCROOT/Scripts && ./script_manager.sh
#
# and add Resource folder to Library as file referrence
# Get base path to project
BASE_PATH="$PROJECT_DIR"
# RESOURCE_BUILDER
RESOURCE_BUILDER="$BASE_PATH/Scripts/resource_builder.swift"
RESOURCE_PATH="$BASE_PATH/Resource"
RESOURCE_OUTPUT_PATH="$BASE_PATH/Source/Resource.swift"
chmod 755 "$RESOURCE_BUILDER"
# set -x
# 执行文件            资源目录          输出文件
"$RESOURCE_BUILDER" "$RESOURCE_PATH" "$RESOURCE_OUTPUT_PATH"
