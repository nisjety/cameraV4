/*
//  RotationManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation
import os
import UIKit

class RotationManager: RotationManagerProtocol {
    private let captureSessionManager: CaptureSessionManagerProtocol
    private let logger = Logger(subsystem: "com.yourapp.icamera", category: "RotationManager")

    init(sessionManager: CaptureSessionManagerProtocol) {
        self.captureSessionManager = sessionManager
        configureRotationObserver()
    }

    // Handles device rotation and updates the video preview and capture orientations
    func handleDeviceRotation() {
        guard let videoConnection = getVideoConnection() else {
            logger.error("Failed to retrieve video connection.")
            return
        }

        let orientation = UIDevice.current.orientation

        switch orientation {
        case .portrait:
            videoConnection.videoOrientation = .portrait
        case .portraitUpsideDown:
            videoConnection.videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            videoConnection.videoOrientation = .landscapeRight
        case .landscapeRight:
            videoConnection.videoOrientation = .landscapeLeft
        default:
            videoConnection.videoOrientation = .portrait
        }

        logger.info("Video orientation updated to \(videoConnection.videoOrientation).")
    }

    // Updates the video preview layer's rotation angle based on the device's orientation
    func updatePreviewRotation(_ angle: CGFloat) {
        guard let previewLayer = getPreviewLayer() else {
            logger.error("Failed to retrieve preview layer.")
            return
        }

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.25)
        previewLayer.setAffineTransform(CGAffineTransform(rotationAngle: angle))
        CATransaction.commit()

        logger.info("Preview layer rotated by \(angle) radians.")
    }

    // Updates the video capture rotation angle to match the preview
    func updateCaptureRotation(_ angle: CGFloat) {
        guard let videoConnection = getVideoConnection() else {
            logger.error("Failed to retrieve video connection.")
            return
        }

        // Apply the rotation to the video connection
        videoConnection.videoOrientation = currentOrientation(from: angle)

        logger.info("Capture rotation updated to match the preview rotation.")
    }

    // MARK: - Private Methods

    private func configureRotationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleOrientationChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    @objc private func handleOrientationChange() {
        handleDeviceRotation()
    }

    // Helper method to get the video connection
    private func getVideoConnection() -> AVCaptureConnection? {
        return captureSessionManager.captureSession.connections.first { $0.isVideoOrientationSupported }
    }

    // Helper method to get the preview layer
    private func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return captureSessionManager.captureSession.connections.compactMap { $0.videoPreviewLayer }.first
    }

    // Helper method to determine orientation from angle
    private func currentOrientation(from angle: CGFloat) -> AVCaptureVideoOrientation {
        switch angle {
        case 0:
            return .portrait
        case CGFloat.pi:
            return .portraitUpsideDown
        case CGFloat.pi / 2:
            return .landscapeRight
        case -CGFloat.pi / 2:
            return .landscapeLeft
        default:
            return .portrait
        }
    }
}

*/
