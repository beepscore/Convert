echo "workspace"
ls -la ${WORKSPACE}
echo "workspace/build/"
ls -la ${WORKSPACE}/build/

instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE}

