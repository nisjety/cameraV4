//
//  CaptureInputManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation // Import AVFoundation to use AV-related types

final class CaptureInputManager {
    private var activeVideoInput: AVCaptureDeviceInput?
    
    // Configures default inputs (camera and microphone) for the capture session
    func configureDefaultInputs(captureSession: AVCaptureSession) throws {
        let deviceLookup = DeviceLookup()
        let defaultCamera = try deviceLookup.defaultCamera
        let defaultMic = try deviceLookup.defaultMic

        // Add default camera input to the session
        activeVideoInput = try addInput(for: defaultCamera, to: captureSession)
        // Add default microphone input to the session
        try addInput(for: defaultMic, to: captureSession)
    }

    // Adds an input device to the capture session
    private func addInput(for device: AVCaptureDevice, to captureSession: AVCaptureSession) throws -> AVCaptureDeviceInput {
        let input = try AVCaptureDeviceInput(device: device)
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        } else {
            throw CameraError.addInputFailed
        }
        return input
    }

    // Returns the currently active camera device
    func getActiveCamera() -> AVCaptureDevice? {
        return activeVideoInput?.device
    }
}
