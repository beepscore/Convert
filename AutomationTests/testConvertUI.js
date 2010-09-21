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

     // UIALogger.logMessage("declare contentView");
     // ????: In IB, I cast UIView to UIControl.  Is that confusing UIAutomation?
     // contentView is not part of the element tree
     // contentView elementTree equals UIAElementNil
     // var contentView = target.elements()["contentView"];

     var fromTemperatureUnitSegment = mainWindow.segmentedControls()["fromTemperatureUnitSegment"];
     fromTemperatureUnitSegment.logElement();

     UIALogger.logMessage("fromTemperatureUnitSegment.buttons()[2].tap");
     fromTemperatureUnitSegment.buttons()[2].tap;
     
     // only one UITextField, same as textFields()[0]
     // var temperatureIn =  mainWindow.textFields()["temperatureIn"];
     var temperatureIn =  mainWindow.textFields()[0];
    
     UIALogger.logMessage("temperatureIn.tap()");
     temperatureIn.tap();
     temperatureIn.setValue("15");
     assertEquals("15", temperatureIn.value());
     
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

