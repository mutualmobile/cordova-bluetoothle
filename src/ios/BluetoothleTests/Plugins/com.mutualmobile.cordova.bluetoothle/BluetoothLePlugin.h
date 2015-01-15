#import <Cordova/CDV.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothLePlugin : CDVPlugin <CBCentralManagerDelegate, CBPeripheralDelegate>
{
    NSString* initCallback;
    NSString* scanCallback;
    NSString* connectCallback;
    NSString* discoverCallback;
    NSString* descriptorCallback;
    NSString* rssiCallback;
    NSString* deviceCallback;
    NSMutableDictionary* operationCallbacks;
    
    CBCentralManager *centralManager;
    
    CBPeripheral* activePeripheral;
}

- (void)initialize:(CDVInvokedUrlCommand *)command;
//- (void)startScan:(CDVInvokedUrlCommand *)command;
- (void)stopScan:(CDVInvokedUrlCommand *)command;
- (void)connect:(CDVInvokedUrlCommand *)command;
- (void)reconnect:(CDVInvokedUrlCommand *)command;
- (void)disconnect:(CDVInvokedUrlCommand *)command;
- (void)close:(CDVInvokedUrlCommand *)command;
- (void)discover:(CDVInvokedUrlCommand *)command;
- (void)getServices:(CDVInvokedUrlCommand *)command;
- (void)getCharacteristics:(CDVInvokedUrlCommand *)command;
- (void)descriptors:(CDVInvokedUrlCommand *)command;
- (void)readCharacteristicValue:(CDVInvokedUrlCommand *)command;
- (void)startCharacteristicNotifications:(CDVInvokedUrlCommand *)command;
- (void)stopCharacteristicNotifications:(CDVInvokedUrlCommand *)command;
- (void)writeCharacteristicValue:(CDVInvokedUrlCommand *)command;
- (void)readDescriptor:(CDVInvokedUrlCommand *)command;
- (void)writeDescriptor:(CDVInvokedUrlCommand *)command;
- (void)rssi:(CDVInvokedUrlCommand *)command;
- (void)isInitialized:(CDVInvokedUrlCommand *)command;
- (void)isEnabled:(CDVInvokedUrlCommand *)command;
- (void)isScanning:(CDVInvokedUrlCommand *)command;
- (void)isConnected:(CDVInvokedUrlCommand *)command;
- (void)isDiscovered:(CDVInvokedUrlCommand *)command;

- (void)onDeviceAdded:(CDVInvokedUrlCommand *)command;
- (void)onDeviceDropped:(CDVInvokedUrlCommand *)command;
- (void)onCharacteristicValueChanged:(CDVInvokedUrlCommand *)command;
- (void)getAdapterState:(CDVInvokedUrlCommand *)command;
- (void)getDevice:(CDVInvokedUrlCommand *)command;
- (void)getService:(CDVInvokedUrlCommand *)command;
- (void)getCharacteristic:(CDVInvokedUrlCommand *)command;
- (void)startDiscovery:(CDVInvokedUrlCommand *)command;

@end

//Taken from http://stackoverflow.com/questions/13275859/how-to-turn-cbuuid-into-string, thanks Brad Larson

@interface CBUUID (StringExtraction)

- (NSString *)representativeString;

@end

@implementation CBUUID (StringExtraction)

- (NSString *)representativeString;
{
    NSData *data = [self data];
    
    NSUInteger bytesToConvert = [data length];
    const unsigned char *uuidBytes = [data bytes];
    NSMutableString *outputString = [NSMutableString stringWithCapacity:16];
    
    for (NSUInteger currentByteIndex = 0; currentByteIndex < bytesToConvert; currentByteIndex++)
    {
        switch (currentByteIndex)
        {
            case 3:
            case 5:
            case 7:
            case 9:[outputString appendFormat:@"%02x-", uuidBytes[currentByteIndex]]; break;
            default:[outputString appendFormat:@"%02x", uuidBytes[currentByteIndex]];
        }
        
    }
    
    return outputString;
}

@end