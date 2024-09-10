//
//  CameraInputManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class CameraInputManager {
    
    /// Adds a camera input for a specified device to a given session.
    /// - Parameters:
    ///   - device: The `AVCaptureDevice` representing the camera or lens to add.
    ///   - session: The `AVCaptureMultiCamSession` to which the input should be added.
    /// - Returns: The `AVCaptureDeviceInput` added to the session.
    /// - Throws: An error if the input cannot be added to the session.
    func addCameraInput(for device: AVCaptureDevice, to session: AVCaptureMultiCamSession) throws -> AVCaptureDeviceInput {
        let input = try AVCaptureDeviceInput(device: device)
        guard session.canAddInput(input) else {
            throw CameraError.addInputFailed
        }
        session.addInput(input)
        print("Camera input added: \(device.localizedName)")
        return input
    }

    /// Removes a camera input from a given session.
    /// - Parameters:
    ///   - input: The `AVCaptureDeviceInput` to remove from the session.
    ///   - session: The `AVCaptureMultiCamSession` from which the input should be removed.
    func removeCameraInput(_ input: AVCaptureDeviceInput, from session: AVCaptureMultiCamSession) {
        session.removeInput(input)
        print("Camera input removed: \(input.device.localizedName)")
    }

    /// Switches to the next available video device in the session.
    /// - Parameters:
    ///   - session: The `AVCaptureMultiCamSession` containing the inputs.
    ///   - activeVideoInput: The currently active `AVCaptureDeviceInput`, which will be updated to the next available device.
    /// - Throws: An error if switching the input fails.
    func switchToNextVideoDevice(in session: AVCaptureMultiCamSession, activeVideoInput: inout AVCaptureDeviceInput?) throws {
        guard let currentDevice = activeVideoInput?.device else { return }
        
        let availableDevices = session.inputs.compactMap { $0 as? AVCaptureDeviceInput }.map { $0.device }
        guard let currentIndex = availableDevices.firstIndex(of: currentDevice) else { return }
        
        let nextIndex = (currentIndex + 1) % availableDevices.count
        let nextDevice = availableDevices[nextIndex]
        
        let newInput = try addCameraInput(for: nextDevice, to: session)
        removeCameraInput(activeVideoInput!, from: session)
        activeVideoInput = newInput
        print("Switched to next video device: \(nextDevice.localizedName)")
    }
}
