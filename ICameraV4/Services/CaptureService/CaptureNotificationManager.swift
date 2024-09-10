//
//  CaptureNotificationManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 16/08/2024.
//

import Foundation
import AVFoundation
import os

/// A global logger for the app, scoped to capture notifications.
private let logger = Logger(subsystem: "com.icamera.ICameraV4", category: "CaptureNotification")

final class CaptureNotificationManager {

    // Handles capture session interruptions and logs specific reasons.
    func handleCaptureSessionInterruption(reason: AVCaptureSession.InterruptionReason?) {
        guard let reason = reason else {
            logger.warning("Capture session interrupted: No specific reason provided.")
            return
        }

        switch reason {
        case .audioDeviceInUseByAnotherClient:
            logger.info("Capture session interrupted: Audio device in use by another client.")
            notifyUser(with: "Audio device in use by another client. Please close other apps that use audio.")
        case .videoDeviceInUseByAnotherClient:
            logger.info("Capture session interrupted: Video device in use by another client.")
            notifyUser(with: "Video device in use by another client. Please close other apps that use video.")
        case .videoDeviceNotAvailableInBackground:
            logger.info("Capture session interrupted: Video device not available in background.")
            notifyUser(with: "Video device not available in background. Please bring the app to the foreground.")
        case .videoDeviceNotAvailableWithMultipleForegroundApps:
            logger.info("Capture session interrupted: Video device not available with multiple foreground apps.")
            notifyUser(with: "Video device not available with multiple foreground apps. Please close other apps.")
        case .videoDeviceNotAvailableDueToSystemPressure:
            logger.info("Capture session interrupted: Video device not available due to system pressure.")
            notifyUser(with: "System pressure affecting camera availability. Try reducing load on your device.")
        @unknown default:
            logger.error("Capture session interrupted: Unknown or new interruption reason.")
        }
    }

    // Logs the end of a capture session interruption.
    func handleCaptureSessionInterruptionEnded() {
        logger.info("Capture session interruption ended.")
        notifyUser(with: "Capture session interruption ended. You can resume using the camera.")
    }

    // Handles capture session runtime errors and logs them with specific actions.
    func handleCaptureSessionRuntimeError(error: AVError) {
        switch error.code {
        case .mediaServicesWereReset:
            logger.error("Capture session runtime error: Media services were reset. Reconfiguring session.")
            notifyUser(with: "Media services were reset. Attempting to reconfigure the session.")
            // Attempt to reset the capture session if applicable
        case .deviceIsNotAvailableInBackground:
            logger.error("Capture session runtime error: Device is not available in background.")
            notifyUser(with: "Camera is not available in the background. Please bring the app to the foreground.")
        case .sessionWasInterrupted:
            logger.error("Capture session runtime error: Session was interrupted.")
            notifyUser(with: "Capture session was interrupted. Please check your device's status.")
        case .sessionConfigurationChanged:
            logger.error("Capture session runtime error: Session configuration changed.")
            notifyUser(with: "Session configuration has changed. Please check your settings.")
        default:
            logger.error("Capture session runtime error: \(error.localizedDescription)")
            notifyUser(with: "An unexpected error occurred: \(error.localizedDescription).")
        }
    }
    
    // Utility function to notify the user with messages.
    private func notifyUser(with message: String) {
        // Implement user notification, e.g., using alerts, in-app notifications, or other UI updates.
        // This might involve invoking methods on a UI manager or sending notifications.
        DispatchQueue.main.async {
            // Example placeholder: Replace with actual user notification logic
            print("User Notification: \(message)")
        }
    }
}
