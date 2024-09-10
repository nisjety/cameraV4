/*
//  MultiCameraManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation
import os

class MultiCameraManager: MultiCameraManagerProtocol {
    private let deviceManager: DeviceManagerProtocol
    private let captureSessionManager: CaptureSessionManagerProtocol
    private var multiCamSession: AVCaptureMultiCamSession?
    private let logger = Logger(subsystem: "com.yourapp.icamera", category: "MultiCameraManager")

    init(deviceManager: DeviceManagerProtocol, sessionManager: CaptureSessionManagerProtocol) {
        self.deviceManager = deviceManager
        self.captureSessionManager = sessionManager
    }

    // Configures the multi-camera capture session
    func configureMultiCameraCapture() async {
        guard AVCaptureMultiCamSession.isMultiCamSupported else {
            logger.error("Multi-camera capture is not supported on this device.")
            return
        }

        multiCamSession = AVCaptureMultiCamSession()

        do {
            try configureMultiCamInputsAndOutputs()
            multiCamSession?.startRunning()
            logger.info("Multi-camera session started.")
        } catch {
            logger.error("Failed to configure multi-camera capture: \(error.localizedDescription)")
        }
    }

    // Select and configure multiple lenses for the session
    func selectLenses(lenses: [AVCaptureDevice.Position]) {
        guard let multiCamSession = multiCamSession else {
            logger.error("Multi-camera session is not initialized.")
            return
        }

        multiCamSession.beginConfiguration()

        // Remove existing inputs to prevent conflicts
        multiCamSession.inputs.forEach { multiCamSession.removeInput($0) }

        do {
            for position in lenses {
                let camera = try deviceManager.camera(at: position)
                let cameraInput = try AVCaptureDeviceInput(device: camera)
                if multiCamSession.canAddInput(cameraInput) {
                    multiCamSession.addInput(cameraInput)
                    logger.info("Added \(position) camera to multi-camera session.")
                } else {
                    logger.error("Failed to add \(position) camera to multi-camera session.")
                }
            }
            multiCamSession.commitConfiguration()
        } catch {
            logger.error("Failed to select lenses: \(error.localizedDescription)")
        }
    }

    // MARK: - Private Methods

    // Configures inputs and outputs for multi-camera
    private func configureMultiCamInputsAndOutputs() throws {
        guard let multiCamSession = multiCamSession else { return }

        // Example: Add back camera input
        let backCamera = try deviceManager.camera(at: .back)
        let backCameraInput = try AVCaptureDeviceInput(device: backCamera)
        if multiCamSession.canAddInput(backCameraInput) {
            multiCamSession.addInput(backCameraInput)
            logger.info("Back camera input added to multi-camera session.")
        } else {
            logger.error("Failed to add back camera input.")
            throw CameraError.inputAdditionFailed
        }

        // Example: Add front camera input
        let frontCamera = try deviceManager.camera(at: .front)
        let frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
        if multiCamSession.canAddInput(frontCameraInput) {
            multiCamSession.addInput(frontCameraInput)
            logger.info("Front camera input added to multi-camera session.")
        } else {
            logger.error("Failed to add front camera input.")
            throw CameraError.inputAdditionFailed
        }

        // Example: Add video outputs for back and front cameras
        let backOutput = AVCaptureMovieFileOutput()
        if multiCamSession.canAddOutput(backOutput) {
            multiCamSession.addOutput(backOutput)
            logger.info("Back camera output added to multi-camera session.")
        } else {
            logger.error("Failed to add back camera output.")
            throw CameraError.outputAdditionFailed
        }

        let frontOutput = AVCaptureMovieFileOutput()
        if multiCamSession.canAddOutput(frontOutput) {
            multiCamSession.addOutput(frontOutput)
            logger.info("Front camera output added to multi-camera session.")
        } else {
            logger.error("Failed to add front camera output.")
            throw CameraError.outputAdditionFailed
        }
    }
}

*/
