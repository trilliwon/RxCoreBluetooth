# RxCoreBluetooth

RxCoreBluetooth is a CoreBluetooth Extension for RxSwift

---

## Usage

```
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
