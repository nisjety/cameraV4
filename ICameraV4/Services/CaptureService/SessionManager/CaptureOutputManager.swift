//
//  CaptureOutputManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

// The class now inherits from NSObject to conform to protocols that require it
final class CaptureOutputManager: NSObject {

    // Configures the default outputs for the capture session
    func configureDefaultOutputs(captureSession: AVCaptureSession) throws {
        let photoOutput = AVCapturePhotoOutput() // Photo output for capturing images
        try addOutput(photoOutput, to: captureSession)
        
        // Add more outputs as needed, e.g., video data output, metadata output
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        try addOutput(videoOutput, to: captureSession)
    }

    // Adds an output to the capture session
    private func addOutput(_ output: AVCaptureOutput, to captureSession: AVCaptureSession) throws {
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        } else {
            throw CameraError.addOutputFailed
        }
    }
}

// Extend the manager to conform to AVCaptureVideoDataOutputSampleBufferDelegate
extension CaptureOutputManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Process the sample buffer if video output is being used
    }
}
