#import "tuneup.js"


test("simpleTest", function(target, application) {
     window = application.mainWindow();
     assertEquals(3, 3);
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

