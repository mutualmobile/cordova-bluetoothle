#import "BluetoothLePlugin.h"

#import "BaseReturnObjectType.h"

//Object Keys
NSString *const keyStatus = @"status";
NSString *const keyError = @"error";
NSString *const keyCode = @"code";
NSString *const keyRequest = @"request";
NSString *const keyMessage = @"message";
NSString *const keyName = @"name";
NSString *const keyAddress = @"address";
NSString *const keyRssi = @"rssi";
NSString *const keyAdvertisement = @"advertisement";
NSString *const keyServiceUuids = @"serviceUuids";
NSString *const keyCharacteristicUuids = @"characteristicUuids";
NSString *const keyDescriptorUuids = @"descriptorUuids";
NSString *const keyServiceUuid = @"serviceUuid";
NSString *const keyCharacteristicUuid = @"characteristicUuid";
NSString *const keyDescriptorUuid = @"descriptorUuid";
NSString *const keyValue = @"value";
NSString *const keyIsInitialized = @"isInitalized";
NSString *const keyIsEnabled = @"isEnabled";
NSString *const keyIsScanning = @"isScanning";
NSString *const keyIsConnected = @"isConnected";
NSString *const keyIsDiscovered = @"isDiscovered";

//Status Types
NSString *const statusEnabled = @"enabled";
NSString *const statusScanStarted = @"scanStarted";
NSString *const statusScanStopped = @"scanStopped";
NSString *const statusScanResult = @"scanResult";
NSString *const statusConnected = @"connected";
NSString *const statusConnecting = @"connecting";
NSString *const statusDisconnected = @"disconnected";
NSString *const statusDisconnecting = @"disconnecting";
NSString *const statusClosed = @"closed";
NSString *const statusDiscoveredServices = @"discoveredServices";
NSString *const statusDiscoveredCharacteristics = @"discoveredCharacteristics";
NSString *const statusDiscoveredDescriptors = @"discoveredDescriptors";
NSString *const statusRead = @"read";
NSString *const statusSubscribed = @"subscribed";
NSString *const statusSubscribedResult = @"subscribedResult";
NSString *const statusUnsubscribed = @"unsubscribed";
NSString *const statusWritten = @"written";
NSString *const statusReadDescriptor = @"readDescriptor";
NSString *const statusWrittenDescriptor = @"writtenDescriptor";
NSString *const statusRssi = @"rssi";

//Error Types
NSString *const errorInitialize = @"initialize";
NSString *const errorEnable = @"enable";
NSString *const errorArguments = @"arguments";
NSString *const errorStartScan = @"startScan";
NSString *const errorStopScan = @"stopScan";
NSString *const errorConnect = @"connect";
NSString *const errorReconnect = @"reconnect";
NSString *const errorDiscoverServices = @"discoverServices";
NSString *const errorDiscoverCharacteristics = @"discoverCharacteristics";
NSString *const errorDiscoverDescriptors = @"discoverDescriptors";
NSString *const errorRead = @"read";
NSString *const errorSubscription = @"subscription";
NSString *const errorWrite = @"write";
NSString *const errorReadDescriptor = @"readDescriptor";
NSString *const errorWriteDescriptor = @"writeDescriptor";
NSString *const errorRssi = @"rssi";
NSString *const errorNeverConnected = @"neverConnected";
NSString *const errorIsNotDisconnected = @"isNotDisconnected";
NSString *const errorIsNotConnected = @"isNotConnected";
NSString *const errorIsDisconnected = @"isDisconnected";
NSString *const errorService = @"service";
NSString *const errorCharacteristic = @"characteristic";
NSString *const errorDescriptor = @"descriptor";
NSString *const errorGetDevice = @"getDevice";




//Codes
NSString *const codeSuccess = @"100";
NSString *const codeErrorInitialize = @"101";
NSString *const codeErrorEnable = @"102";
NSString *const codeErrorArguments = @"103";
NSString *const codeErrorStartScan = @"104";
NSString *const codeErrorStopScan = @"105";
NSString *const codeErrorConnect = @"106";
NSString *const codeErrorReconnect = @"107";
NSString *const codeErrorDiscoverServices = @"108";
NSString *const codeErrorDiscoverCharacteristics = @"109";
NSString *const codeErrorDiscoverDescriptors = @"110";
NSString *const codeErrorRead = @"111";
NSString *const codeErrorSubscription = @"112";
NSString *const codeErrorWrite = @"113";
NSString *const codeErrorReadDescriptor = @"114";
NSString *const codeErrorWriteDescriptor = @"115";
NSString *const codeErrorRssi = @"116";
NSString *const codeErrorNeverConnected = @"117";
NSString *const codeErrorIsNotDisconnected = @"118";
NSString *const codeErrorIsNotConnected = @"119";
NSString *const codeErrorIsDisconnected = @"120";
NSString *const codeErrorService = @"121";
NSString *const codeErrorCharacteristic = @"122";
NSString *const codeErrorDescriptor = @"123";
NSString *const codeErrorGetDevice = @"124";
//Init Error Codes
NSString *const codePoweredOff = @"201";
NSString *const codeUnauthorized = @"202";
NSString *const codeUnknown = @"203";
NSString *const codeResetting = @"204";
NSString *const codeUnsupported = @"205";
NSString *const codeNotInit = @"206";
NSString *const codeNotEnabled = @"207";
NSString *const codeAlreadyInit = @"208";
//Scanning Error Codes
NSString *const codeAlreadyScanning = @"300";
NSString *const codeNotScanning = @"301";
//Connection Error Codes
NSString *const codePreviouslyConnected = @"400";
NSString *const codeNeverConnected = @"401";
NSString *const codeIsNotConnected = @"402";
NSString *const codeIsNotDisconnected = @"403";
NSString *const codeIsDisconnected = @"404";
NSString *const codeNoAddress = @"405";
NSString *const codeNoDevice = @"406";
//Read/write
NSString *const codeNoArgObj = @"500";
NSString *const codeNoService = @"501";
NSString *const codeNoCharacteristic = @"502";
NSString *const codeNoDescriptor = @"503";
NSString *const codeWriteValueNotFound = @"504";
NSString *const codeWriteDescriptorValueNotFound = @"505";



