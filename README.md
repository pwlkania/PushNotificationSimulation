# PushNotificationSimulation

`PushNotificationSimulation` helps in simulating push notifications in the application during development.

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-green.svg?style=flat)](https://swift.org/)
[![Travis](https://travis-ci.org/pwlkania/PushNotificationSimulation.svg?branch=master)](https://travis-ci.org/pwlkania/PushNotificationSimulation.svg?branch=master)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PushNotificationSimulation.svg)](https://cocoapods.org/pods/PushNotificationSimulation)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/PushNotificationSimulation.svg)](http://cocoadocs.org/docsets/PushNotificationSimulation)
[![License](https://img.shields.io/cocoapods/l/PushNotificationSimulation.svg)](https://github.com/PGSSoft/PushNotificationSimulation)

## Installation

Using [Cocoapods](https://cocoapods.org/) with Podfile:

```ruby
pod 'PushNotificationSimulation'
```

or using [Carthage](https://github.com/Carthage/Carthage) and add a line to `Cartfile`:

```
github "pwlkania/PushNotificationSimulation"
```

or Swift Package Manager (Xcode 11):

Coming soon!

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

Using breakpoints with debugger command (suggested approach) - example:

```
e simPush(payload: "{\"aps\":{\"alert\":{\"title\":\"Game Request\",\"subtitle\":\"Five Card Draw\",\"body\":\"Bob wants to play poker\"},\"category\":\"GAME_INVITATION\"},\"gameID\":\"12345678\"}", delay: 3)
```

![Breakpoint.png](Breakpoint.png)

You can also use `simPush(...)` global function directly in the code. However it might cause issues when code is not deactivated in production version of your application. Be careful.

![Code.png](Code.png)

## License

The project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
