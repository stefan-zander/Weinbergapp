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

class MoreViewController: UIViewController {

    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
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
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result)
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }

    @IBAction func logout(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
