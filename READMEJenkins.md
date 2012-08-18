#Purpose:
Record example Jenkins project configuration.
The project is saved in .jenkins/jobs/Convert/config.xml.

#Results:
Project Name: Convert  
Discard old builds: true
Max # of builds to keep: 2

Source Code Management
Git
Repository URL: ssh://git@github.com/beepscore/Convert.git

Branches to build: **

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
Build IPA: true

Unlock Keychain? false (sic, seems to work without unlock. Maybe OS X supplies?)
Keychain path (default?): ${HOME}/Library/Keychains/login.keychain
Keychain password: <empty>

Post-build actions
Files to archive: build/*.ipa,build/*.dSYM
