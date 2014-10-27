cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/com.mutualmobile.cordova.bluetoothle/www/bluetoothle.js",
        "id": "com.mutualmobile.cordova.bluetoothle.BluetoothLe",
        "clobbers": [
            "window.bluetoothle"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "com.mutualmobile.cordova.bluetoothle": "1.0.2"
}
// BOTTOM OF METADATA
});