#Purpose:
Record example Jenkins project configuration.
The project is saved in .jenkins/jobs/Convert/config.xml.

#References:
http://developer.apple.com/library/mac/#documentation/AnalysisTools/Conceptual/WhatsNewInstruments/NewFeatures42/NewFeatures42.html

#Results:
Project Name: Convert  
Discard old builds: true
Max # of builds to keep: 2

Source Code Management
Git
Repository URL: ssh://git@github.com/beepscore/Convert.git

Branches to build: **

Repsitory browser (Auto)

Build
Invoke build step Xcode (requires Xcode plugin)
Xcode
Clean before build: yes
Target: <empty>
Xcode schema file (does this mean Scheme??): <empty>
SDK: <empty>
SYMROOT: <empty>
Configuration: Release
Custom xcodebuild arguments: <empty>
Xcode Workspace File: <empty>
Build output directory: ${WORKSPACE}/build
Marketing version: 0.1
Technical version: 0.1
Clean test reports? <empty>
Build IPA: true

Unlock Keychain? false (sic, seems to work without unlock. Maybe OS X supplies?)
Keychain path (default?): ${HOME}/Library/Keychains/login.keychain
Keychain password: <empty>

Execute shell 
In Jenkins, ok:
instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE}

Post-build actions
Files to archive:build/*.ipa, build/*.zip

(didn't do this yet)
Publish JUnit test result report - need a test report xml to graph.

---

23 Aug This works from command line and from Jenkins:

instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app" -e UIASCRIPT "/Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH "/Users/stevebaker/Desktop"

Alert appears:
Developer Tools Access is trying to take control of another process.
Type your password to allow this.
After typing password, terminal output shows script is running.
When script is done, simulator is still running.
Manually stop it.

---

###Appendix
TODO: Reference Convert.app built in Jenkins ${WORKSPACE}

app
ok:
"/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app"
doesn't work:
"/Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/build/Convert.app"
escaping . doesn't work:
"/Users/stevebaker/\.jenkins/jobs/ConvertAndTest2/workspace/build/Convert.app"
doesn't work:
"${WORKSPACE}/build/Convert.app"
File doesn't exist yet? Script could do ls to show if it's there.
Don't have execute permission for .jenkins??

UIASCRIPT
ok from command line:
"/Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/UIAutomationTests/convert-ui-test.js"
ok in Jenkins:
"${WORKSPACE}/UIAutomationTests/convert-ui-test.js"

UIARESULTSPATH 
ok from command line:
"/Users/stevebaker/Desktop"
ok in Jenkins:
${WORKSPACE}
Output : /Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/instrumentscli3.trace
---

In Jenkins, this didn't work:

instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "${WORKSPACE}/build/Convert.app" -e UIASCRIPT "${WORKSPACE}/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH ${WORKSPACE}

output:
+ instruments -t /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate /Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/build/Convert.app -e UIASCRIPT /Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/UIAutomationTests/convert-ui-test.js -e UIARESULTSPATH /Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace
posix spawn failure; aborting launch (binary == /Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/build/Convert.app/Convert).
2012-08-23 23:33:52.493 instruments[2129:1207] Recording cancelled : At least one target failed to launch; aborting run
Instruments Trace Error : Failed to start trace.

---

TODO:
Delete app from simulator and see if Hudson reinstalls it.
Try run in terminal from command line in simulator with app not in simulator directory.
After Hudson build, programmatically copy Convert.app into simulator directory, then run instruments?

