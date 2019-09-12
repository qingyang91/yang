//
//  QMUIRuntime.m
//  QMUIKit
//
//  Created by MoLice on 2018/9/5.
//  Copyright © 2018年 QMUI Team. All rights reserved.
//

#import "QMUIRuntime.h"

@implementation QMUIPropertyDescriptor

+ (instancetype)descriptorWithProperty:(objc_property_t)property {
    QMUIPropertyDescriptor *descriptor = [[QMUIPropertyDescriptor alloc] init];
    NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
    descriptor.name = propertyName;
    
    // getter
    char *getterChar = property_copyAttributeValue(property, "G");
    descriptor.getter = NSSelectorFromString(getterChar != NULL ? [NSString stringWithUTF8String:getterChar] : propertyName);
    
    // setter
    char *setterChar = property_copyAttributeValue(property, "S");
    NSString *setterString = setterChar != NULL ? [NSString stringWithUTF8String:setterChar] : [QMUIPropertyDescriptor defaultSetterStringWithPropertyName:propertyName];
    descriptor.setter = NSSelectorFromString(setterString);
    
    // atomic/nonatomic
    BOOL isAtomic = property_copyAttributeValue(property, "N") == NULL;
    descriptor.isAtomic = isAtomic;
    descriptor.isNonatomic = !isAtomic;
    
    // assign/weak/strong/copy
    BOOL isCopy = property_copyAttributeValue(property, "C") != NULL;
    BOOL isStrong = property_copyAttributeValue(property, "&") != NULL;
    BOOL isWeak = property_copyAttributeValue(property, "W") != NULL;
    descriptor.isCopy = isCopy;
    descriptor.isStrong = isStrong;
    descriptor.isWeak = isWeak;
    descriptor.isAssign = !isCopy && !isStrong && !isWeak;
    
    // readonly/readwrite
    BOOL isReadonly = property_copyAttributeValue(property, "R") != NULL;
    descriptor.isReadonly = isReadonly;
    descriptor.isReadwrite = !isReadonly;
    
    // type
    char *type = property_copyAttributeValue(property, "T");
    descriptor.type = [QMUIPropertyDescriptor typeWithEncodeString:[NSString stringWithUTF8String:type]];
    
    return descriptor;
}

- (NSString *)description {
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:@"@property("];
    if (self.isNonatomic) [result appendString:@"nonatomic, "];
    [result appendString:self.isAssign ? @"assign" : (self.isWeak ? @"weak" : (self.isStrong ? @"strong" : @"copy"))];
    if (self.isReadonly) [result appendString:@", readonly"];
    if (![NSStringFromSelector(self.getter) isEqualToString:self.name]) [result appendFormat:@", getter=%@", NSStringFromSelector(self.getter)];
    if (self.setter != NSSelectorFromString([QMUIPropertyDescriptor defaultSetterStringWithPropertyName:self.name])) [result appendFormat:@", setter=%@", NSStringFromSelector(self.setter)];
    [result appendString:@") "];
    [result appendString:self.type];
    [result appendString:@" "];
    [result appendString:self.name];
    [result appendString:@";"];
    return result.copy;
}

+ (NSString *)defaultSetterStringWithPropertyName:(NSString *)propertyName {
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"set"];
    [string appendString:[propertyName substringToIndex:1].uppercaseString];
    [string appendString:[propertyName substringFromIndex:1]];
    [string appendString:@":"];
    return string.copy;
}

#define _DetectTypeAndReturn(_type) if (strncmp(@encode(_type), typeEncoding, strlen(@encode(_type))) == 0) return @#_type;

+ (NSString *)typeWithEncodeString:(NSString *)encodeString {
    if ([encodeString containsString:@"@\""]) {
        NSString *result = [encodeString substringWithRange:NSMakeRange(2, encodeString.length - 2 - 1)];
        if ([result containsString:@"<"] && [result containsString:@">"]) {
            // protocol
            if ([result hasPrefix:@"<"]) {
                // id pointer
                return [NSString stringWithFormat:@"id%@", result];
            }
        }
        // class
        return [NSString stringWithFormat:@"%@ *", result];
    }
    
    const char *typeEncoding = encodeString.UTF8String;
    _DetectTypeAndReturn(NSInteger)
    _DetectTypeAndReturn(NSUInteger)
    _DetectTypeAndReturn(int)
    _DetectTypeAndReturn(short)
    _DetectTypeAndReturn(long)
    _DetectTypeAndReturn(long long)
    _DetectTypeAndReturn(char)
    _DetectTypeAndReturn(unsigned char)
    _DetectTypeAndReturn(unsigned int)
    _DetectTypeAndReturn(unsigned short)
    _DetectTypeAndReturn(unsigned long)
    _DetectTypeAndReturn(unsigned long long)
    _DetectTypeAndReturn(CGFloat)
    _DetectTypeAndReturn(float)
    _DetectTypeAndReturn(double)
    _DetectTypeAndReturn(void)
    _DetectTypeAndReturn(char *)
    _DetectTypeAndReturn(id)
    _DetectTypeAndReturn(Class)
    _DetectTypeAndReturn(SEL)
    _DetectTypeAndReturn(BOOL)
    
    return encodeString;
}

@end
