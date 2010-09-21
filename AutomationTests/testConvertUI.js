#import "tuneup.js"

// method |test| is defined in test.js
test("testShouldPass", function(target, application) {
     assertEquals(3, 3);
     
     var a = "fred";
     assertEquals("fred", a);
     });


test("test59FtoC", function(target, application) {

     UIALogger.logMessage("target.logElementTree()");
     target.logElementTree();
     
     // UIAApplication class mainWindow() method
     var mainWindow = application.mainWindow();
     
     // UIALogger.logMessage("declare contentView");
     // ????: In IB, I cast UIView to UIControl.  Is that confusing UIAutomation?
     // contentView is not part of the element tree
     // contentView elementTree equals UIAElementNil
     // var contentView = target.elements()["contentView"];
     
     var titleLabel = mainWindow.staticTexts()["Temperature Converter"];

     // var temperatureIn =  mainWindow.textFields()["temperatureIn"];
     // only one UITextField, it must be textFields()[0]
     var temperatureIn =  mainWindow.textFields()[0];

     // var temperatureOut = mainWindow.staticTexts()["temperatureOut"];
     // var temperatureOut = mainWindow.staticTexts()[0];
     var temperatureOut = mainWindow.elements()[1];
     UIALogger.logMessage("temperatureOut.logElement()");
     temperatureOut.logElement();
     
          
     UIALogger.logMessage("temperatureIn.tap()");
     temperatureIn.tap();
     UIALogger.logMessage("Keyboard is showing. Call target.logElementTree()");
     target.logElementTree();
     
     temperatureIn.setValue("59");
     
     // tap done key to dismiss keyboard
     // I couldn't figure out how to reference the keyboard element
     //mainWindow.keyboards()[0].keys()["done"].tap();
     //mainWindow.elements().keyboard().keys()["done"].tap();
     
     // tap titleLabel to dismiss keyboard
     titleLabel.tap();
     
     assertEquals("59", temperatureIn.value());
     // for a label, use name not value
     assertEquals("15", temperatureOut.name());
          
     var fromTemperatureUnitSegment = mainWindow.segmentedControls()["fromTemperatureUnitSegment"];
     fromTemperatureUnitSegment.logElement();
     
     //UIALogger.logMessage("fromTemperatureUnitSegment.buttons()[2].tap()");
     //fromTemperatureUnitSegment.buttons()[2].tap();
     
     
     });

test("testBlue", function(target, application) {
     
     var mainWindow = application.mainWindow();     
     var titleLabel = mainWindow.staticTexts()["Temperature Converter"];
     var temperatureIn =  mainWindow.textFields()[0];     
     var temperatureOut = mainWindow.elements()[1];

     UIALogger.logMessage("temperatureIn.tap()");
     temperatureIn.tap();
     temperatureIn.setValue("0");
     
     // tap titleLabel to dismiss keyboard
     titleLabel.tap();
     
     var fromTemperatureUnitSegment = mainWindow.segmentedControls()["fromTemperatureUnitSegment"];
     fromTemperatureUnitSegment.logElement();
     
     //UIALogger.logMessage("fromTemperatureUnitSegment.buttons()[2].tap()");
     //fromTemperatureUnitSegment.buttons()[2].tap();
     
     
     
     // for a label, use name not value
     assertEquals("-17.778", temperatureOut.name());
          
     
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

