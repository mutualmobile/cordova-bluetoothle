//
//  BluetoothTypes.h
//  BluetoothleTests
//
//  Created by Andrew Frederick on 9/18/14.
//
//

#import <Foundation/Foundation.h>

@class CBCharacteristic;

@interface BaseReturnObjectType : NSObject

- (NSDictionary *)dictionaryRepresentation;

@end

@interface AdapterState : BaseReturnObjectType

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) bool enabled;
@property (nonatomic) bool discovering;

@end

@interface Device : BaseReturnObjectType

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger rssi;
@property (nonatomic) bool connected;
@property (nonatomic, copy) NSArray *uuids;

@end

@interface Service : BaseReturnObjectType

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic) bool isPrimary;
@property (nonatomic, copy) NSString *instanceId;
@property (nonatomic, copy) NSString *deviceAddress;

@end

@interface Characteristic : BaseReturnObjectType

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *service;
@property (nonatomic, copy) NSArray *properties;
@property (nonatomic, copy) NSString *instanceId;
@property (nonatomic, copy) NSString *value;

+ (instancetype)characteristicFromCBCharacteristic:(CBCharacteristic *)cbCharacteristic;
- (void)setValueWithData:(NSData *)data;

@end

