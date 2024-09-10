//
//  MultiLensDeviceManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 18/08/2024.
//

import AVFoundation
import Combine

final class MultiLensDeviceManager {
    private var multiCamSession: AVCaptureMultiCamSession?
    private var activeLenses: [AVCaptureDevice] = []
    private let cameraInputManager = CameraInputManager()
    private let cameraFormatManager = CameraFormatManager()

    private let activeLensesSubject = PassthroughSubject<[AVCaptureDevice], Never>()

    // Publisher to observe active lenses
    var activeLensesPublisher: AnyPublisher<[AVCaptureDevice], Never> {
        activeLensesSubject.eraseToAnyPublisher()
    }

    // Configures the multi-lens session with the selected lenses
    func configureMultiLensSession() async throws {
        guard AVCaptureMultiCamSession.isMultiCamSupported else {
            throw CameraError.multiCamNotSupported
        }

        multiCamSession = AVCaptureMultiCamSession()

        let lenses: [AVCaptureDevice] = [
            .default(.builtInWideAngleCamera, for: .video, position: .back),
            .default(.builtInUltraWideCamera, for: .video, position: .back),
            .default(.builtInTelephotoCamera, for: .video, position: .back),
            .default(.builtInWideAngleCamera, for: .video, position: .front)
        ].compactMap { $0 }

        for lens in lenses {
            let input = try cameraInputManager.addCameraInput(for: lens, to: multiCamSession!)
            cameraFormatManager.configureActiveFormat(for: input.device, resolution: .hd1920x1080, frameRate: 30)
        }

        activeLenses = lenses
        activeLensesSubject.send(activeLenses)

        if let hardwareCost = multiCamSession?.hardwareCost, hardwareCost <= 1.0 {
            multiCamSession?.startRunning()
        } else {
            throw CameraError.setupFailed
        }
    }

    // Switches to the next lens
    func switchToNextLens(activeLensInput: inout AVCaptureDeviceInput?) throws {
        guard let session = multiCamSession else { return }
        try cameraInputManager.switchToNextVideoDevice(in: session, activeVideoInput: &activeLensInput)
    }

    // Stops the multi-lens session
    func stopMultiLensSession() {
        multiCamSession?.stopRunning()
    }

    // Starts the multi-lens session
    func startMultiLensSession() {
        multiCamSession?.startRunning()
    }

    // Updates the active lenses based on user selection
    func updateActiveLenses(_ selectedLenses: [AVCaptureDevice]) async {
        activeLenses = selectedLenses
        activeLensesSubject.send(activeLenses)

        // Reconfigure session based on the selected lenses
        stopMultiLensSession()

        multiCamSession = AVCaptureMultiCamSession()
        for lens in selectedLenses {
            do {
                let input = try cameraInputManager.addCameraInput(for: lens, to: multiCamSession!)
                cameraFormatManager.configureActiveFormat(for: input.device, resolution: .hd1920x1080, frameRate: 30)
            } catch {
                print("Error configuring lens: \(lens.localizedName) - \(error)")
            }
        }

        if let hardwareCost = multiCamSession?.hardwareCost, hardwareCost <= 1.0 {
            startMultiLensSession()
        } else {
            print("Hardware cost too high, cannot start multi-lens session.")
        }
    }

    // Retrieves the current active lenses
    func getActiveLenses() async -> [AVCaptureDevice] {
        return activeLenses
    }
}
