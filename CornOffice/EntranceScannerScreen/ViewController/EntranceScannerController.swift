//
//  EntranceScannerController.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit
import MercariQRScanner
import AVFoundation

class EntranceScannerController: UIViewController {
    // MARK: - Properties
    var entranceManager = EntranceManager()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemYellow
        entranceManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupQRScanner()
        setupBackgroundImage()
    }
    
    // MARK: - QR Scanner Settings
    
    private func setupQRScanner() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setupQRScannerView()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted {
                        DispatchQueue.main.async { [weak self] in
                            self?.setupQRScannerView()
                        }
                    }
                }
            default:
                showAlert()
        }
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "qr_entrance_screen")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    private func setupQRScannerView() {
        let qrScannerView = QRScannerView(frame: view.bounds)
        qrScannerView.focusImagePadding = 8.0
        qrScannerView.animationDuration = 0.5

        view.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        qrScannerView.startRunning()
    }
    
    private func showAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Camera is required to use in this application", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

// MARK: - QRScannerViewDelegate

extension EntranceScannerController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        entranceManager.entranceRequest(with: EntranceModel(key: Int(code) ?? 0, email: "s.v@mail.ru"))
    }
}

// MARK: - EntranceManagerDelegate

extension EntranceScannerController: EntranceManagerDelegate {
    func didConnectSuccessfully() {
        print("succesful enter")
    }
    
    func didFailWithError() {
        print("error")
    }
}
