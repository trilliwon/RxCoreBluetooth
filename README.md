# RxCoreBluetooth

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![CI Status](http://img.shields.io/travis/trilliwon/RxCoreBluetooth.svg?style=flat)](https://travis-ci.org/trilliwon/RxCoreBluetooth)
![spm](https://img.shields.io/badge/SPM-ready-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/RxCoreBluetooth.svg?style=flat)](http://cocoapods.org/pods/RxCoreBluetooth)
[![codecov](https://codecov.io/gh/trilliwon/RxCoreBluetooth/branch/master/graph/badge.svg)](https://codecov.io/gh/trilliwon/RxCoreBluetooth)
[![License](https://img.shields.io/cocoapods/l/RxCoreBluetooth.svg?style=flat)](http://cocoapods.org/pods/RxCoreBluetooth)
[![Platform](https://img.shields.io/cocoapods/p/RxCoreBluetooth.svg?style=flat)](http://cocoapods.org/pods/RxCoreBluetooth)

RxCoreBluetooth is a CoreBluetooth Extension for RxSwift

---

## Usage

```Swift
/// Bind CBManager State
centralManager.rx.state
.bind { state in
  state == .powerOn
}.disposed(by: disposeBag)


/// Bind Discovered Peripheral
centralManager.rx
.didDiscover
.bind { discovered in
  discovered
}
.disposed(by: disposeBag)

```

## Requirements

+ iOS 10.0 +
+ Swift 3.0 +
+ Xcode 8.0 +


## Installation

RxCoreBluetooth is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxCoreBluetooth', :git => 'https://github.com/trilliwon/RxCoreBluetooth.git'
```

##### - For CBCentralManager Delegates
![CentralManager](https://github.com/trilliwon/RxCoreBluetooth/blob/master/images/central.png?raw=true)



##### - For CBPeripheral Delegates
![Peripheral](https://github.com/trilliwon/RxCoreBluetooth/blob/master/images/peripheral.png?raw=true)

---

## Author

Won, trilliwon@gmail.com

---

## License

RxCoreBluetooth is available under the MIT license. See the LICENSE file for more info.
