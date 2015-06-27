//
//  BluetoothTypes.m
//  BluetoothleTests
//
//  Created by Andrew Frederick on 9/18/14.
//
//

#import "BaseReturnObjectType.h"
#import <objc/runtime.h>
#import <CoreBluetooth/CoreBluetooth.h>

@implementation BaseReturnObjectType

- (NSDictionary *)dictionaryRepresentation {
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++) {
        const char *propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    return [self dictionaryWithValuesForKeys:propertyArray];
}

@end

@implementation AdapterState
@end

@implementation Device
@end

@implementation Service
@end

@implementation Characteristic

+ (instancetype)characteristicFromCBCharacteristic:(CBCharacteristic *)cbCharacteristic {
    Characteristic *newCharacteristic = [Characteristic new];
    newCharacteristic.uuid = cbCharacteristic.UUID.UUIDString;
    newCharacteristic.service = cbCharacteristic.service.UUID.UUIDString;
    newCharacteristic.properties = [self stringPropertiesForCharactersiticProperty:cbCharacteristic.properties];
    newCharacteristic.instanceId = cbCharacteristic.UUID.UUIDString;
    [newCharacteristic setValueWithData:cbCharacteristic.value];
    return newCharacteristic;
}

+ (NSArray *)stringPropertiesForCharactersiticProperty:(CBCharacteristicProperties)properties {
    NSMutableArray *strings = [NSMutableArray new];
    if ((properties & CBCharacteristicPropertyBroadcast) == CBCharacteristicPropertyBroadcast) {
        [strings addObject:@"broadcast"];
    }
    if ((properties & CBCharacteristicPropertyRead) == CBCharacteristicPropertyRead) {
        [strings addObject:@"read"];
    }
    if ((properties & CBCharacteristicPropertyWriteWithoutResponse) == CBCharacteristicPropertyWriteWithoutResponse) {
        [strings addObject:@"writeWithoutResponse"];
    }
    if ((properties & CBCharacteristicPropertyWrite) == CBCharacteristicPropertyWrite) {
        [strings addObject:@"write"];
    }
    if ((properties & CBCharacteristicPropertyNotify) == CBCharacteristicPropertyNotify) {
        [strings addObject:@"notify"];
    }
    if ((properties & CBCharacteristicPropertyIndicate) == CBCharacteristicPropertyIndicate) {
        [strings addObject:@"indicate"];
    }
    if ((properties & CBCharacteristicPropertyAuthenticatedSignedWrites) == CBCharacteristicPropertyAuthenticatedSignedWrites) {
        [strings addObject:@"authenticatedSignedWrites"];
    }
    if ((properties & CBCharacteristicPropertyExtendedProperties) == CBCharacteristicPropertyExtendedProperties) {
        [strings addObject:@"extendedProperties"];
    }
    if ((properties & CBCharacteristicPropertyNotifyEncryptionRequired) == CBCharacteristicPropertyNotifyEncryptionRequired) {
        [strings addObject:@"reliableWrite"];
    }
    if ((properties & CBCharacteristicPropertyIndicateEncryptionRequired) == CBCharacteristicPropertyIndicateEncryptionRequired) {
        [strings addObject:@"writableAuxiliaries"];
    }
    return [strings copy];
}

- (void)setValueWithData:(NSData *)data {
    self.value = [data base64EncodedStringWithOptions:0];
}

@end