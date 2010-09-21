#import "tuneup.js"

// method |test| is defined in test.js
test("simpleTest", function(target, application) {
     assertEquals(3, 3);
     });


test("easyTest", function(target, application) {

     UIALogger.logMessage("target.logElementTree()");
     target.logElementTree();
     
     // UIAApplication class mainWindow() method
     var mainWindow = application.mainWindow();
     UIALogger.logMessage("mainWindow.logElementTree()");
     mainWindow.logElementTree();

     UIALogger.logMessage("declare contentView");
     var contentView = target.elements()["contentView"];
     UIALogger.logMessage("contentView.logElementTree()");
     contentView.logElementTree();
     

     // var fromTemperatureUnitSegment = contentView.segmentedControls()["fromTemperatureUnitSegment"];
     // fromTemperatureUnitSegment.logElement();

     // fromTemperatureUnitSegment.buttons()[2].tap;
     
     // only one UITextField, same as textFields()[0] ????????????
     // var temperatureIn =  mainWindow.textFields()["temperatureIn"];
     // var temperatureIn =  mainWindow.textFields()[0];
     // var temperatureIn =  contentView.textFields()["temperatureIn"];
     var temperatureIn =  contentView.textFields()[0];
     UIALogger.logMessage("Tap temperatureIn");
     temperatureIn.tap();
     // var temperatureIn =  contentView.textFields()[0];
     // temperatureIn.logElement();
     temperatureIn.setValue("42");
     // assertEquals("42", temperatureIn.value());
     // assertTrue("42" == temperatureIn.value());
     
     });


/*
 test("ZeroKToR", function(target, application) {
 window = application.mainWindow();
 window.contentView.fromTemperatureUnitSegment.setValue("K");
 window.contentView.temperatureIn.setValue("123");
 window.contentView.toTemperatureUnitSegment.setValue("R");
 assertEquals(0, window.contentView.temperatureOut.value);
 });
 
 
 test("ZeroKToC", function(target, application) {
 window = application.mainWindow();
 window.contentView.fromTemperatureUnitSegment.setValue("K");
 window.contentView.temperatureIn.setValue("0");
 window.contentView.toTemperatureUnitSegment.setValue("C");
 assertEquals(-273.15, window.contentView.temperatureOut.value);
 });
 
 
 test("FifteenCToF", function(target, application) {
 window = application.mainWindow();
 window.contentView.fromTemperatureUnitSegment.setValue("C");
 window.contentView.temperatureIn.setValue("15");
 window.contentView.toTemperatureUnitSegment.setValue("F");
 assertEquals(59, window.contentView.temperatureOut.value);
 });
 */