//Error Messages
//Initialization
NSString *const logPoweredOff = @"Bluetooth powered off";
NSString *const logUnauthorized = @"Bluetooth unauthorized";
NSString *const logUnknown = @"Bluetooth unknown state";
NSString *const logResetting = @"Bluetooth resetting";
NSString *const logUnsupported = @"Bluetooth unsupported";
NSString *const logNotInit = @"Bluetooth not initialized";
NSString *const logNotEnabled = @"Bluetooth not enabled";
NSString *const logAlreadyInit = @"Bluetooth already initialized";
//Scanning
NSString *const logAlreadyScanning = @"Scanning already in progress";
NSString *const logNotScanning = @"Not scanning";
//Connection
NSString *const logPreviouslyConnected = @"Device previously connected, reconnect or close for new device";
NSString *const logNeverConnected = @"Never connected to device";
NSString *const logIsNotConnected = @"Device isn't connected";
NSString *const logIsNotDisconnected = @"Device isn't disconnected";
NSString *const logIsDisconnected = @"Device is disconnected";
NSString *const logNoAddress = @"No device address";
NSString *const logNoDevice = @"Device not found";
//Read/write
NSString *const logNoArgObj = @"Argument object not found";
NSString *const logNoService = @"Service not found";
NSString *const logNoCharacteristic = @"Characteristic not found";
NSString *const logNoDescriptor = @"Descriptor not found";
NSString *const logWriteValueNotFound = @"Write value not found";
NSString *const logWriteDescriptorValueNotFound = @"Write descriptor value not found";

NSString *const operationRead = @"read";
NSString *const operationSubscribe = @"subscribe";
NSString *const operationUnsubscribe = @"unsubscribe";
NSString *const operationWrite = @"write";

// AdapterState object
NSString * const AdapterStateAddress = @"address";
NSString * const AdapterStateName = @"name";
NSString * const AdapterStateEnabled = @"enabled";
NSString * const AdapterStateDiscovering = @"discovering";

// Device object
NSString * const DeviceAddress = @"address";
NSString * const DeviceName = @"name";
NSString * const DeviceRSSI = @"rssi";
NSString * const DeviceConnected = @"connected";
NSString * const DeviceUUIDS = @"uuids";

@interface BluetoothLePlugin ()

@property (nonatomic, copy) NSString *onDeviceAddedCallback;
@property (nonatomic, copy) NSString *onCharacteristicValueChangedCallback;
@property (nonatomic, copy) NSString *onDeviceDroppedCallback;
@property (nonatomic, copy) NSString *readCharacteristicValueCallback;
@property (nonatomic, strong) NSMutableSet *connectedPeripherals;

@end

@implementation BluetoothLePlugin

//Actions

- (void)pluginInitialize {
    [self initialize:nil];
    self.connectedPeripherals = [NSMutableSet set];
}

- (void)initialize:(CDVInvokedUrlCommand *)command
{
    if (centralManager != nil)
    {
        //Already intialized
        return;
    }
    
    NSNumber* request = [NSNumber numberWithBool:NO];
    
    NSDictionary* obj = [self getArgsObject:command.arguments];
    
    if (obj != nil)
    {
        request = [self getRequest:obj];
    }
    
    initCallback = command.callbackId;
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{ CBCentralManagerOptionRestoreIdentifierKey:@"bluetoothleplugin", CBCentralManagerOptionShowPowerAlertKey:request }];
}

- (void)startDiscovery:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    //Ensure scan isn't already running
    if (scanCallback != nil)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeAlreadyScanning, keyCode, errorStartScan, keyError, logAlreadyScanning, keyMessage, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    NSMutableArray* serviceUuids = nil;
    
    if (obj != nil)
    {
        serviceUuids = [self getUuids:obj forType:keyServiceUuids];
    }
    
    scanCallback = command.callbackId;
    
    //Send scan started status
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusScanStarted, keyStatus, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:scanCallback];
    
    //Start the scan
    [centralManager scanForPeripheralsWithServices:serviceUuids options:nil];
}

- (void)stopScan:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    //Ensure scan is running
//    if (scanCallback == nil)
//    {
//        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNotScanning, keyCode, errorStartScan, keyError, logNotScanning, keyMessage, nil];
//        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
//        [pluginResult setKeepCallbackAsBool:false];
//        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//        return;
//    }
    
    scanCallback = nil;
    
    [centralManager stopScan];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusScanStopped, keyStatus, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)connect:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        //NSLog(@"not initialized");
        return;
    }
    
    if (activePeripheral != nil)
    {
        //NSLog(@"still active");
        [self reconnect:command];
//        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codePreviouslyConnected, keyCode, errorConnect, keyError, logPreviouslyConnected, keyMessage, nil];
//        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
//        [pluginResult setKeepCallbackAsBool:false];
//        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSDictionary* obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        //NSLog(@"no args");
        return;
    }
    
    NSUUID* address = [self getAddress:obj];
    
    if (address == nil)
    {
        //NSLog(@"no address");
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNoAddress, keyCode, errorConnect, keyError, logNoAddress, keyMessage, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    
    NSArray* peripherals = [centralManager retrievePeripheralsWithIdentifiers:@[address]];
    
    if (peripherals.count == 0)
    {
        //NSLog(@"not found");
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNoDevice, keyCode, errorConnect, keyError, logNoDevice, keyMessage, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    activePeripheral = peripherals[0];
    
    if ([self isNotInitialized:command])
    {
        //NSLog(@"checking - not initialized");
    }
    
    if ([self wasNeverConnected:command])
    {
        //NSLog(@"checking - not ever connected");
    }
    
    if ([self isNotDisconnected:command])
    {
        //NSLog(@"checking - not disconnected");
    }
    
    [activePeripheral setDelegate:self];
    
    connectCallback = command.callbackId;
    
    [centralManager connectPeripheral:activePeripheral options:nil];
}

- (void)reconnect:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        //NSLog(@"not initialized");
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        //NSLog(@"not ever connected");
        return;
    }
    
    if ([self isNotDisconnected:command])
    {
        //NSLog(@"not disconnected");
        return;
    }
    
    connectCallback = command.callbackId;
    
    //NSObject* name = [self formatName:activePeripheral.name];
    
