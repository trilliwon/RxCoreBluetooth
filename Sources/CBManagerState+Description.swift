//
//  CBManagerState+Description.swift
//  RxCoreBluetooth
//
//  Created by won on 18/07/2017.
//  Copyright © 2017 trilliwon. All rights reserved.
//

import CoreBluetooth

/*!
 *  @enum CBManagerState
 *
 *  @discussion Represents the current state of a CBManager.
 *
 *  @constant CBManagerStateUnknown       State unknown, update imminent.
 *  @constant CBManagerStateResetting     The connection with the system service was momentarily lost, update imminent.
 *  @constant CBManagerStateUnsupported   The platform doesn't support the Bluetooth Low Energy Central/Client role.
 *  @constant CBManagerStateUnauthorized  The application is not authorized to use the Bluetooth Low Energy role.
 *  @constant CBManagerStatePoweredOff    Bluetooth is currently powered off.
 *  @constant CBManagerStatePoweredOn     Bluetooth is currently powered on and available to use.
 *
 */

extension CBManagerState: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
    case .unknown:
      return "State unknown, update imminent."
    case .resetting:
      return "The connection with the system service was momentarily lost, update imminent."
    case .unsupported:
      return "The platform doesn't support the Bluetooth Low Energy Central/Client role."
    case .unauthorized:
      return "The application is not authorized to use the Bluetooth Low Energy role."
    case .poweredOff:
      return "Bluetooth is currently powered off."
    case .poweredOn:
      return "Bluetooth is currently powered on and available to use."
    }
  }
}
