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




//###############################
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



//###############################
@interface NSDictionary (representativeJSON)
- (NSString *)representativeJSON;
@end

@implementation NSDictionary (representativeJSON)
- (NSString *)representativeJSON; {
    NSError *error;
    if (!self) {
        return @"{}";
    }
    
    NSMutableDictionary *sterilizedData = [[NSMutableDictionary alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyString = @"";
        NSString *objString = @"";
        if ([key isKindOfClass:[CBUUID class]]) {
            keyString = [key UUIDString];
        } else if ([key isKindOfClass:[NSString class]]) {
            keyString = key;
        }
        if ([obj isKindOfClass:[NSData class]]) {
            objString = [obj base64EncodedStringWithOptions:0];
        } else if ([obj isKindOfClass:[NSString class]]) {
            objString = obj;
        }
        [sterilizedData setValue:objString forKey:keyString];
    }];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sterilizedData options:0 error:&error];
    
    if (!jsonData) {
        NSLog(@"jsonString: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end


//###############################
@interface NSData (manufacturerDataJSON)
- (NSString *)manufacturerDataJSON;
@end

@implementation NSData (manufacturerDataJSON)
- (NSString *)manufacturerDataJSON; {
    NSError *error;
    if (!self) {
        return @"{}";
    }
    
    NSMutableDictionary *manufacturerData = [[NSMutableDictionary alloc] init];
    NSData *keyData = [self subdataWithRange:NSMakeRange(0, 2)];
    NSData *objData = [self subdataWithRange:NSMakeRange(2, self.length-2)];
    NSString *keyString = [[NSString alloc] initWithData:keyData encoding:NSUTF8StringEncoding];
    NSString *objString = [objData base64EncodedStringWithOptions:0];
    [manufacturerData setValue:objString forKey:keyString];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:manufacturerData options:0 error:&error];
    
    if (!jsonData) {
        NSLog(@"jsonString: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end


//###############################
@interface NSData (representativeHEX)
- (NSString *)representativeHEX;
@end

@implementation NSData (representativeHEX)
- (NSString *)representativeHEX; {
    const unsigned char* bytes = (const unsigned char*)[self bytes];
    NSUInteger nbBytes = [self length];
    NSUInteger strLen = 2*nbBytes + 0;
    
    NSMutableString* hex = [[NSMutableString alloc] initWithCapacity:strLen];
    for(NSUInteger i=0; i<nbBytes; ) {
        [hex appendFormat:@"%02X", bytes[i]];
        ++i;
    }
    return hex;
}
@end