Converter is an iPhone temperature converter application.

The project has 2 targets
  Convert- main target for the app
  LogicTests - logic unit tests, runs only in simulator

LogicTests can be set to the active target and run independently.
However running the test target independently requires remembering to manually run the tests!

To run the tests automatically, one target can be specified as a direct dependency of the other target.

In "Automated Unit Testing with Xcode 3 and Objective-C", Apple recommends add the application target (e.g. Convert) as a direct dependency of the LogicTests target.
This way, when the app is released it won't contain the testing code.
During development, you usually have the active target set to LogicTests.  This runs the app and runs your tests.

The logic tests only run when building the app for the simulator.
When building the app for the device, the logic tests don't run.

In Xcode Groups & Files/Classes, find the Converter.m file.
Hold Option key and drag Converter.m file to Groups & Files/Targets/LogicTests/Compile Sources
This puts a reference to the Converter.m file in both folders.  Both references point to the same project file.

References:
iPhone Development Guide- Unit Testing Applications
http://developer.apple.com/iphone/library/documentation/xcode/conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

Automated Unit Testing with Xcode 3 and Objective-C
http://developer.apple.com/mac/articles/tools/unittestingwithxcode3.html

sample app: Apple iPhoneUnitTests

iPhone Unit Testing
http://stackoverflow.com/questions/2973167/iphone-unit-testing

OCUnit: Integrated Unit Testing In Xcode
http://www.mobileorchard.com/ocunit-integrated-unit-testing-in-xcode/