//    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusConnecting, keyStatus, name, keyName, [activePeripheral.identifier UUIDString], keyAddress, nil];
//    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
//    [pluginResult setKeepCallbackAsBool:true];
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:connectCallback];
    
    [centralManager connectPeripheral:activePeripheral options:nil];
}

- (void)disconnect:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isDisconnected:command])
    {
        return;
    }
    
    NSObject* name = [self formatName:activePeripheral.name];
    
    if (activePeripheral.state == CBPeripheralStateConnecting)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusDisconnecting, keyStatus, name, keyName, [activePeripheral.identifier UUIDString], keyAddress, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        connectCallback = nil;
    }
    else
    {
        connectCallback = command.callbackId;
        
//        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusDisconnecting, keyStatus, name, keyName, [activePeripheral.identifier UUIDString], keyAddress, nil];
//        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
//        [pluginResult setKeepCallbackAsBool:true];
//        [self.commandDelegate sendPluginResult:pluginResult callbackId:connectCallback];
    }
    
    [centralManager cancelPeripheralConnection:activePeripheral];
}

- (void)close:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotDisconnected:command])
    {
        return;
    }
    
    NSObject* name = [self formatName:activePeripheral.name];
    
    //Create dictionary with status message and optionally add device information
    NSMutableDictionary* returnObj = [NSMutableDictionary dictionaryWithObjectsAndKeys:  codeSuccess, keyCode, statusClosed, keyStatus, name, keyName, [activePeripheral.identifier UUIDString], keyAddress, nil];
    
    activePeripheral = nil;
    connectCallback = nil;
    
    [self clearOperationCallbacks];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)discover:(CDVInvokedUrlCommand *)command
{
    //TODO Whether this returns null
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getServices:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    NSMutableArray* serviceUuids = [self getUuids:obj forType:keyServiceUuids];
    
    discoverCallback = command.callbackId;
    
    [activePeripheral discoverServices:serviceUuids];
}

- (void)getCharacteristics:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    NSMutableArray* characteristicUuids = [self getUuids:obj forType:keyCharacteristicUuids];
    
    discoverCallback = command.callbackId;
    
    [activePeripheral discoverCharacteristics:characteristicUuids forService:service];
}

- (void)descriptors:(CDVInvokedUrlCommand *)command
{
    //Ensure Bluetooth is enabled
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    CBCharacteristic* characteristic = [self getCharacteristic:obj forService:service];
    
    if ([self isNotCharacteristic:characteristic :command])
    {
        return;
    }
    
    discoverCallback = command.callbackId;
    
    [activePeripheral discoverDescriptorsForCharacteristic:characteristic];
}

- (void)readCharacteristicValue:(CDVInvokedUrlCommand *)command
{
    //Normal read
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    CBCharacteristic* characteristic = [self getCharacteristic:obj forService:service];
    
    if ([self isNotCharacteristic:characteristic :command])
    {
        return;
    }
    
    [self addCallback:characteristic.UUID forOperationType:operationRead forCallback:command.callbackId];
    self.readCharacteristicValueCallback = command.callbackId;
    
    [activePeripheral readValueForCharacteristic:characteristic];
}

- (void)startCharacteristicNotifications:(CDVInvokedUrlCommand *)command
{
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    CBCharacteristic* characteristic = [self getCharacteristic:obj forService:service];
    
    if ([self isNotCharacteristic:characteristic :command])
    {
        return;
    }
    
    [self addCallback:characteristic.UUID forOperationType:operationSubscribe forCallback:command.callbackId];
    
    [activePeripheral setNotifyValue:true forCharacteristic:characteristic];
}

- (void)stopCharacteristicNotifications:(CDVInvokedUrlCommand *)command
{
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    CBCharacteristic* characteristic = [self getCharacteristic:obj forService:service];
    
    if ([self isNotCharacteristic:characteristic :command])
    {
        return;
    }
    
    [self addCallback:characteristic.UUID forOperationType:operationUnsubscribe forCallback:command.callbackId];
    
    [activePeripheral setNotifyValue:false forCharacteristic:characteristic];
}

