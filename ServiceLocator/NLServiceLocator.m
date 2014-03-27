//
//  NLServiceLocator.m
//  ServiceLocator
//
//  Created by Nikita Leonov on 3/20/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Nikita Leonov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "NLServiceLocator.h"
#import <objc/runtime.h>

static NSString * const kNLServiceLocatorWarningOverridenByOtherWithProtocol = @"ServiceLocator| Warning: %@ overriden by %@ registered for protocol %@";
static NSString * const kNLServiceLocatorErrorNotRegisteredDoesNotConformAnyProtocol =  @"ServiceLocator| Error: Unable to register service %@ as it does not conform to any protocol.";
static NSString * const kNLServiceLocatorErrorNotRegisteredDoesNotConformProtocol = @"ServiceLocator| Error: Service %@ not resgitered as it does not conform to protocol %@.";
static NSString * const kNLServiceLocatorErrorServiceForProtocolNotRegistered = @"ServiceLocator| Error: Service for protocol %@ is not registered.";

static NSMutableDictionary *_servicesRegistry;
static dispatch_once_t onceToken;

@implementation NLServiceLocator

+ (void)checkOverrideByService:(id)service byProtocolWithName:(NSString *)protocolName {
    id currentServiceForProtocol = _servicesRegistry[protocolName];
    if (currentServiceForProtocol != nil && currentServiceForProtocol != service) {
        NSLog(kNLServiceLocatorWarningOverridenByOtherWithProtocol, currentServiceForProtocol, service, protocolName);
    }
}

+ (void)registerService:(id)service {
    dispatch_once(&onceToken, ^{
        _servicesRegistry = [[NSMutableDictionary alloc] init];
    });

    unsigned count;
    Protocol * __unsafe_unretained *pl = class_copyProtocolList([service class], &count);
    
    if (count == 0) {
        NSLog(kNLServiceLocatorErrorNotRegisteredDoesNotConformAnyProtocol, service);
    }
    
    for (unsigned i = 0; i < count; i++) {
        NSString *protocolName = [NSString stringWithUTF8String:protocol_getName(pl[i])];
        [NLServiceLocator checkOverrideByService:service byProtocolWithName:protocolName];
        _servicesRegistry[protocolName] = service;
    }
    
    free(pl);
}

+ (void)registerService:(id)service forProtocol:(Protocol *)protocol {
    dispatch_once(&onceToken, ^{
        _servicesRegistry = [[NSMutableDictionary alloc] init];
    });

    NSString *protocolName = [NSString stringWithUTF8String:protocol_getName(protocol)];
    [NLServiceLocator checkOverrideByService:service byProtocolWithName:protocolName];
    if (![service conformsToProtocol:protocol]) {
        NSLog(kNLServiceLocatorErrorNotRegisteredDoesNotConformProtocol, service, protocolName);
        return;
    }
    _servicesRegistry[protocolName] = service;
}

+ (id)serviceForProtocol:(Protocol *)protocol {
    id result;
    
    NSString *protocolName = [NSString stringWithUTF8String:protocol_getName(protocol)];
    result = _servicesRegistry[protocolName];
    
    if (result == nil) {
        NSLog(kNLServiceLocatorErrorServiceForProtocolNotRegistered, protocolName);
    }
    
    return result;
}

@end
