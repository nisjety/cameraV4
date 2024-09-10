//
//  CaptureSessionManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation

final class CaptureSessionManager {
    
    private var isSetUp = false
    private let captureSession: AVCaptureSession
    private let authorizationManager: CaptureAuthorizationManager
    private let inputManager: CaptureInputManager
    private let outputManager: CaptureOutputManager
    private let stateManager: SessionStateManager
    private let errorManager: CaptureErrorManager

    init(captureSession: AVCaptureSession,
         authorizationManager: CaptureAuthorizationManager,
         inputManager: CaptureInputManager,
         outputManager: CaptureOutputManager,
         stateManager: SessionStateManager,
         errorManager: CaptureErrorManager) {
        
        self.captureSession = captureSession
        self.authorizationManager = authorizationManager
        self.inputManager = inputManager
        self.outputManager = outputManager
        self.stateManager = stateManager
        self.errorManager = errorManager
    }

    // MARK: - Capture Session Lifecycle
    func start() async throws {
        guard await authorizationManager.isAuthorized, !stateManager.isSessionRunning() else { return }
        try await setUpSession()
        stateManager.startSession(captureSession)
    }

    // MARK: - Capture Setup
    public func setUpSession() async throws {
        guard !isSetUp else { return }
        do {
            try inputManager.configureDefaultInputs(captureSession: captureSession)
            try outputManager.configureDefaultOutputs(captureSession: captureSession)

            monitorSystemPreferredCamera()
            observeSubjectAreaChanges()

            isSetUp = true
        } catch {
            errorManager.handleError(error, in: "Setup Session")
            throw CameraError.setupFailed
        }
    }

    // MARK: - System Preferred Camera Monitoring
    public func monitorSystemPreferredCamera() {
        // Integrate SystemPreferredCameraObserver logic here
    }

    // MARK: - Subject Area Changes Observation
    public func observeSubjectAreaChanges() {
        // Implement logic to observe and respond to subject area changes
    }
}
