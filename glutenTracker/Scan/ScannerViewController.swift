//
//  ScannerViewController.swift
//



import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    private var captureDevice:AVCaptureDevice?
    private var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    private var captureSession:AVCaptureSession?
    private var didDecodeBarcode: ((String)->Void)?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationItem.title = "Scanner"
        view.backgroundColor = .white
        
        captureDevice = AVCaptureDevice.default(for: .video)
        
        
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39]
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                print("Problem with the reader... 😫  ")
            }
            
        }
        
    }
    
    private let codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            print("No Input Detected")
            codeFrame.frame = CGRect.zero
            return
        }

        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        guard let stringCodeValue = metadataObject.stringValue else { return }

        view.addSubview(codeFrame)

        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
        self.playSound(sound: "beep-07")

        captureSession?.stopRunning()
        
        self.dismiss(animated: true) {
            self.didDecodeBarcode?(stringCodeValue)
        }
    }
    
    public func didDecodeBarcode(_ completion: ((String)->Void)?) {
        self.didDecodeBarcode = completion
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func actionClose(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
