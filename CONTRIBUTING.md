The app in the src/ (BluetoothLeTests) directory is a test runner. Running it
from xcode or eclipse will immediately start the tests (in the test/ directory)
on an iOS/Android device and keep re-running the suite until a test fails.


Dependencies
------------

All dependencies are pulled from Node.js' Node Package Manager. This requires
that you have Node.js installed:

`$ brew install node`

From the project root, the rest of the dependencies can be pulled with (from
the project root):

`$ npm install`


Hacking
-------

### Native Workflow

When consumers install this plugin, files will be installed into the following
directories:

* Android: platforms/android/src/com/mutualmobile/cordova/bluetoothle/
* iOS: platforms/ios/<TheirProjectName>/Plugins/com.mutualmobile.cordova.bluetoothle/

When hacking on this project, mentally replace "platforms/" above with "src/"
and you'll find the relevant plugin files there. Each platform contains the
appropriate IDE project file for native work. You can run the app (which runs
the unit tests) from your IDE, but you need to run a few shell scripts first:

sh```
./_make/server
./_make/simulator
```

What the above scripts do:

#### ./\_make/server

Configures the main (UI)WebView inside the app to load the unit tests from a
server running on your current machine, then launches the server (python's
SimpleHTTPServer).

#### ./\_make/simulator

Provides a GATT server implementation to test this plugin against. Runs on OS X
and Linux (requires a Bluetooth adapter).


### Web Workflow

The src/android and src/ios projects both symlink to src/www, so you should
hack on src/www/bluetoothle.js. Then it's the same steps as the native workflow
above, *but make sure to run ./_make/server before deploying the app*. This is
because that script modifies the Cordova config.xml to point the app to the
HTTP server running on your machine (so you can reload from DevTools). That
makes your steps:

sh```
./_make/server
./_make/simulator
(launch the app from an IDE)
(hack on src/www/bluetoothle.js)
(open DevTools, refresh)
(hack, refresh, repeat)
```