- (void)writeCharacteristicValue:(CDVInvokedUrlCommand *)command
{
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    CBCharacteristic* characteristic = [self getCharacteristic:obj forService:service];
    
    if ([self isNotCharacteristic:characteristic :command])
    {
        return;
    }
    
    NSData* value = [self getValue:obj];
    
//    if (value == nil)
//    {
//        Characteristic *newCharacteristic = [Characteristic characteristicFromCBCharacteristic:characteristic];
//        NSDictionary *dictionaryRepresentation = [newCharacteristic dictionaryRepresentation];
//        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:dictionaryRepresentation];
//        [pluginResult setKeepCallbackAsBool:false];
//        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//        return;
//    }
    
    [self addCallback:characteristic.UUID forOperationType:operationWrite forCallback:command.callbackId];

    BOOL withResponse = [[obj valueForKey:@"withResponse"] boolValue];
    if (withResponse){
        [activePeripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    } else {
        [activePeripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)readDescriptor:(CDVInvokedUrlCommand *)command
{
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    CBCharacteristic* characteristic = [self getCharacteristic:obj forService:service];
    
    if ([self isNotCharacteristic:characteristic :command])
    {
        return;
    }
    
    CBDescriptor* descriptor = [self getDescriptor:obj forCharacteristic:characteristic];
    
    if ([self isNotDescriptor:descriptor :command])
    {
        return;
    }
    
    descriptorCallback = command.callbackId;
    
    [activePeripheral readValueForDescriptor:descriptor];
}

- (void)writeDescriptor:(CDVInvokedUrlCommand *)command
{
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    //Get an array of service assigned numbers to filter by
    NSDictionary *obj = [self getArgsObject:command.arguments];
    
    if ([self isNotArgsObject:obj :command])
    {
        return;
    }
    
    CBService* service = [self serviceFromDictionary:obj];
    
    if ([self isNotService:service :command])
    {
        return;
    }
    
    CBCharacteristic* characteristic = [self getCharacteristic:obj forService:service];
    
    if ([self isNotCharacteristic:characteristic :command])
    {
        return;
    }
    
    CBDescriptor* descriptor = [self getDescriptor:obj forCharacteristic:characteristic];
    
    if ([self isNotDescriptor:descriptor :command])
    {
        return;
    }
    
    NSData* value = [self getValue:obj];
    
    if (value == nil)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeWriteDescriptorValueNotFound, keyCode, errorWriteDescriptor, keyError, logWriteDescriptorValueNotFound, keyMessage, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    descriptorCallback = command.callbackId;
    
    [activePeripheral writeValue:value forDescriptor:descriptor];
}

- (void)rssi:(CDVInvokedUrlCommand *)command
{
    if ([self isNotInitialized:command])
    {
        return;
    }
    
    if ([self wasNeverConnected:command])
    {
        return;
    }
    
    if ([self isNotConnected:command])
    {
        return;
    }
    
    rssiCallback = command.callbackId;
    
    [activePeripheral readRSSI];
}

- (void)isInitialized:(CDVInvokedUrlCommand *)command
{
    NSNumber* result = [NSNumber numberWithBool:(centralManager != nil)];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, result, keyIsInitialized, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)isEnabled:(CDVInvokedUrlCommand *)command
{
    NSNumber* result = [NSNumber numberWithBool:(centralManager != nil && centralManager.state == CBCentralManagerStatePoweredOn)];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, result, keyIsEnabled, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)isScanning:(CDVInvokedUrlCommand *)command
{
    NSNumber* result = [NSNumber numberWithBool:(scanCallback != nil)];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, result, keyIsScanning, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)isConnected:(CDVInvokedUrlCommand *)command
{
    NSNumber* result = [NSNumber numberWithBool:(activePeripheral != nil && activePeripheral.state == CBPeripheralStateConnected)];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, result, keyIsConnected, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)isDiscovered:(CDVInvokedUrlCommand *)command
{
    NSNumber* result = [NSNumber numberWithBool:(false)];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, result, keyIsDiscovered, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//Central Manager Delegates
- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    //If no callback, don't return anything
    if (initCallback == nil)
    {
        return;
    }
    
    //Decide on error message
    NSString* error = nil;
    NSString* errorCode = nil;
    switch ([centralManager state])
    {
        case CBCentralManagerStatePoweredOff:
        {
            error = logPoweredOff;
            errorCode = codePoweredOff;
            break;
        }
            
        case CBCentralManagerStateUnauthorized:
        {
            error = logUnauthorized;
            errorCode = codeUnauthorized;
            break;
        }
            
        case CBCentralManagerStateUnknown:
        {
            error = logUnknown;
            errorCode = codeUnknown;
            break;
        }
            
        case CBCentralManagerStateResetting:
        {
            error = logResetting;
            errorCode = codeResetting;
            break;
        }
            
        case CBCentralManagerStateUnsupported:
        {
            error = logUnsupported;
            errorCode = codeUnsupported;
            break;
        }
            
        case CBCentralManagerStatePoweredOn:
        {
            //Bluetooth on!
            break;
        }
    }
    
    NSDictionary* returnObj = nil;
    CDVPluginResult* pluginResult = nil;
    
    if (error != nil)
    {
        returnObj = [NSDictionary dictionaryWithObjectsAndKeys: errorCode, keyCode, errorEnable, keyError, error, keyMessage, nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        
        //Clear out the callbacks cause user will need to connect again after Bluetooth is back on
        scanCallback = nil;
        connectCallback = nil;
        [self clearOperationCallbacks];
        activePeripheral = nil;
    }
    else
    {
        returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusEnabled, keyStatus, nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    }
    
    [pluginResult setKeepCallbackAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:initCallback];
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict
{
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (self.onDeviceAddedCallback == nil)
    {
        return;
    }
    
    Device *device = [Device new];
    device.address = peripheral.identifier.UUIDString;
    device.name = [self formatName:advertisementData[CBAdvertisementDataLocalNameKey]];
    NSDictionary *serviceData = [advertisementData valueForKey:CBAdvertisementDataServiceDataKey];
    device.serviceData = [serviceData representativeJSON];
    NSData* manufacturerData = [advertisementData valueForKey:CBAdvertisementDataManufacturerDataKey];
    device.manufacturerData = [manufacturerData manufacturerDataJSON];
    NSNumber* txPowerLevel = [advertisementData valueForKey:CBAdvertisementDataTxPowerLevelKey];
    if (txPowerLevel) {
        device.txPowerLevel = [txPowerLevel integerValue];
    } else {
        device.txPowerLevel = 0;
    }
    device.rssi = [RSSI integerValue];
    device.connected = (peripheral.state == CBPeripheralStateConnected);
    device.uuids = [advertisementData[CBAdvertisementDataServiceUUIDsKey] valueForKey:@"UUIDString"];
    if (device.uuids == nil) {
        device.uuids = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *returnObj = [device dictionaryRepresentation];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.onDeviceAddedCallback];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    operationCallbacks = [NSMutableDictionary dictionary];
    
    //Successfully connected, call back to end user
    if (connectCallback == nil)
    {
        return;
    }
    
    NSObject* name = [self formatName:peripheral.name];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusConnected, keyStatus, name, keyName, [peripheral.identifier UUIDString], keyAddress, nil];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    //Keep in case device gets disconnected without user initiation
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:connectCallback];
//    [activePeripheral discoverServices:@[]];
    [self.connectedPeripherals addObject:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (connectCallback == nil)
    {
        return;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorConnect, keyCode, errorConnect, keyError, error.description, keyMessage, nil];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:connectCallback];
    
    connectCallback = nil;
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [self clearOperationCallbacks];
    
    if (connectCallback != nil) {
        NSObject* name = [self formatName:peripheral.name];
        
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusDisconnected, keyStatus, name, keyName, [peripheral.identifier UUIDString], keyAddress, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:connectCallback];
        
        connectCallback = nil;
    }
    
    scanCallback = nil;
    activePeripheral = nil;
    
    [self peripheralDidLoseConnection:peripheral];
    
}

//Peripheral Delegates

// fake delegate method we've made up to manage losing connection by accident
- (void)peripheralDidLoseConnection:(CBPeripheral *)peripheral {
    if ( self.onDeviceDroppedCallback == nil ) {
        return;
    }
    
    NSObject* name = [self formatName:peripheral.name];
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorIsDisconnected, keyCode, statusDisconnected, keyStatus, name, keyName, [peripheral.identifier UUIDString], keyAddress, nil];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    //Keep in case device gets disconnected without user initiation
    [pluginResult setKeepCallbackAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.onDeviceDroppedCallback];
    [self.connectedPeripherals removeObject:peripheral];
    
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (discoverCallback == nil)
    {
        return;
    }
    
    NSObject* name = [self formatName:peripheral.name];
    
    if (error != nil)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorDiscoverServices, keyCode, errorDiscoverServices, keyError, name, keyName, [peripheral.identifier UUIDString], keyAddress, error.description, keyMessage, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:discoverCallback];
        discoverCallback = nil;
        return;
    }
    
    NSMutableArray* services = [[NSMutableArray alloc] init];
    
    for (CBService* service in peripheral.services)
    {
        Service *newService = [Service new];
        newService.uuid = service.UUID.UUIDString;
        newService.isPrimary = service.isPrimary;
        newService.instanceId = service.UUID.UUIDString;
        newService.deviceAddress = service.peripheral.identifier.UUIDString;
        NSDictionary *dictionaryRepresentation = [newService dictionaryRepresentation];
        [services addObject:dictionaryRepresentation];
    }
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:services];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:discoverCallback];
    
    discoverCallback = nil;
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (discoverCallback == nil)
    {
        return;
    }
    
    NSObject* name = [self formatName:peripheral.name];
    
    if (error != nil)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorDiscoverCharacteristics, keyCode, errorDiscoverCharacteristics, keyError, name, keyName, [peripheral.identifier UUIDString], keyAddress, error.description, keyMessage, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:discoverCallback];
        discoverCallback = nil;
        return;
    }
    
    NSMutableArray* characteristics = [[NSMutableArray alloc] init];
    
    for (CBCharacteristic* characteristic in service.characteristics)
    {
        Characteristic *newCharacteristic = [Characteristic characteristicFromCBCharacteristic:characteristic];
        [characteristics addObject:[newCharacteristic dictionaryRepresentation]];
    }
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:characteristics];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:discoverCallback];
    
    discoverCallback = nil;
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (discoverCallback == nil)
    {
        return;
    }
    
    NSObject* name = [self formatName:peripheral.name];
    
    if (error != nil)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorDiscoverDescriptors, keyCode, errorDiscoverDescriptors, keyError, name, keyName, [peripheral.identifier UUIDString], keyAddress, error.description, keyMessage, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:discoverCallback];
        discoverCallback = nil;
        return;
    }
    
    NSMutableArray* descriptors = [[NSMutableArray alloc] init];
    
    for (CBDescriptor* descriptor in characteristic.descriptors)
    {
        [descriptors addObject:[descriptor.UUID representativeString]];
    }
    
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, statusDiscoveredDescriptors, keyStatus, name, keyName, [peripheral.identifier UUIDString], keyAddress, descriptors, keyDescriptorUuids, [characteristic.UUID representativeString], keyCharacteristicUuid, [characteristic.service.UUID representativeString], keyServiceUuid, nil];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:discoverCallback];
    
    discoverCallback = nil;
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSMutableDictionary* returnObj = [NSMutableDictionary dictionaryWithObjectsAndKeys: [characteristic.service.UUID representativeString], keyServiceUuid, [characteristic.UUID representativeString], keyCharacteristicUuid, nil];
    
    if (error != nil)
    {
        NSString* callback = nil;
        if (characteristic.isNotifying)
        {
            callback = [self getCallback:characteristic.UUID forOperationType:operationSubscribe];
            [returnObj setValue:errorSubscription forKey:keyError];
        }
        else
        {
            callback = [self getCallback:characteristic.UUID forOperationType:operationRead];
            [returnObj setValue:errorRead forKey:keyError];
        }
        
        if (callback == nil)
        {
            return;
        }
        
        [returnObj setValue:error.description forKey:keyMessage];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
        
        if (characteristic.isNotifying)
        {
            [self removeCallback:characteristic.UUID forOperationType:operationSubscribe];
        }
        else
        {
            [self removeCallback:characteristic.UUID forOperationType:operationRead];
        }
        
        return;
    }
    
