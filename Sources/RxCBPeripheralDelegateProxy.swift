//
//  RxCBPeripheralDelegateProxy.swift
//  IO
//
//  Created by won on 04/07/2017.
//  Copyright © 2017 IO inc. All rights reserved.
//

import CoreBluetooth
import RxSwift
import RxCocoa

public class RxCBPeripheralDelegateProxy: DelegateProxy, CBPeripheralDelegate, DelegateProxyType {
  /// Typed parent object.
  public weak fileprivate(set) var peripheral: CBPeripheral?

  var didUpdateValueForCharacteristicPublishSubject = PublishSubject<(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: Error?)>()
  var didUpdateValueForDescriptorPublishSubject = PublishSubject<(peripheral: CBPeripheral, descriptor: CBDescriptor, error: Error?)>()

  var didWriteValueForCharacteristicPublishSubject = PublishSubject<(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: Error?)>()
  var didWriteValueForDescriptorPublishSubject = PublishSubject<(peripheral: CBPeripheral, descriptor: CBDescriptor, error: Error?)>()

  /// Initializes `RxCBCentralManagerDelegateProxy`
  ///
  /// - parameter parentObject: Parent object for delegate proxy.
  public required init(parentObject: AnyObject) {
    self.peripheral = parentObject as? CBPeripheral
    super.init(parentObject: parentObject)
  }

  // MARK: delegate proxy

  public override class func createProxyForObject(_ object: AnyObject) -> AnyObject {
    guard let peripheral: CBPeripheral = object as? CBPeripheral else { fatalError() }
    return peripheral.createRxDelegateProxy()
  }

  public static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
    guard let central: CBPeripheral = object as? CBPeripheral else { fatalError() }
    central.delegate = delegate as? CBPeripheralDelegate
  }

  public static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
    guard let peripheral: CBPeripheral = object as? CBPeripheral else { fatalError() }
    return peripheral.delegate
  }

  public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    didUpdateValueForCharacteristicPublishSubject.onNext((peripheral, characteristic, error))
  }

  public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
    didUpdateValueForDescriptorPublishSubject.onNext((peripheral, descriptor, error))
  }

  public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
    didWriteValueForCharacteristicPublishSubject.onNext((peripheral, characteristic, error))
  }

  public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
    didWriteValueForDescriptorPublishSubject.onNext((peripheral, descriptor, error))
  }
}
