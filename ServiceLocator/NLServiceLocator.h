//
//  NLServiceLocator.h
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

#import <Foundation/Foundation.h>

/**
 Implementation of Service Locator design pattern that allows implicitly or explicitly register services with use of protocols and retrieve them later with use of the same protocols.
 */
@interface NLServiceLocator : NSObject

/**
    @brief Implicit registration of service in service locator for each of the protocols that class conforms.
 
    @attention All the services that are already registered under protocols that currently registering class conforms will be overriden. To avoid collisions "explicit" registering could be used.
 
    @param service Service that will be registered in service locator. Service should conforms at least one protocol to be registered.
*/
+ (void)registerService:(id)service;

/**
 @brief Explicit registration of service in service locator only for protocol provided as method parameter.
 
 @attention Service will not be registered if service do not conforms provided protocol.
 
 @param service Service that will be registered in service locator.

 @param service Protocol that service conforms and will be used for registration.

*/
+ (void)registerService:(id)service forProtocol:(Protocol *)protocol;

/**
 @brief Provides service by protocol that it conforms and used for registration implicitly or explicitly.
 
 @param protocol Protocol that will be used for location of service from registry.
 */
+ (id)serviceForProtocol:(Protocol *)protocol;

@end