//    [self addValue:characteristic.value toDictionary:returnObj];
    
    Characteristic *newCharacteristic = [Characteristic characteristicFromCBCharacteristic:characteristic];
    NSDictionary *dictionaryRepresentation = [newCharacteristic dictionaryRepresentation];
    
    if (characteristic.isNotifying)
    {
        NSString* callback = [self getCallback:characteristic.UUID forOperationType:operationSubscribe];
        
        if (callback == nil)
        {
            return;
        }
        
        [returnObj setValue:statusSubscribedResult forKey:keyStatus];
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dictionaryRepresentation];
        [pluginResult setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.onCharacteristicValueChangedCallback];
    }
    else
    {
        NSString* callback = [self getCallback:characteristic.UUID forOperationType:operationRead];
        
        if (callback == nil)
        {
            return;
        }
        
        [returnObj setValue:statusRead forKey:keyStatus];
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:newCharacteristic.value];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.readCharacteristicValueCallback];
        
        [self removeCallback:characteristic.UUID forOperationType:operationRead];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    if (descriptorCallback == nil)
    {
        return;
    }
    
    CBCharacteristic* characteristic = descriptor.characteristic;
    
    NSMutableDictionary* returnObj = [NSMutableDictionary dictionaryWithObjectsAndKeys: [characteristic.service.UUID representativeString], keyServiceUuid, [characteristic.UUID representativeString], keyCharacteristicUuid, [descriptor.UUID representativeString], keyDescriptorUuid, nil];
    
    if (error != nil)
    {
        [returnObj setValue:errorReadDescriptor forKey:keyError];
        [returnObj setValue:error.description forKey:keyMessage];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:descriptorCallback];
        descriptorCallback = nil;
        return;
    }
    
    NSUInteger value = [descriptor.value integerValue];
    NSData *data = [NSData dataWithBytes:&value length:sizeof(value)];
    [self addValue:data toDictionary:returnObj];
    
    [returnObj setValue:statusReadDescriptor forKey:keyStatus];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:descriptorCallback];
    
    descriptorCallback = nil;
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString* callback = [self getCallback:characteristic.UUID forOperationType:operationWrite];
    
    if (callback == nil)
    {
        return;
    }
    
    
    if (error != nil)
    {
        NSMutableDictionary* returnObj = [NSMutableDictionary dictionaryWithObjectsAndKeys: [characteristic.service.UUID representativeString], keyServiceUuid, [characteristic.UUID representativeString], keyCharacteristicUuid, nil];
        [returnObj setValue:errorWrite forKey:keyError];
        [returnObj setValue:error.description forKey:keyMessage];
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
        [self removeCallback:characteristic.UUID forOperationType:operationWrite];
        return;
    }
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
    
    [self removeCallback:characteristic.UUID forOperationType:operationWrite];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    if (descriptorCallback == nil)
    {
        return;
    }
    
    CBCharacteristic* characteristic = descriptor.characteristic;
    
    NSMutableDictionary* returnObj = [NSMutableDictionary dictionaryWithObjectsAndKeys: [characteristic.service.UUID representativeString], keyServiceUuid, [characteristic.UUID representativeString], keyCharacteristicUuid, [descriptor.UUID representativeString], keyDescriptorUuid, nil];
    
    if (error != nil)
    {
        [returnObj setValue:errorWriteDescriptor forKey:keyError];
        [returnObj setValue:error.description forKey:keyMessage];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:descriptorCallback];
        descriptorCallback = nil;
        return;
    }
    
    [self addValue:descriptor.value toDictionary:returnObj];
    
    [returnObj setValue:statusWrittenDescriptor forKey:keyStatus];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:descriptorCallback];
    
    descriptorCallback = nil;
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSMutableDictionary* returnObj = [NSMutableDictionary dictionaryWithObjectsAndKeys: [characteristic.service.UUID representativeString], keyServiceUuid, [characteristic.UUID representativeString], keyCharacteristicUuid, nil];
    
    if (error != nil)
    {
        //Usually I would use characteristic.isNotifying to determine which callback to use
        //But that probably isn't accurate if there's an error, so just use subscribe
        NSString* callback = [self getCallback:characteristic.UUID forOperationType:operationSubscribe];
        
        if (callback == nil)
        {
            return;
        }
        
        [returnObj setValue:errorSubscription forKey:keyError];
        [returnObj setValue:error.description forKey:keyMessage];
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
        
        [self removeCallback:characteristic.UUID forOperationType:operationSubscribe];
        
        return;
    }
    
    if (characteristic.isNotifying)
    {
        NSString* callback = [self getCallback:characteristic.UUID forOperationType:operationSubscribe];
        
        if (callback == nil)
        {
            return;
        }
        
        [returnObj setValue:statusSubscribed forKey:keyStatus];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
    }
    else
    {
        NSString* callback = [self getCallback:characteristic.UUID forOperationType:operationUnsubscribe];
        
        if (callback == nil)
        {
            return;
        }
        
        [returnObj setValue:statusUnsubscribed forKey:keyStatus];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
        
        [self removeCallback:characteristic.UUID forOperationType:operationUnsubscribe];
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    if (rssiCallback == nil && deviceCallback == nil)
    {
        return;
    }
    
    //Extending this callback to work for RSSI and getDevice
    if (rssiCallback != nil) {
        
        if (error != nil)
        {
            NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorRssi, keyCode, errorRssi, keyError, error.description, keyMessage, nil];
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
            [pluginResult setKeepCallbackAsBool:false];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:rssiCallback];
            rssiCallback = nil;
            return;
        }
        
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeSuccess, keyCode, RSSI, keyRssi, statusRssi, keyStatus, nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:rssiCallback];
        
        rssiCallback = nil;
        
        
    } else if (deviceCallback != nil) {
        if (error != nil)
        {
            NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorGetDevice, keyCode, errorGetDevice, keyError, error.description, keyMessage, nil];
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
            [pluginResult setKeepCallbackAsBool:false];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:deviceCallback];
            deviceCallback = nil;
            return;
        }
        
        Device *device = [Device new];
        device.address = peripheral.identifier.UUIDString;
        device.name = peripheral.name;
        device.rssi = [RSSI integerValue];
        device.connected = (peripheral.state == CBPeripheralStateConnected);

        NSMutableArray* services = [[NSMutableArray alloc] init];
        
        for (CBService* service in peripheral.services)
        {
            Service *newService = [Service new];
            newService.uuid = service.UUID.UUIDString;
            newService.isPrimary = service.isPrimary;
            newService.instanceId = service.UUID.UUIDString;
            newService.deviceAddress = service.peripheral.identifier.UUIDString;
            NSDictionary *dictionaryRepresentation = [newService dictionaryRepresentation];
            [services addObject:dictionaryRepresentation];
        }
        
        device.uuids = services;
        NSDictionary *returnObj = [device dictionaryRepresentation];
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:deviceCallback];
        
        deviceCallback = nil;
    }

}


