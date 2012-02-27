//
//  convert-ui-test.js
//  Convert
//
//  Created by Steve Baker on 12/20/2011.
//  Copyright 2011 Beepscore LLC. All rights reserved.
//
//  Purpose:
//  convert-ui-test.js runs UIAutomation tests on Convert.
//  It uses library tuneup_js by Alex Vollmer
//  These tests are a way to learn and practice using UIAutomation.
//  Some may be more appropriate for unit tests than UI tests

// list global for JSLint
/*global assertEquals: false, test: false, UIALogger: false, UIATarget: false */

#import "../tuneup/tuneup.js"
// tuneup.js imports test.js, which defines method |test|.

// Global variables
UIALogger.logMessage("initializing global variables");

// Device and simulator give different results.
// To test on device, set true. To test on simulator, set false.
// Also set Xcode scheme/target to device or simulator.
var IS_TEST_RUNNING_ON_DEVICE = false;

var fromTemperatureField = UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0];
var toTemperatureField = UIATarget.localTarget().frontMostApp().mainWindow().textFields()[1];
/////////////

function testConvertViewUIElementsOnDevice(target, app) {

    // assert window has these expected elements
    // ref http://alexvollmer.com/posts/2010/10/17/assert-yourself/
    assertWindow({
                 segmentedControls: [ { name: "fromTemperatureUnitSegment" },
                                      { name: "toTemperatureUnitSegment" }
                                     ],
     /*
                 staticTexts : [ null, //{ name: "Temperature Converter" },
                                { name: "raisedTemperatureLabel" },
                                { name: "equalSign" },
                                { name: "tidbitHeader" },
                                { name: "temperatureTidbitLabel"}
                                ],
     
                 textFields: [ { name: "temperatureIn" },
                               { name: "temperatureOut" }
                              ],
     */
                 onPass: function (window) {
                 // do nothing
                 }
    });
    
    // expect label is not visible
    assertFalse(app.mainWindow().staticTexts()["raisedTemperatureLabel"].isVisible(),
               "expected raisedTemperatureLabel is not visible");
}


function testConvertViewUIElementsOnSimulator(target, app) {

    // assert window has these expected elements
    // ref http://alexvollmer.com/posts/2010/10/17/assert-yourself/
    assertWindow({
                 segmentedControls: [ { name: "fromTemperatureUnitSegment" },
                                      { name: "toTemperatureUnitSegment" }
                                     ],
                 staticTexts : [ { name: "temperatureConverter" },
                                 { name: "raisedTemperatureLabel" },
                                 { name: "equalSign" },
                                 { name: "tidbitHeader" },
                                 { name: "temperatureTidbitLabel"}
                                ],
                 textFields: [ { name: "temperatureIn" },
                               { name: "temperatureOut" }
                              ],
                 onPass: function (window) {
                     // do nothing
                 }
    });
    
    // expect label is visible but text is empty
    assertTrue(app.mainWindow().staticTexts()["raisedTemperatureLabel"].isVisible(),
                "expected raisedTemperatureLabel is visible");
}
/////////////


test("test 3 Equals 3 and fred == fred", function (target, app) {
    assertEquals(3, 3);

    var a = "fred";
    assertEquals("fred", a);
});



test("test convert view UI elements", function (target, app) {
     if (IS_TEST_RUNNING_ON_DEVICE) {
         testConvertViewUIElementsOnDevice(target, app);
     } else {
         testConvertViewUIElementsOnSimulator(target, app);
     }
});


// simulate user pressing home button to put app into background
test("test background app", function (target, app) {
     
     target.deactivateAppForDuration(1);
     app.mainWindow().segmentedControls()["fromTemperatureUnitSegment"].waitUntilVisible();
     target.delay(1);
     
     UIALogger.logMessage("asserting convert view elements");
     if (IS_TEST_RUNNING_ON_DEVICE) {
         testConvertViewUIElementsOnDevice(target, app);
     } else {
         testConvertViewUIElementsOnSimulator(target, app);
     }
     
     // wait for view to finish appearing before starting next test
     //app.mainWindow().staticTexts()["temperatureConverter"].waitUntilVisible(5);
     // delay so a human can better observe the end of the test
     target.delay(2);
});


// simulate user pressing hardware lock button
test("test lock app", function (target, app) {
     
     target.lockForDuration(5);
     
     UIALogger.logMessage("asserting convert view elements");
     if (IS_TEST_RUNNING_ON_DEVICE) {
         testConvertViewUIElementsOnDevice(target, app);
     } else {
         testConvertViewUIElementsOnSimulator(target, app);
     }
     
     // wait for view to finish appearing before starting next test
     //app.mainWindow().staticTexts()["temperatureConverter"].waitUntilVisible(10);
     // waitUntilVisible is not sufficient to give following test time to pass.
     // add delay
     target.delay(2);
});


