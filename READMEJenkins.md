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

21 Aug
Execute shell - this command didn't work
instruments -t /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate ${WORKSPACE}/build/Convert.app -e UIASCRIPT ${WORKSPACE}/UIAutomationTests/convert-ui-test.js -e UIARESULTSPATH ${WORKSPACE}

Post-build actions
Files to archive:build/*.ipa, build/*.zip

(didn't do this yet)
Publish JUnit test result report - need a test report xml to graph.

---

23 Aug This works from command line and from Jenkins

instruments -t "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app" -e UIASCRIPT "/Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/UIAutomationTests/convert-ui-test.js" -e UIARESULTSPATH "/Users/stevebaker/Desktop"

TODO: Work towards arguments that reference Jenkins ${WORKSPACE}

tracetemplate
ok:
"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate"

app
ok:
"/Users/stevebaker/xcode-build/Convert-cirgdecbzxoiobfeqabnkpoqfxnn/Build/Products/Release-iphonesimulator/Convert.app"
does this work??
/Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/build/Convert.app

doesn't work??- need to escape "."? Don't have execute permission for .jenkins??
"/Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/build/Convert.app"

UIASCRIPT
ok:
"/Users/stevebaker/.jenkins/jobs/ConvertAndTest2/workspace/UIAutomationTests/convert-ui-test.js"

UIARESULTSPATH 
ok:
"/Users/stevebaker/Desktop"