//Helpers for Callbacks
- (NSMutableDictionary*) ensureCallback: (CBUUID *) characteristicUuid
{
    NSMutableDictionary* characteristicCallbacks = [operationCallbacks objectForKey:characteristicUuid];
    
    if (characteristicCallbacks != nil)
    {
        return characteristicCallbacks;
    }
    
    NSMutableDictionary* newCharacteristicCallbacks = [NSMutableDictionary dictionary];
    [operationCallbacks setObject:newCharacteristicCallbacks forKey:characteristicUuid];
    return newCharacteristicCallbacks;
}

- (void) addCallback: (CBUUID *) characteristicUuid forOperationType:(NSString*) operationType forCallback:(NSString*) callback
{
    NSMutableDictionary* characteristicCallbacks = [self ensureCallback:characteristicUuid];
    
    [characteristicCallbacks setObject:callback forKey:operationType];
}

- (NSString*) getCallback: (CBUUID *) characteristicUuid forOperationType:(NSString*) operationType
{
    NSMutableDictionary* characteristicCallbacks = [operationCallbacks objectForKey:characteristicUuid];
    
    if (characteristicCallbacks == nil)
    {
        return nil;
    }
    
    //This may return nil
    return [characteristicCallbacks objectForKey:operationType];
}

- (void) removeCallback: (CBUUID *) characteristicUuid forOperationType:(NSString*) operationType
{
    NSMutableDictionary* characteristicCallbacks = [operationCallbacks objectForKey:characteristicUuid];
    
    if (characteristicCallbacks == nil)
    {
        return;
    }
    
    [characteristicCallbacks removeObjectForKey:operationType];
}

