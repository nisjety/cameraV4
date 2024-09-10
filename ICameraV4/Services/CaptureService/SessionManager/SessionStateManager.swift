//
//  SessionStateManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation // Import AVFoundation to access AVCaptureSession

final class SessionStateManager {
    private var isRunning = false

    // Checks if the capture session is currently running
    func isSessionRunning() -> Bool {
        return isRunning
    }

    // Starts the capture session
    func startSession(_ captureSession: AVCaptureSession) {
        guard !isRunning else { return } // Avoid starting the session if it's already running
        captureSession.startRunning()
        isRunning = true
    }

    // Stops the capture session
    func stopSession(_ captureSession: AVCaptureSession) {
        guard isRunning else { return } // Avoid stopping the session if it's not running
        captureSession.stopRunning()
        isRunning = false
    }
}
