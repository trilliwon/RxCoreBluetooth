//
//  ViewController.swift
//  RxCoreBluetooth
//
//  Created by won on 18/07/2017.
//  Copyright © 2017 trilliwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreBluetooth

class ViewController: UIViewController {

  let disposeBag = DisposeBag()
  let centralManager = CBCentralManager()

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scanButton: UIBarButtonItem!
  @IBOutlet weak var stateLabel: UILabel!

  var discovereds: [CBPeripheral] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    /// Bind CBManager State
    centralManager.rx.state
      .filter{ $0 == .poweredOn }
      .bind { [unowned self] _ in
        self.centralManager.scanForPeripherals(withServices: nil, options: nil)
      }.disposed(by: disposeBag)

    /// Bind Discovered Peripheral
    centralManager.rx
      .didDiscover
      .bind { [unowned self] discovered in
        if !self.discovereds.contains { $0 == discovered.peripheral } {
          self.discovereds.append(discovered.peripheral)
        }
      }
      .disposed(by: disposeBag)

    scanButton.rx.tap
      .bind { [unowned self] in
        self.centralManager.scanForPeripherals(withServices: nil, options: nil)
      }.disposed(by: disposeBag)
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PeripheralCell", for: indexPath)
    cell.textLabel?.text = discovereds[indexPath.row].name ?? "No Name"
    cell.detailTextLabel?.text = "\(discovereds[indexPath.row].identifier.uuidString)"
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return discovereds.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
