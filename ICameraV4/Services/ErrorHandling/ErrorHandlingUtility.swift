//
//  ErrorHandlingUtility.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 17/08/2024.
//

import Foundation
import AVFoundation

final class ErrorHandlingUtility {
    
    private let captureErrorManager = CaptureErrorManager()
    
    func changeCaptureDevice(captureSession: AVCaptureSession, to device: AVCaptureDevice, activeVideoInput: inout AVCaptureDeviceInput?) throws {
        captureSession.beginConfiguration()
        defer { captureSession.commitConfiguration() }
        
        do {
            if let currentInput = activeVideoInput {
                captureSession.removeInput(currentInput)
            }
            activeVideoInput = try AVCaptureDeviceInput(device: device)
            guard captureSession.canAddInput(activeVideoInput!) else {
                throw CameraError.addInputFailed
            }
            captureSession.addInput(activeVideoInput!)
        } catch {
            captureErrorManager.handleError(error, in: "changeCaptureDevice")
            throw error
        }
    }

    func addInput(captureSession: AVCaptureSession, for device: AVCaptureDevice) throws {
        do {
            let input = try AVCaptureDeviceInput(device: device)
            guard captureSession.canAddInput(input) else {
                throw CameraError.addInputFailed
            }
            captureSession.addInput(input)
        } catch {
            captureErrorManager.handleError(error, in: "addInput")
            throw error
        }
    }

    func handle(_ error: Error) {
        captureErrorManager.handleError(error, in: "general")
    }
}
