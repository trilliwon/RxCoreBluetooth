# RxCoreBluetooth

RxCoreBluetooth is RxSwift Extension of CoreBluetooth


### Usage

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
