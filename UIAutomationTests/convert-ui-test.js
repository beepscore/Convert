#import "tuneup_js/tuneup.js"
// tuneup.js imports test.js, which defines method |test|.

// Global variables
UIALogger.logMessage("initializing global variables");

var target = UIATarget.localTarget();
var application = target.frontMostApp();
// UIAApplication class mainWindow() method
var window = application.mainWindow();

var fromTemperatureField = window.textFields()[0];
var toTemperatureField = window.textFields()[1];


test("testShouldPass", function(target, application) {
     assertEquals(3, 3);
     
     var a = "fred";
     assertEquals("fred", a);
     });


test("testFifyNineFtoC", function(target, application) {
     
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
     UIALogger.logMessage("toTemperatureField.name() = " + toTemperatureField.name());
     UIALogger.logMessage("toTemperatureField.value() = " + toTemperatureField.value());

     assertEquals("15", toTemperatureField.value());
     });


test("testZeroKtoC", function(target, application) {
     
     window.segmentedControls()["fromTemperatureUnitSegment"].buttons()["°K"].tap();
     target.delay(1);
     fromTemperatureField.tap();
     target.delay(1);
     
     application.keyboard().typeString("0\n");
     target.delay(2);
     
     window.segmentedControls()["toTemperatureUnitSegment"].buttons()["°C"].tap();
     target.delay(1);
     
     assertEquals("0", fromTemperatureField.value());
     assertEquals("-273.15", toTemperatureField.value());     
     });


test("testZeroKToR", function(target, application) {
     
     window.segmentedControls()["fromTemperatureUnitSegment"].buttons()["°K"].tap();
     target.delay(1);
     fromTemperatureField.tap();
     target.delay(1);
     
     application.keyboard().typeString("0\n");
     target.delay(2);
     
     window.segmentedControls()["toTemperatureUnitSegment"].buttons()["°R"].tap();
     target.delay(1);
     
     assertEquals("0", fromTemperatureField.value());
     assertEquals("0", toTemperatureField.value());      
     });


test("testFifteenCToF", function(target, application) {
     window.segmentedControls()["fromTemperatureUnitSegment"].buttons()["°C"].tap();
     target.delay(1);
     fromTemperatureField.tap();
     target.delay(1);
     
     application.keyboard().typeString("15\n");
     target.delay(2);
     
     window.segmentedControls()["toTemperatureUnitSegment"].buttons()["°F"].tap();
     target.delay(1);
     
     assertEquals("15", fromTemperatureField.value());
     assertEquals("59", toTemperatureField.value());     
     });
