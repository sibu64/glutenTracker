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
    
    } //end of : override func viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setup de la vue
        navigationItem.title = "Scanner"
        view.backgroundColor = .white
        
        captureDevice = AVCaptureDevice.default(for: .video)
        
        //Si captureDevice retourne une valeur et la déballe
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                
                //Précision des AVMetadataObjectObjectType
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39]
                
                //Lancement de la capture du code barre
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                print("Problème avec le lecteur")
            }
            
        } //end of : if let captureDevice = captureDevice
        
    } //end of : override func viewWillAppear()
    //Définition par code de la vue rectangle vert délimitant la zone scannée
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

        //recup du codeScan
        guard let stringCodeValue = metadataObject.stringValue else { return }

        view.addSubview(codeFrame)

        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
        self.playSound(sound: "beep-07")
        //Arrêt de la capture et de l'exécution de la fonction metadataOutput qui tourne en boucle
        captureSession?.stopRunning()
        
        self.dismiss(animated: true) {
            self.didDecodeBarcode?(stringCodeValue)
        }
    } // end of : func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput
    
    public func didDecodeBarcode(_ completion: ((String)->Void)?) {
        self.didDecodeBarcode = completion
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func actionClose(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

} // class ScannerViewController: UIViewController, AVCaptureMetadataOutput .....
