//
//  CBCentralManager+Rx.swift
//  IO
//
//  Created by won on 30/06/2017.
//  Copyright © 2017 IO inc. All rights reserved.
//

import CoreBluetooth
import RxSwift
import RxCocoa

extension CBCentralManager {

	/// Factory method that enables subclasses to implement their own `delegate`.
	///
	/// - returns: Instance of delegate proxy that wraps `delegate`.
	public func createRxDelegateProxy() -> RxCBCentralManagerDelegateProxy {
		return RxCBCentralManagerDelegateProxy(parentObject: self)
	}
}

public typealias Discovered = (peripheral: CBPeripheral, advertisementData: [String : Any], RSSI: NSNumber)
public typealias PeripheralAndError = (peripheral: CBPeripheral, error: Error?)

extension Reactive where Base: CBCentralManager {

	public var delegate: DelegateProxy {
		return RxCBCentralManagerDelegateProxy.proxyForObject(base)
	}

	public var state: Observable<CBManagerState> {
		let proxy = RxCBCentralManagerDelegateProxy.proxyForObject(base)
		return proxy.stateBehaviorSubject.skip(1)
	}

	/// For more information take a look at `CBCentralManagerDelegate`.
	public var willRestoreState: Observable<[String : Any]> {
		return Observable.deferred { [unowned source = self.base as CBCentralManager] () -> Observable<[String : Any]> in
			return source.rx.delegate.methodInvoked(#selector(CBCentralManagerDelegate.centralManager(_:willRestoreState:)))
				.map({
					/// $0[0] CBCentralManager
					/// $0[1] willRestoreState dict
					guard let dict: [String: Any] = $0[1] as? [String: Any] else { fatalError() }
					return dict
				})
		}
	}

	/// For more information take a look at `CBCentralManagerDelegate`.
	public var didDiscover: Observable<Discovered> {
		return Observable.deferred { [unowned source = self.base as CBCentralManager] () -> Observable<Discovered> in
				return source.rx.delegate.methodInvoked(#selector(CBCentralManagerDelegate.centralManager(_:didDiscover:advertisementData:rssi:)))
					.map({
						/// $0[0] CBCentralManager
						/// $0[1] CBPeripheral
						/// $0[2] advertisementData
						/// $0[3] RSSI
						guard let peripheral: CBPeripheral = $0[1] as? CBPeripheral else { fatalError() }
						guard let advertisementData: [String: Any] = $0[2] as? [String: Any] else { fatalError() }
						guard let RSSI: NSNumber = $0[3] as? NSNumber else { fatalError() }
						let discovered: Discovered = (peripheral: peripheral, advertisementData: advertisementData, RSSI: RSSI)
					return discovered
				})
		}
	}

	/// For more information take a look at `CBCentralManagerDelegate`.
	public var didConnect: Observable<CBPeripheral> {
		return Observable.deferred({ [unowned source = self.base as CBCentralManager] () -> Observable<CBPeripheral> in
			return source.rx.delegate.methodInvoked(#selector(CBCentralManagerDelegate.centralManager(_:didConnect:)))
				.map({
					/// $0[0] CBCentralManager
					/// $0[1] CBPeripheral
					guard let peripheral = $0[1] as? CBPeripheral else { fatalError() }
					return peripheral
			})
		})
	}

	/// For more information take a look at `CBCentralManagerDelegate`.
	public var didFailToConnect: Observable<PeripheralAndError> {
		return Observable.deferred({ [unowned source = self.base as CBCentralManager] () -> Observable<PeripheralAndError> in
			return source.rx.delegate.methodInvoked(#selector(CBCentralManagerDelegate.centralManager(_:didFailToConnect:error:)))
				.map({
					/// $0[0] CBCentralManager
					/// $0[1] CBPeripheral
					/// $0[2] Error?
					guard let peripheral = $0[1] as? CBPeripheral else { fatalError() }
					return (peripheral: peripheral, error: $0[2] as? Error)
			})
		})
	}

	/// For more information take a look at `CBCentralManagerDelegate`.
	public var didDisconnect: Observable<PeripheralAndError> {
		return Observable.deferred({ [unowned source = self.base as CBCentralManager] () -> Observable<PeripheralAndError> in
			return source.rx.delegate.methodInvoked(#selector(CBCentralManagerDelegate.centralManager(_:didDisconnectPeripheral:error:)))
				.map({
					/// $0[0] CBCentralManager
					/// $0[1] CBPeripheral
					/// $0[2] Error?
					guard let peripheral = $0[1] as? CBPeripheral else { fatalError() }
					return (peripheral: peripheral, error: $0[2] as? Error)
				})
		})
	}

	public func setDelegate(_ delegate: CBCentralManagerDelegate)
		-> Disposable {
			return RxCBCentralManagerDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
	}
}

extension Reactive where Base: CBCentralManager {
	func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String : Any]? = nil) -> Observable<Discovered> {
    return Observable.deferred { [unowned source = self.base as CBCentralManager] () -> Observable<Discovered> in
      return source.rx.delegate.methodInvoked(#selector(CBCentralManagerDelegate.centralManager(_:didDiscover:advertisementData:rssi:)))
        .map({
          /// $0[0] CBCentralManager
          /// $0[1] CBPeripheral
          /// $0[2] advertisementData
          /// $0[3] RSSI
          guard let peripheral: CBPeripheral = $0[1] as? CBPeripheral else { fatalError() }
          guard let advertisementData: [String: Any] = $0[2] as? [String: Any] else { fatalError() }
          guard let RSSI: NSNumber = $0[3] as? NSNumber else { fatalError() }
          let discovered: Discovered = (peripheral: peripheral, advertisementData: advertisementData, RSSI: RSSI)
          return discovered
        })
    }
	}
}
