Objective C Service Locator
===============

## Overview
Implementation of Service Locator design pattern for Objective C. 

## Usage
Register your service for protocol(s) implicitly or explicitly:
```
[NLServiceLocator registerService:myService];
[NLServiceLocator registerService:myService forProtocol:@protocol(NLSampleService)];
```

Retrieve services later when you need them by referencing protocol that it conforms and was used for implicit or explicit registration:
```
id<NLSampleService> myService = [NLServiceLocator serviceForProtocol:@(NLSampleService)];
```

Done. Enjoy your nicely developed, loosely coupled architecture with an opportunity to replace service by its alternatives in a runtime. Just use it to make your code more managable, or simplify testing by providing mock services with couple of code lines. 

## Installation

```
pod "NLServiceLocator"
```

## License

NLServiceLocator is available under the MIT license. See the LICENSE file for more info.