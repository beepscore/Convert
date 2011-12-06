#import "tuneup.js"
// tuneup.js imports test.js, which defines target, application and method |test|.

// Global variables
UIALogger.logMessage("initializing global variables");

// UIAApplication class mainWindow() method
var window = application.mainWindow();

var fromTemperatureField = window.textFields()[0];
var toTemperatureLabel = window.staticTexts()[3];

// method |test| is defined in test.js
// target and application are defined in test.js

test("testShouldPass", function(target, application) {
     assertEquals(3, 3);
     
     var a = "fred";
     assertEquals("fred", a);
     });


test("testFtoC", function(target, application) {

     window.segmentedControls()["fromTemperatureUnitSegment"].buttons()["°F"].tap();
     target.delay(1);
     fromTemperatureField.tap();
     target.delay(1);
     
     //application.keyboard().typeString("59");
     //application.keyboard().elements()["done"].tap();
     application.keyboard().typeString("59\n");
     target.delay(2);
     
     window.segmentedControls()["toTemperatureUnitSegment"].buttons()["°C"].tap();
     target.delay(1);
               
     assertEquals("59", fromTemperatureField.value());
     // for a label, use name not value
     assertEquals("15", toTemperatureLabel.name());
     
     });

/*
test("testKtoC", function(target, application) {
     
     fromK.tap();
     toC.tap();
     // for a label, use name not value
     temperatureIn.tap();
     temperatureIn.setValue("0");     
     // tap titleLabel to dismiss keyboard
     titleLabel.tap();
     
     assertEquals("-273.15", temperatureOut.name());
     
     });
*/

/*
 test("ZeroKToR", function(target, application) {
 });
 
 
 test("ZeroKToC", function(target, application) {
 });
 
 
 test("FifteenCToF", function(target, application) {
 });
 */

