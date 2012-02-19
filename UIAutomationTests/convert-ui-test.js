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

#import "tuneup_js/tuneup.js"
// tuneup.js imports test.js, which defines method |test|.

// Global variables
UIALogger.logMessage("initializing global variables");

var fromTemperatureField = UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0];
var toTemperatureField = UIATarget.localTarget().frontMostApp().mainWindow().textFields()[1];
/////////////

test("testShouldPass", function (target, app) {
    assertEquals(3, 3);

    var a = "fred";
    assertEquals("fred", a);
});


test("test expected UI elements", function (target, app) {
     
     // assert window has these expected elements
     // ref http://alexvollmer.com/posts/2010/10/17/assert-yourself/
     assertWindow({
                  segmentedControls: [ { name: "fromTemperatureUnitSegment" },
                                      { name: "toTemperatureUnitSegment" }
                                      ],
                  
                  onPass: function (window) {
                  // do nothing
                  }
    });
});


test("test background app", function (target, app) {
     
     target.deactivateAppForDuration(5);
     
     UIALogger.logMessage("asserting window elements");
     assertWindow({
                  segmentedControls: [ { name: "fromTemperatureUnitSegment" },
                                      { name: "toTemperatureUnitSegment" }
                                      ],
                  
                  onPass: function (window) {
                  // do nothing
                  }
    });
});


test("testFifyNineFtoC", function (target, app) {

    app.mainWindow().segmentedControls()["fromTemperatureUnitSegment"].buttons()["°F"].vtap();
    target.delay(1);
    fromTemperatureField.vtap();
    target.delay(1);

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
