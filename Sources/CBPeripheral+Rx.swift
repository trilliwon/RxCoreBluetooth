//
//  CBPeripheral+Rx.swift
//  IO
//
//  Created by won on 04/07/2017.
//  Copyright © 2017 IO inc. All rights reserved.
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

public typealias RSSIAndError = (RSSI: NSNumber, error: Error?)
public typealias ServiceAndError = (service: CBService, error: Error?)
public typealias CharacteristicAndError = (characteristic: CBCharacteristic, error: Error?)
public typealias DescriptorAndError = (descriptor: CBDescriptor, error: Error?)

extension Reactive where Base: CBPeripheral {

	public var delegate: DelegateProxy {
		return RxCBPeripheralDelegateProxy.proxyForObject(base)
	}

	public var didUpdateName: Observable<Void> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<Void> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheralDidUpdateName(_:)))
				.map({ _ in })
		}
	}

	public var didModifyServices: Observable<[CBService]> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<[CBService]> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didModifyServices:)))
				.map({
					/// $0[0] CBPeripheral
					/// $0[1] invalidatedServices: [CBService]
					guard let invalidatedServices = $0[1] as? [CBService] else { fatalError() }
					return invalidatedServices
				})
		}
	}

	public var didReadRSSI: Observable<RSSIAndError> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<RSSIAndError> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didReadRSSI:error:)))
				.map({
					guard let RSSI = $0[1] as? NSNumber else { fatalError() }
					return (RSSI: RSSI, error: $0[2] as? Error)
				})
		}
	}

	public var didDiscoverServices: Observable<Error?> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<Error?> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverServices:)))
				.map({
					return $0[1] as? Error
				})
		}
	}

	public var didDiscoverIncludedServices: Observable<ServiceAndError> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<ServiceAndError> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverIncludedServicesFor:error:)))
				.map({
					guard let service = $0[1] as? CBService else { fatalError() }
					return (service: service, error: $0[2] as? Error)
				})
		}
	}

	public var didDiscoverCharacteristics: Observable<ServiceAndError> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<ServiceAndError> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverCharacteristicsFor:error:)))
				.map({
					guard let service = $0[1] as? CBService else { fatalError() }
					return (service: service, error: $0[2] as? Error)
				})
		}
	}

	public var didUpdateValueForCharacteristic: Observable<CharacteristicAndError> {
		let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
		return proxy.didUpdateValueForCharacteristicPublishSubject
	}

	public var didUpdateValueForDescriptor: Observable<DescriptorAndError> {
		let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
		return proxy.didUpdateValueForDescriptorPublishSubject
	}

	public var didWriteValueForCharacteristic: Observable<CharacteristicAndError> {
		let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
		return proxy.didWriteValueForCharacteristicPublishSubject
	}

	public var didWriteValueForDescriptor: Observable<DescriptorAndError> {
		let proxy = RxCBPeripheralDelegateProxy.proxyForObject(base)
		return proxy.didWriteValueForDescriptorPublishSubject
	}

	public var didUpdateNotificationState: Observable<CharacteristicAndError> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<CharacteristicAndError> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didUpdateNotificationStateFor:error:)))
				.map({
					guard let characteristic = $0[1] as? CBCharacteristic else { fatalError() }
					return (characteristic: characteristic, error: $0[2] as? Error)
				})
		}
	}

	public var didDiscoverDescriptors: Observable<DescriptorAndError> {
		return Observable.deferred { [unowned source = self.base as CBPeripheral] () -> Observable<DescriptorAndError> in
			return source.rx.delegate.methodInvoked(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverDescriptorsFor:error:)))
				.map({
					guard let descriptor = $0[1] as? CBDescriptor else { fatalError() }
					return (descriptor: descriptor, error: $0[2] as? Error)
				})
		}
	}
}
