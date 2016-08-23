#!/bin/bash -l
xcodebuild -workspace RuntimeTest.xcworkspace -scheme RuntimeTest archive -archivePath ./build/RuntimeTest.xcarchive && \
rm -rf ./build/RuntimeTest.ipa && \
xcodebuild -exportArchive -exportFormat ipa -archivePath build/RuntimeTest.xcarchive -exportPath build/RuntimeTest.ipa && \
fir p build/RuntimeTest.ipa -T b668e48c86ec4baf052b4a37899f4eb2
