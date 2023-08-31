import UIKit
import WebKit
import AVFoundation

class QRScannerViewController: UIViewController, UITextViewDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var webVIew: WKWebView!
    @IBOutlet weak var textView: UITextView!

    var detectView: UIView!


    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var photoOutput: AVCapturePhotoOutput!
    var latetQRcodeValue = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        detectView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
        detectView.backgroundColor = UIColor(#colorLiteral(red: 0.7654506105, green: 0.8172973604, blue: 0.2047542287, alpha: 0.1753793207))
        detectView.layer.borderColor = UIColor.green.cgColor
        detectView.layer.borderWidth = 2
        textView.delegate = self
        initScannerView()

    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        detectView.frame = scannerView.frame
        view.addSubview(detectView)
        
        detectView.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Did appearrrrrrrrrrrrrrrrrrrrrr")
        previewLayer.frame = scannerView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        scannerView.layer.addSublayer(previewLayer)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    @IBAction func captủeBUtton(_ sender: Any) {

        DispatchQueue.main.async { [weak self]  in
            guard let self = self else { return }

            self.textView.text = self.latetQRcodeValue

        }
        if let url = URL(string: latetQRcodeValue) {
            let request = URLRequest(url: url)
            webVIew.load(request)
        }

    }

    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }



    private func detectQRCode(in image: UIImage) {
        // Convert the UIImage to a CIImage
        guard let ciImage = CIImage(image: image) else {
            return
        }

        // Set up the detector
        let context = CIContext()
        let qrCodeDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        // Detect QR codes
        if let features = qrCodeDetector?.features(in: ciImage) {
            for feature in features as! [CIQRCodeFeature] {
                print("QR Code Value from Detector: \(feature.messageString ?? "")")
                // Process the QR code value from detection here
            }
        }
    }

    private func initScannerView() {
        /// Initialize AVCaptureSession and configure camera input and metadata output.

        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Your device is not applicable for video processing")
            return
        }

        let videoInput: AVCaptureInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Your device can not give video input")
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput) // Add the video input.

            let metadataOutput = AVCaptureMetadataOutput()
            if captureSession.canAddOutput(metadataOutput) {
                captureSession.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes

            } else {
                print("Your device can not configure metadataObjectTypes")
            }
        } else {
            print("Your device can not add video input")
        }
        photoOutput = AVCapturePhotoOutput()
        captureSession.addOutput(photoOutput)
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global())

        // Add videoOutput to the capture session
        captureSession.addOutput(videoOutput)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    }



    // AVCaptureVideoDataOutputSampleBufferDelegate method to process each video frame
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //          if let image = imageFromSampleBuffer(sampleBuffer) {
        //              // Detect QR code position in the image
        //              detectQRCode(in: image)
        //          }
    }

    // Function to convert a CMSampleBuffer to a UIImage
    func imageFromSampleBuffer(_ sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }

        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        let context = CIContext()

        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return nil
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        // Open the URL in Safari or the default web browser
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
            return true
        } else {
            print("Cannot open URL: \(URL)")
            return false
        }

        // Return false to prevent the system from opening the link in Safari
    }
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadataObject in metadataObjects {
            if let qrCodeObject = metadataObject as? AVMetadataMachineReadableCodeObject {
                if let qrCodeValue = qrCodeObject.stringValue {
                    let qrCodeBounds = qrCodeObject.bounds
                    print("------------------------------------------------------------------------------")

                    // Handle the QR code value (e.g., display it, perform an action, etc.).
//                    print("Detected QR code: \(qrCodeValue)")
                    print("QR Code Position: \(qrCodeBounds.origin.x), \(qrCodeBounds.origin.y)")
                    print("QR Code width - height : \(qrCodeBounds.width), \(qrCodeBounds.height)")

//                    print("ScannView Position: \(self.scannerView.frame.origin.x), \(self.scannerView.frame.origin.y)")
//
//                    print("Sanview width - height : \(self.scannerView.frame.size.width), \(self.scannerView.frame.size.height)")
//                    let qrCodeFrameInPreviewLayer = previewLayer.layerRectConverted(fromMetadataOutputRect: qrCodeBounds)
                    print("------------------------------------------------------------------------------")

                    let qrCodePositionInTargetView = previewLayer.layerRectConverted(fromMetadataOutputRect: qrCodeBounds).intersection(self.scannerView.bounds)
                    print("qrCodePositionInTargetView Position: \(qrCodePositionInTargetView.origin.x), \(qrCodePositionInTargetView.origin.y)")
                    print("qrCodePositionInTargetView width - height : \(qrCodePositionInTargetView.width), \(qrCodePositionInTargetView.height)")

                    print("------------------------------------------------------------------------------")
                    print("QRscanner Position: \(self.scannerView.frame.origin.x), \(self.scannerView.frame.origin.y)")
                    print("Qrscanner  width - height : \(self.scannerView.frame.size.width),  \(self.scannerView.frame.size.height)")

                    print("------------------------------------------------------------------------------")
                    print("Caculator Position: \((qrCodeBounds.origin.x * self.scannerView.frame.size.width) + self.scannerView.frame.origin.x), \((qrCodeBounds.origin.y * self.scannerView.frame.size.height) + self.scannerView.frame.origin.y)")

//                    print("qrCodePositionInTargetView Position: \(qrCodePositionInTargetView.origin.x), \(qrCodePositionInTargetView.origin.y)")
//
//                    print("qrCodePositionInTargetView width - height : \(qrCodePositionInTargetView.size.width), \(qrCodePositionInTargetView.size.height)")
                    let screenSize: CGSize = UIScreen.main.bounds.size
                    let newOrigin:CGPoint = CGPoint(
                        x: (qrCodeBounds.origin.x * self.scannerView.frame.size.width) + self.scannerView.frame.origin.x,
                        y: (qrCodeBounds.origin.y * self.scannerView.frame.size.height) + self.scannerView.frame.origin.y)
//                    let newSize: CGSize = CGSize(
//                        width: qrCodeBounds.width * self.scannerView.frame.size.width,
//                        height: qrCodeBounds.height * self.scannerView.frame.size.height)

                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }

                        UIView.animate(withDuration: 0.1) {
                            self.detectView.frame = CGRect(origin: newOrigin, size: qrCodePositionInTargetView.size)
//                            self.detectView.frame = qrCodePositionInTargetView

                        }

                    }

                    latetQRcodeValue = qrCodeValue
                }
            }


        }
    }

}

extension QRScannerViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("cappture")
        if let imageData = photo.fileDataRepresentation() {
            if let capturedImage = UIImage(data: imageData) {
                print(capturedImage)
            }
        }
    }}

extension QRScannerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Đã bắt đầu tải trang
        print("/ Đã bắt đầu tải trang")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("// Tải trang thành công")

        // Tải trang thành công
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("// Lỗi tải trang")

        // Lỗi tải trang
    }
}