test("testFifyNineFtoC", function (target, app) {

    app.mainWindow().segmentedControls()["fromTemperatureUnitSegment"].buttons()["°F"].vtap();
    target.delay(1);
    fromTemperatureField.vtap();
    target.delay(1);

    // can use either syntax: string then "done", or "59\n"
    //app.keyboard().typeString("59");
    //app.keyboard().elements()["done"].vtap();
    app.keyboard().typeString("59\n");
    target.delay(2);

    app.mainWindow().segmentedControls()["toTemperatureUnitSegment"].buttons()["°C"].vtap();
    target.delay(1);

    assertEquals("59", fromTemperatureField.value());
    UIALogger.logMessage("toTemperatureField.name() = " + toTemperatureField.name());
    UIALogger.logMessage("toTemperatureField.value() = " + toTemperatureField.value());

    assertEquals("15", toTemperatureField.value());
});


test("testZeroKtoC", function (target, app) {

    app.mainWindow().segmentedControls()["fromTemperatureUnitSegment"].buttons()["°K"].vtap();
    target.delay(1);
    fromTemperatureField.vtap();
    target.delay(1);

    app.keyboard().typeString("0\n");
    target.delay(2);

    app.mainWindow().segmentedControls()["toTemperatureUnitSegment"].buttons()["°C"].vtap();
    target.delay(1);

    assertEquals("0", fromTemperatureField.value());
    assertEquals("-273.15", toTemperatureField.value());
});


test("testZeroKToR", function (target, app) {

    app.mainWindow().segmentedControls()["fromTemperatureUnitSegment"].buttons()["°K"].vtap();
    target.delay(1);
    fromTemperatureField.vtap();
    target.delay(1);

    app.keyboard().typeString("0\n");
    target.delay(2);

    app.mainWindow().segmentedControls()["toTemperatureUnitSegment"].buttons()["°R"].vtap();
    target.delay(1);

    assertEquals("0", fromTemperatureField.value());
    assertEquals("0", toTemperatureField.value());
});


test("testFifteenCToF", function (target, app) {
    app.mainWindow().segmentedControls()["fromTemperatureUnitSegment"].buttons()["°C"].vtap();
    target.delay(1);
    fromTemperatureField.vtap();
    target.delay(1);

    app.keyboard().typeString("15\n");
    target.delay(2);

    app.mainWindow().segmentedControls()["toTemperatureUnitSegment"].buttons()["°F"].vtap();
    target.delay(1);

    assertEquals("15", fromTemperatureField.value());
    assertEquals("59", toTemperatureField.value());
});


test("test Temperature Tidbit label", function (target, app) {
     app.mainWindow().segmentedControls()["fromTemperatureUnitSegment"].buttons()["°C"].vtap();
     target.delay(1);
     fromTemperatureField.vtap();
     target.delay(1);
     
     app.keyboard().typeString("-18\n");
     target.delay(2);
     
     app.mainWindow().segmentedControls()["toTemperatureUnitSegment"].buttons()["°F"].vtap();
     target.delay(1);
     
     assertEquals("-18", fromTemperatureField.value());
     assertEquals("-0.4", toTemperatureField.value());
     
     // Note UIAutomation may have a bug reading UILabel?
     // If we set the accessibility name then we can't read the value?
     // value returns placeholder text. Workaround - temporarily delete placeholder text?
     // References:
     // http://stackoverflow.com/questions/8268162/getting-values-out-of-text-fields-with-uiautomation
     // http://www.youtube.com/watch?v=5SycebOn7iY
     // video 39:20
     // assertEquals("-18°C boogers freeze (estimated)", 
     //             app.mainWindow().staticTexts()["temperatureTidbitLabel"].value());
     if (IS_TEST_RUNNING_ON_DEVICE) {
         // none of these assertions pass
         // assertEquals("temperatureTidbitLabel", app.mainWindow().staticTexts()["temperatureTidbitLabel"].name());
         // assertEquals(null, app.mainWindow().staticTexts()["temperatureTidbitLabel"].name());
         // assertEquals(null, app.mainWindow().staticTexts()["temperatureTidbitLabel"].value());
     } else {
         assertEquals("temperatureTidbitLabel", 
                      app.mainWindow().staticTexts()["temperatureTidbitLabel"].name());
     }
});
