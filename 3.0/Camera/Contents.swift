//: Playground - noun: a place where people can play

/*import UIKit
import PlaygroundSupport
import AVFoundation
import QuartzCore
import CoreGraphics
class CameraViewController:UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var imageView: UIImageView?
    var videoDevice: AVCaptureDevice?
    var avSession: AVCaptureSession?
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        /*
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
        
        let baseAddress = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        guard let newContext = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue).rawValue) else {
            return
        }
        let newImage = newContext.makeImage()
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0)
        */
        "Hello"
        let coreImage = CIImage(cvImageBuffer: imageBuffer)
        let image = UIImage(cgImage: coreImage.cgImage!)
        imageView?.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSessionPreset640x480
        if let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]?,
            let camera = devices.filter({$0.position == .front}).first {
            do {
                let input = try AVCaptureDeviceInput(device: camera)
                session.addInput(input)
                
                let output = AVCaptureVideoDataOutput()
                output.alwaysDiscardsLateVideoFrames = true
                //output.videoSettings = [kCVPixelBufferPixelFormatTypeKey : Int(kCVPixelFormatType_32BGRA)]
                //output.setSampleBufferDelegate(self, queue: DispatchQueue.main)
                session.addOutput(output)
                
                let captureLayer = AVCaptureVideoPreviewLayer(session: session)
                self.view.layer.addSublayer(captureLayer!)
                
                session.commitConfiguration()
                session.startRunning()
            }
            catch {
                NSLog("Error: \(error)")
            }
        }
        
        avSession = session
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView = UIImageView(frame: view.bounds)
    }
}

let camera = CameraViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
 PlaygroundPage.current.liveView = camera.view
 */
import UIKit
import AVFoundation
import AVKit
import QuartzCore
import PlaygroundSupport

let view = UIView(frame:CGRect(x: 0.0, y: 0.0, width: 320.0, height: 640.0))

let session = AVCaptureSession()

session.sessionPreset = AVCaptureSessionPreset640x480
session.beginConfiguration()
session.commitConfiguration()

var input : AVCaptureDeviceInput
if let devices : [AVCaptureDevice] = AVCaptureDevice.devices() as? [AVCaptureDevice] {
    for device in devices {
        if device.hasMediaType(AVMediaTypeVideo) && device.supportsAVCaptureSessionPreset(AVCaptureSessionPreset640x480) {
            do {
                input = try AVCaptureDeviceInput(device: device as AVCaptureDevice) as AVCaptureDeviceInput
                
                if session.canAddInput(input) {
                    session.addInput(input)
                    break
                }
            }
            catch {
                error
            }
        }
    }
    
    let output = AVCaptureVideoDataOutput()
    output.videoSettings = [kCVPixelBufferPixelFormatTypeKey: Int(kCVPixelFormatType_32BGRA)]
    output.alwaysDiscardsLateVideoFrames = true
    
    if session.canAddOutput(output) {
        session.addOutput(output)
    }
    
    let captureLayer = AVCaptureVideoPreviewLayer(session: session)
    captureLayer?.frame = view.bounds 
    
    view.layer.addSublayer(captureLayer!)
    session.startRunning()
    
    //View -> Assistant Editor -> Show Assistant Editor
    PlaygroundPage.current.needsIndefiniteExecution = true
    PlaygroundPage.current.liveView = view
}