- (void) clearOperationCallbacks
{
    operationCallbacks = [NSMutableDictionary dictionary];
    discoverCallback = nil;
    descriptorCallback = nil;
    rssiCallback = nil;
}

//Helpers to check conditions and send callbacks
- (BOOL) isNotInitialized:(CDVInvokedUrlCommand *)command
{
    if (centralManager == nil)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeErrorInitialize, keyCode, errorInitialize, keyError, logNotInit, keyMessage, nil];
        
        CDVPluginResult *pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return true;
    }
    
    return [self isNotEnabled:command];
}

- (BOOL) isNotEnabled:(CDVInvokedUrlCommand *)command
{
    if (centralManager.state != CBCentralManagerStatePoweredOn)
    {
        NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNotEnabled, keyCode, errorEnable, keyError, logNotEnabled, keyMessage, nil];
        
        CDVPluginResult *pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
        [pluginResult setKeepCallbackAsBool:false];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return true;
    }
    
    return false;
}

- (BOOL) isNotArgsObject:(NSDictionary*) obj :(CDVInvokedUrlCommand *)command
{
    if (obj != nil)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNoArgObj, keyCode, errorArguments, keyError, logNoArgObj, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

- (BOOL) isNotService:(CBService*) service :(CDVInvokedUrlCommand *)command
{
    if (service != nil)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNoService, keyCode, errorService, keyError, logNoService, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

- (BOOL) isNotCharacteristic:(CBCharacteristic*) characteristic :(CDVInvokedUrlCommand *)command
{
    if (characteristic != nil)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNoCharacteristic, keyCode, errorCharacteristic, keyError, logNoCharacteristic, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

- (BOOL) isNotDescriptor:(CBDescriptor*) descriptor :(CDVInvokedUrlCommand *)command
{
    if (descriptor != nil)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNoDescriptor, keyCode, errorDescriptor, keyError, logNoDescriptor, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

- (BOOL) wasNeverConnected:(CDVInvokedUrlCommand *)command
{
    if (activePeripheral != nil)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeNeverConnected, keyCode, errorNeverConnected, keyError, logNeverConnected, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

- (BOOL) isNotDisconnected:(CDVInvokedUrlCommand *)command
{
    if (activePeripheral.state == CBPeripheralStateDisconnected)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeIsNotDisconnected, keyCode, errorIsNotDisconnected, keyError, logIsNotDisconnected, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

- (BOOL) isDisconnected:(CDVInvokedUrlCommand *)command
{
    if (activePeripheral.state != CBPeripheralStateDisconnected)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeIsDisconnected, keyCode, errorIsDisconnected, keyError, logIsDisconnected, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

- (BOOL) isNotConnected:(CDVInvokedUrlCommand *)command
{
    if (activePeripheral.state == CBPeripheralStateConnected || activePeripheral.state == CBPeripheralStateConnecting)
    {
        return false;
    }
    
    NSDictionary* returnObj = [NSDictionary dictionaryWithObjectsAndKeys: codeIsNotConnected, keyCode, errorIsNotConnected, keyError, logIsNotConnected, keyMessage, nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnObj];
    [pluginResult setKeepCallbackAsBool:false];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    return true;
}

//General Helpers
-(NSDictionary*) getArgsObject:(NSArray *)args
{
    if (args == nil)
    {
        return nil;
    }
    
    if (args.count == 1)
    {
        return (NSDictionary *)[args objectAtIndex:0];
    }
    return nil;
}

-(NSData*) getValue:(NSDictionary *) obj
{
    NSString* string = [obj valueForKey:keyValue];
    
    if (string == nil)
    {
        return nil;
    }
    
    if (![string isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    
    if (data == nil || data.length == 0)
    {
        return nil;
    }
    
    return data;
}

-(void) addValue:(NSData *) bytes toDictionary:(NSMutableDictionary *) obj
{
    NSString *string = [bytes base64EncodedStringWithOptions:0];
    
    if (string == nil || string.length == 0)
    {
        return;
    }
    
    [obj setValue:string forKey:keyValue];
}

-(NSMutableArray*) getUuids:(NSDictionary *) dictionary forType:(NSString*) type
{
    NSMutableArray* uuids = [[NSMutableArray alloc] init];
    
    NSArray* checkUuids = [dictionary valueForKey:type];
    
    if (checkUuids == nil)
    {
        return nil;
    }
    
    if (![checkUuids isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    
    for (NSString* checkUuid in checkUuids)
    {
        CBUUID* uuid = [CBUUID UUIDWithString:checkUuid];
        
        if (uuid != nil)
        {
            [uuids addObject:uuid];
        }
    }
    
    if (uuids.count == 0)
    {
        return nil;
    }
    
    return uuids;
}

-(NSUUID*) getAddress:(NSDictionary *)obj
{
    NSString* addressString = [obj valueForKey:keyAddress];
    
    if (addressString == nil)
    {
        return nil;
    }
    
    if (![addressString isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    return [[NSUUID UUID] initWithUUIDString:addressString];
}

-(NSNumber*) getRequest:(NSDictionary *)obj
{
    NSNumber* request = [obj valueForKey:keyRequest];
    
    if (request == nil)
    {
        return [NSNumber numberWithBool:NO];
    }
    
    if (![request isKindOfClass:[NSNumber class]])
    {
        return [NSNumber numberWithBool:NO];
    }
    
    return request;
}

-(id) formatName:(NSString*)name
{
    if (name != nil)
    {
        return name;
    }
    
    return [NSNull null];
}

-(CBService*) serviceFromDictionary:(NSDictionary *)obj
{
    if (activePeripheral.services == nil)
    {
        return nil;
    }
    
    NSString* uuidString = [obj valueForKey:keyServiceUuid];
    
    if (uuidString == nil)
    {
        return nil;
    }
    
    if (![uuidString isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    CBUUID* uuid = [CBUUID UUIDWithString:uuidString];
    
    if (uuid == nil)
    {
        return nil;
    }
    
    CBService* service = nil;
    
    for (CBService* item in activePeripheral.services)
    {
        if ([item.UUID isEqual: uuid])
        {
            service = item;
        }
    }
    
    return service;
}

-(CBCharacteristic*) getCharacteristic:(NSDictionary *) obj forService:(CBService*) service
{
    if (service.characteristics == nil)
    {
        return nil;
    }
    
    NSString* uuidString = [obj valueForKey:keyCharacteristicUuid];
    
    if (uuidString == nil)
    {
        return nil;
    }
    
    if (![uuidString isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    CBUUID* uuid = [CBUUID UUIDWithString:uuidString];
    
    if (uuid == nil)
    {
        return nil;
    }
    
    CBCharacteristic* characteristic = nil;
    
    for (CBCharacteristic* item in service.characteristics)
    {
        if ([item.UUID isEqual: uuid])
        {
            characteristic = item;
        }
    }
    
    return characteristic;
}

-(CBDescriptor*) getDescriptor:(NSDictionary *) obj forCharacteristic:(CBCharacteristic*) characteristic
{
    if (characteristic.descriptors == nil)
    {
        return nil;
    }
    
    NSString* uuidString = [obj valueForKey:keyDescriptorUuid];
    
    if (uuidString == nil)
    {
        return nil;
    }
    
    if (![uuidString isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    CBUUID* uuid = [CBUUID UUIDWithString:uuidString];
    
    if (uuid == nil)
    {
        return nil;
    }
    
    CBDescriptor* descriptor = nil;
    
    for (CBDescriptor* item in characteristic.descriptors)
    {
        if ([item.UUID isEqual: uuid])
        {
            descriptor = item;
        }
    }
    
    return descriptor;
}


#pragma mark - Custom

- (void)stopDiscovery:(CDVInvokedUrlCommand *)command {
    [self stopScan:command];
}

- (void)onDeviceAdded:(CDVInvokedUrlCommand *)command {
    self.onDeviceAddedCallback = command.callbackId;
}

- (void)onDeviceDropped:(CDVInvokedUrlCommand *)command {
    self.onDeviceDroppedCallback = command.callbackId;
}

- (void)onCharacteristicValueChanged:(CDVInvokedUrlCommand *)command {
    self.onCharacteristicValueChangedCallback = command.callbackId;
}

- (void)getAdapterState:(CDVInvokedUrlCommand *)command {
    BOOL isEnabled = (centralManager.state == CBCentralManagerStatePoweredOn);
    NSDictionary *adapterState = @{ AdapterStateAddress : @"1234",
                                    AdapterStateName : @"andrew",
                                    AdapterStateEnabled : @(isEnabled),
                                    AdapterStateDiscovering : @(YES) };
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:adapterState];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getDevice:(CDVInvokedUrlCommand *)command {
    NSDictionary *arguments = [command.arguments firstObject];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:arguments[keyAddress]];
    NSArray *peripherals = [centralManager retrievePeripheralsWithIdentifiers:@[uuid]];
    
    if ([peripherals count]) {
        CBPeripheral *peripheral = peripherals[0];
        [peripheral readRSSI];
        deviceCallback = command.callbackId;
    }
}

- (void)getService:(CDVInvokedUrlCommand *)command {
    NSDictionary *arguments = [command.arguments firstObject];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:arguments[keyAddress]];
    NSArray *peripherals = [centralManager retrievePeripheralsWithIdentifiers:@[uuid]];
    if ([peripherals count]) {
        NSArray *services = [[peripherals firstObject] services];
        for (CBService *service in services) {
            BOOL isMatch = [self isUUIDString:service.UUID.UUIDString matchForUUIDString:arguments[keyServiceUuid]];
            if (isMatch) {
                Service *newService = [Service new];
                newService.uuid = service.UUID.UUIDString;
                newService.isPrimary = service.isPrimary;
                newService.instanceId = service.UUID.UUIDString;
                newService.deviceAddress = service.peripheral.identifier.UUIDString;
                NSDictionary *dictionaryRepresentation = [newService dictionaryRepresentation];
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dictionaryRepresentation];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
        }
    }
}

- (void)getCharacteristic:(CDVInvokedUrlCommand *)command {
    NSDictionary *arguments = [command.arguments firstObject];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:arguments[keyAddress]];
    NSArray *peripherals = [centralManager retrievePeripheralsWithIdentifiers:@[uuid]];
    if ([peripherals count]) {
        NSArray *services = [[peripherals firstObject] services];
        for (CBService *service in services) {
            BOOL isServiceMatch = [self isUUIDString:service.UUID.UUIDString matchForUUIDString:arguments[keyServiceUuid]];
            if (isServiceMatch) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    BOOL isCharacteristicMatch = [self isUUIDString:characteristic.UUID.UUIDString matchForUUIDString:arguments[keyCharacteristicUuid]];
                    if (isCharacteristicMatch) {
                        Characteristic *newCharacteristic = [Characteristic characteristicFromCBCharacteristic:characteristic];
                        NSDictionary *dictionaryRepresentation = [newCharacteristic dictionaryRepresentation];
                        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dictionaryRepresentation];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                    }
                }
            }
        }
    }
}


- (NSString *)boolStringForBool:(BOOL)boolean {
    if (boolean == 0)
        return @"false";
    return @"true";
}

- (BOOL)isUUIDString:(NSString *)UUID matchForUUIDString:(NSString *)otherUUID {
    BOOL isMatch = NO;
    if ([otherUUID length] == 4) {
        NSString *longForm = [NSString stringWithFormat:@"0000%@-0000-1000-8000-00805F9B34FB", [otherUUID uppercaseString]];
        isMatch = [UUID isEqualToString:longForm];
    } else {
        isMatch = [UUID isEqualToString:[otherUUID uppercaseString]];
    }
    return isMatch;
}

@end