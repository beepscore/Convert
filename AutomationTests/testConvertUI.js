#import "tuneup.js"

test("InputZeroK", function(target, application) {
// exercise and validate your application.
     window = application.mainWindow();
     window.contentView.fromTemperatureUnitSegment.setValue("K");
     window.contentView.temperatureIn.setValue("0");
     window.contentView.toTemperatureUnitSegment.setValue("C");
     // test this should fail
     assertEquals(270, window.contentView.temperatureOut.value);
});
