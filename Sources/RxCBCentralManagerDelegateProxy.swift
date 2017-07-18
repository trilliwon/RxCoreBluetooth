//
//  RxCBCentralManagerDelegateProxy.swift
//  IO
//
//  Created by won on 03/07/2017.
//  Copyright © 2017 IO inc. All rights reserved.
//

import CoreBluetooth
import RxSwift
import RxCocoa

public class RxCBCentralManagerDelegateProxy: DelegateProxy, CBCentralManagerDelegate, DelegateProxyType {

	/// Typed parent object.
	public weak fileprivate(set) var central: CBCentralManager?

	/// Initializes `RxCBCentralManagerDelegateProxy`
	///
	/// - parameter parentObject: Parent object for delegate proxy.
	public required init(parentObject: AnyObject) {
		self.central = parentObject as? CBCentralManager
		super.init(parentObject: parentObject)
	}

	fileprivate var _stateBehaviorSubject: BehaviorSubject<CBManagerState>?

	internal var stateBehaviorSubject: BehaviorSubject<CBManagerState> {
		if let subject = _stateBehaviorSubject {
			return subject
		}

		let subject = BehaviorSubject<CBManagerState>(value: self.central?.state ?? .unknown)
		_stateBehaviorSubject = subject
		return subject
	}

	// MARK: delegate methods

	public func centralManagerDidUpdateState(_ central: CBCentralManager) {
		self._stateBehaviorSubject?.onNext(central.state)
		self._forwardToDelegate?.centralManagerDidUpdateState(central)
	}

	// MARK: delegate proxy

	public override class func createProxyForObject(_ object: AnyObject) -> AnyObject {
		guard let central: CBCentralManager = object as? CBCentralManager else { fatalError() }
		return central.createRxDelegateProxy()
	}

	public static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
		guard let central: CBCentralManager = object as? CBCentralManager else { fatalError() }
		central.delegate = delegate as? CBCentralManagerDelegate
	}

	public static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
		guard let central: CBCentralManager = object as? CBCentralManager else { fatalError() }
		return central.delegate
	}

	deinit {
		if let subject = _stateBehaviorSubject {
			subject.on(.completed)
		}
	}
}
