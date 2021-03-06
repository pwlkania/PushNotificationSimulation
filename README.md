# PushNotificationSimulation

`PushNotificationSimulation` helps in simulating push notifications in the application during development.

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange)](https://swift.org/)
[![Travis](https://travis-ci.org/pwlkania/PushNotificationSimulation.svg?branch=master)](https://travis-ci.org/pwlkania/PushNotificationSimulation.svg?branch=master)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PushNotificationSimulation.svg)](https://cocoapods.org/pods/PushNotificationSimulation)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-supported-brightgreen)](https://swift.org/package-manager/)
[![Platform](https://img.shields.io/cocoapods/p/PushNotificationSimulation.svg)](http://cocoadocs.org/docsets/PushNotificationSimulation)
[![License](https://img.shields.io/cocoapods/l/PushNotificationSimulation.svg)](https://github.com/pwlkania/PushNotificationSimulation/blob/master/LICENSE)

## Installation

Using [Cocoapods](https://cocoapods.org/) with Podfile:

```ruby
pod 'PushNotificationSimulation'
```

or [Carthage](https://github.com/Carthage/Carthage) and add a line to `Cartfile`:

```ruby
github "pwlkania/PushNotificationSimulation"
```

or [Swift Package Manager](https://github.com/apple/swift-package-manager) (from Xcode 11):

```
File > Swift Packages > Add Package Dependency...
```

and add

```
git@github.com:pwlkania/PushNotificationSimulation.git
```

## Requirements

iOS 11.0

## Initialization

Modify your `AppDelegate.swift` file:

Import `PushNotificationSimulation` framework (if needed):

```swift
import PushNotificationSimulation
```

Implement `PushNotificationSimulation` protocol:

```swift
#if DEBUG
extension AppDelegate: PushNotificationSimulation { }
#endif
```

## Usage

Using breakpoints with debugger command (suggested approach). 

Push notification example:

```Swift
sim(payload: "{\"aps\":{\"alert\":{\"title\":\"Game Request\",\"subtitle\":\"Five Card Draw\",\"body\":\"Bob wants to play poker\"},\"category\":\"GAME_INVITATION\"},\"gameID\":\"12345678\"}", delay: 3)
```

![Payload.png](Payload.png)

Device token example:

```Swift
sim(deviceToken: "933e3112d1eae4a1d8eb48617a265b303be28b300193b9677f0ccf52a63a5b1e")
```

![DeviceToken.png](DeviceToken.png)

You can also use `sim(payload: ...)` or `sim(deviceToken: ...)` global functions directly in the code. However it might cause issues when code is not deactivated in production version of your application. Be careful.

## License

The project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
