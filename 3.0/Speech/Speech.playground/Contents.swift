//: Playground - noun: a place where people can play

import UIKit
import Speech
import AVFoundation
class MicCheck: NSObject, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    let session = AVCaptureSession()
    let recognizer = SFSpeechRecognizer(locale: Locale(localeIdentifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    
    override init() {
        super.init()
        session.beginConfiguration()
        
        if let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeAudio) as! [AVCaptureDevice]? where devices.count > 0,
            let microphone = devices.first {
            do {
                let input = try AVCaptureDeviceInput(device: microphone)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                let output = AVCaptureAudioDataOutput()
                output.setSampleBufferDelegate(self, queue: DispatchQueue.main)
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                session.commitConfiguration()
                session.startRunning()
            }
            catch {
                print("\(error)")
            }
        }
        
        func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
            request.appendAudioSampleBuffer(sampleBuffer)
            recognizer?.recognitionTask(with: request, resultHandler: {
                (result, optionalError) in
                NSLog("\(result)")
            })
        }
    }
    
    let micCheck = MicCheck()
}
