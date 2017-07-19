//
//  CBPeripheral+Rx.swift
//  trilliwon
//
//  Created by won on 04/07/2017.
//  Copyright © 2017 trilliwon inc. All rights reserved.
//

import CoreBluetooth
import RxSwift
import RxCocoa

extension CBPeripheral {

  /// Factory method that enables subclasses to implement their own `delegate`.
  ///
  /// - returns: Instance of delegate proxy that wraps `delegate`.
  public func createRxDelegateProxy() -> RxCBPeripheralDelegateProxy {
    return RxCBPeripheralDelegateProxy(parentObject: self)
  }
}

extension Reactive where Base: CBPeripheral {

  public var delegate: DelegateProxy {
    return RxCBPeripheralDelegateProxy.proxyForObject(base)
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didUpdateName: Observable<CBPeripheral> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<CBPeripheral> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheralDidUpdateName(_:)))
        .map({
          /// $0[0] CBPeripheral
          guard let peripheral = $0[0] as? CBPeripheral else { fatalError() }
          return peripheral
        })
    }
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didModifyServices: Observable<(peripheral: CBPeripheral, invalidatedServices: [CBService])> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<(peripheral: CBPeripheral, invalidatedServices: [CBService])> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didModifyServices:)))
        .map({
          /// $0[0] CBPeripheral
          /// $0[1] invalidatedServices: [CBService]
          guard let peripheral = $0[0] as? CBPeripheral else { fatalError() }
          guard let invalidatedServices = $0[1] as? [CBService] else { fatalError() }
          return (peripheral, invalidatedServices)
        })
    }
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didReadRSSI: Observable<(peripheral: CBPeripheral, RSSI: NSNumber, error: Error?)> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<(peripheral: CBPeripheral, RSSI: NSNumber, error: Error?)> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didReadRSSI:error:)))
        .map({
          /// $0[0] CBPeripheral
          /// $0[1] RSSI
          /// $0[2] error?
          guard let peripheral = $0[0] as? CBPeripheral else { fatalError() }
          guard let RSSI = $0[1] as? NSNumber else { fatalError() }
          return (peripheral, RSSI, $0[2] as? Error)
        })
    }
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didDiscoverServices: Observable<(peripheral: CBPeripheral, error: Error?)> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<(peripheral: CBPeripheral, error: Error?)> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverServices:)))
        .map({
          /// $0[0] CBPeripheral
          /// $0[1] error?
          guard let peripheral = $0[0] as? CBPeripheral else { fatalError() }
          return (peripheral, $0[1] as? Error)
        })
    }
  }

  public var didDiscoverIncludedServices: Observable<(peripheral: CBPeripheral, service: CBService, error: Error?)> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<(peripheral: CBPeripheral, service: CBService, error: Error?)> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverIncludedServicesFor:error:)))
        .map({
          /// $0[0] CBPeripheral
          /// $0[1] service
          /// $0[2] error?
          guard let service = $0[1] as? CBService else { fatalError() }
          return (source, service, $0[2] as? Error)
        })
    }
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didDiscoverCharacteristics: Observable<(peripheral: CBPeripheral, service: CBService, error: Error?)> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<(peripheral: CBPeripheral, service: CBService, error: Error?)> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverCharacteristicsFor:error:)))
        .map({
          /// $0[0] CBPeripheral
          /// $0[1] service
          /// $0[2] error?
          guard let service = $0[1] as? CBService else { fatalError() }
          return (source, service, $0[2] as? Error)
        })
    }
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didUpdateValueForCharacteristic: Observable<(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: Error?)> {
    let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
    return proxy.didUpdateValueForCharacteristicPublishSubject
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didUpdateValueForDescriptor: Observable<(peripheral: CBPeripheral, descriptor: CBDescriptor, error: Error?)> {
    let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
    return proxy.didUpdateValueForDescriptorPublishSubject
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didWriteValueForCharacteristic: Observable<(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: Error?)> {
    let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
    return proxy.didWriteValueForCharacteristicPublishSubject
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didWriteValueForDescriptor: Observable<(peripheral: CBPeripheral, descriptor: CBDescriptor, error: Error?)> {
    let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
    return proxy.didWriteValueForDescriptorPublishSubject
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didUpdateNotificationState: Observable<(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: Error?)> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: Error?)> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didUpdateNotificationStateFor:error:)))
        .map({
          /// $0[0] CBPeripheral
          /// $0[1] CBCharacteristic
          /// $0[2] error?
          guard let characteristic = $0[1] as? CBCharacteristic else { fatalError() }
          return (source, characteristic, $0[2] as? Error)
        })
    }
  }

  /// For more information take a look at `CBPeripheralDelegate`.
  public var didDiscoverDescriptors: Observable<(peripheral: CBPeripheral, descriptor: CBDescriptor, error: Error?)> {
    return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<(peripheral: CBPeripheral, descriptor: CBDescriptor, error: Error?)> in
      return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverDescriptorsFor:error:)))
        .map({
          /// $0[0] CBPeripheral
          /// $0[1] CBDescriptor
          /// $0[2] error?
          guard let descriptor = $0[1] as? CBDescriptor else { fatalError() }
          return (source, descriptor, $0[2] as? Error)
        })
    }
  }
}
