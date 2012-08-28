echo "List files to show build/Convert.app is present."
ls -la ${WORKSPACE}/build/

#If Convert.app is pre-installed on simulator, Jenkins UIAutomation runs it.
#instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE}
#output:
#2012-08-28 05:28:13 +0000 Pass: test Temperature Tidbit label
#Instruments Trace Complete (Duration : 52.651230s; Output : /Users/stevebaker/.jenkins/jobs/Convert/workspace/instrumentscli2.trace)

#Run UIAutomation from new build
instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "${WORKSPACE}/build/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE} 

