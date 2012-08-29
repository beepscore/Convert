echo "\$USER: $USER"
echo "List files to show build/Convert.app is present."
ls -la ${WORKSPACE}/build/

#Run UIAutomation from Convert.app pre-installed on simulator.
#This works, but it isn't running latest build.
instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE}
#Output:
#2012-08-28 05:28:13 +0000 Pass: test Temperature Tidbit label
#Instruments Trace Complete (Duration : 52.651230s; Output : /Users/stevebaker/.jenkins/jobs/Convert/workspace/instrumentscli2.trace)

#Run UIAutomation from new build
#This didn't work.
#instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "${WORKSPACE}/build/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE} 
#Output:
#posix spawn failure; aborting launch (binary == /Users/stevebaker/.jenkins/jobs/Convert/workspace/build/Convert.app/Convert).
#2012-08-28 22:05:09.578 instruments[2979:1207] Recording cancelled : At least one target failed to launch; aborting run
#Instruments Trace Error : Failed to start trace.

#Run UIAutomation from Convert.app on stevebaker Desktop
#This didn't work, even with unlock keychain and password.
#instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "/Users/stevebaker/Desktop/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE} 
