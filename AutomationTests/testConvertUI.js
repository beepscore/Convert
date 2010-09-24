#import "tuneup.js"

// method |test| is defined in test.js
test("testShouldPass", function(target, application) {
     assertEquals(3, 3);
     
     var a = "fred";
     assertEquals("fred", a);
     });


test("testFtoC", function(target, application) {

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
     

     // var fromTemperatureUnitSegment = mainWindow.segmentedControls()["fromTemperatureUnitSegment"];
     var fromTemperatureUnitSegment = mainWindow.segmentedControls()[0];
     var toTemperatureUnitSegment = mainWindow.segmentedControls()[1];
     
     // var fromK = fromTemperatureUnitSegment.buttons()["°R"].logElement();
     // var fromK = fromTemperatureUnitSegment.buttons()[3].logElement;
     // var fromK = mainWindow.buttons()[1].logElement();
     // var fromK = fromTemperatureUnitSegment.buttons().firstWithName("°K");
     var fromC = fromTemperatureUnitSegment.elements()[2];
     var fromF = fromTemperatureUnitSegment.elements()[3];
     var fromK = fromTemperatureUnitSegment.elements()[1];
     var fromR = fromTemperatureUnitSegment.elements()[0];
     
     var toC = toTemperatureUnitSegment.elements()[3];
     var toF = toTemperatureUnitSegment.elements()[2];
     var toK = toTemperatureUnitSegment.elements()[1];
     var toR = toTemperatureUnitSegment.elements()[0];
     
     fromF.tap();
     toC.tap();

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
     
     });

test("testKtoC", function(target, application) {
     
     var mainWindow = application.mainWindow();     
     var titleLabel = mainWindow.staticTexts()["Temperature Converter"];
     var temperatureIn =  mainWindow.textFields()[0];     
     var temperatureOut = mainWindow.elements()[1];
     
     // var fromTemperatureUnitSegment = mainWindow.segmentedControls()["fromTemperatureUnitSegment"];
     var fromTemperatureUnitSegment = mainWindow.segmentedControls()[0];
     var toTemperatureUnitSegment = mainWindow.segmentedControls()[1];
     
     // var fromK = fromTemperatureUnitSegment.buttons()["°R"].logElement();
     // var fromK = fromTemperatureUnitSegment.buttons()[3].logElement;
     // var fromK = mainWindow.buttons()[1].logElement();
     var fromC = fromTemperatureUnitSegment.elements()[2];
     var fromF = fromTemperatureUnitSegment.elements()[3];
     var fromK = fromTemperatureUnitSegment.elements()[1];
     var fromR = fromTemperatureUnitSegment.elements()[0];

     var toC = toTemperatureUnitSegment.elements()[3];
     var toF = toTemperatureUnitSegment.elements()[2];
     var toK = toTemperatureUnitSegment.elements()[1];
     var toR = toTemperatureUnitSegment.elements()[0];
     
     fromK.tap();
     toC.tap();
     // for a label, use name not value
     temperatureIn.tap();
     temperatureIn.setValue("0");     
     // tap titleLabel to dismiss keyboard
     titleLabel.tap();

     assertEquals("-273.15", temperatureOut.name());

     });


/*
 test("ZeroKToR", function(target, application) {
 });
 
 
 test("ZeroKToC", function(target, application) {
 });
 
 
 test("FifteenCToF", function(target, application) {
  });
 */

