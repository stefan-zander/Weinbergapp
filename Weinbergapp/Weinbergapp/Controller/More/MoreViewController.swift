//
//  MoreViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 21.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader
import RealmSwift

class MoreViewController: UIViewController, QRCodeReaderViewControllerDelegate {

    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }

        return QRCodeReaderViewController(builder: builder)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func setupBusiness(_ sender: UIButton) {
        readerVC.delegate = self
        readerVC.modalPresentationStyle = .formSheet

        self.present(readerVC, animated: true, completion: nil)
    }

    @IBAction func logout(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        do {
            let business = Business()
            business.name = "TH Bingen"
            business.url = "https://reswein.iis.th-bingen.de:5984"

            var config = Realm.Configuration()

            config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("businesses.realm")

            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(business)
            }

            reader.stopScanning()
            self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            MoreDialogs.presentAddError(error, controller: reader)
        }
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        self.dismiss(animated: true, completion: nil)
    }
}
