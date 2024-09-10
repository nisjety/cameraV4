//
//  DeviceManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation

final class CaptureDeviceManager {
    
    private let deviceLookup: DeviceLookup
    private let multiLensDeviceManager: MultiLensDeviceManager
    private let systemPreferredCameraObserver: SystemPreferredCameraObserver
    private let microphoneManager: MicrophoneManager
    private var activeVideoInput: AVCaptureDeviceInput?

    init(deviceLookup: DeviceLookup = DeviceLookup(),
         multiLensDeviceManager: MultiLensDeviceManager = MultiLensDeviceManager(),
         systemPreferredCameraObserver: SystemPreferredCameraObserver = SystemPreferredCameraObserver(),
         microphoneManager: MicrophoneManager = MicrophoneManager()) {
        
        self.deviceLookup = deviceLookup
        self.multiLensDeviceManager = multiLensDeviceManager
        self.systemPreferredCameraObserver = systemPreferredCameraObserver
        self.microphoneManager = microphoneManager
        
        setupSystemPreferredCameraObserver()
    }
    
    // MARK: - Device Setup
    func setupDevices() async throws {
        let cameras = deviceLookup.cameras
        activeVideoInput = try addCameraInput(for: cameras.first)
        let microphoneInput = try microphoneManager.setupDefaultMicrophone()
        // Add microphoneInput to session or other processing
        
        try await multiLensDeviceManager.configureMultiLensSession()
    }

    // MARK: - Multi-Lens Configuration
    func configureMultiLensSession() async throws {
        try await multiLensDeviceManager.configureMultiLensSession()
    }

    // MARK: - Camera Device Management
    func switchToNextVideoDevice() {
        do {
            try multiLensDeviceManager.switchToNextLens(activeLensInput: &activeVideoInput)
        } catch {
            print("Failed to switch video device: \(error)")
        }
    }
    
    // MARK: - Microphone Management
    func switchMicrophone() {
        do {
            let nextMicrophone = try microphoneManager.switchToNextMicrophone()
            // Reconfigure session with the new microphone if necessary
        } catch {
            print("Failed to switch microphone: \(error)")
        }
    }

    // MARK: - Helper Methods for Single Camera Mode
    public func switchToNextVideoDeviceSingleCamera() -> AVCaptureDeviceInput? {
        let devices = deviceLookup.cameras
        guard let currentDevice = activeVideoInput?.device else {
            print("Error: Active video input not found. Falling back to the first available device.")
            return try? addCameraInput(for: devices.first)
        }

        let selectedIndex = devices.firstIndex(of: currentDevice) ?? 0
        let nextIndex = (selectedIndex + 1) % devices.count
        return try? addCameraInput(for: devices[nextIndex])
    }

    public func addCameraInput(for device: AVCaptureDevice?) throws -> AVCaptureDeviceInput? {
        guard let device = device else { return nil }
        let input = try AVCaptureDeviceInput(device: device)
        return input
    }

    // MARK: - System Preferred Camera Observer Setup
    public func setupSystemPreferredCameraObserver() {
        Task {
            for await newDevice in systemPreferredCameraObserver.changes {
                handleDeviceChange(newDevice)
            }
        }
    }

    public func handleDeviceChange(_ newDevice: AVCaptureDevice?) {
        guard let device = newDevice else { return }
        do {
            self.activeVideoInput = try addCameraInput(for: device)
            // Additional handling for device change
        } catch {
            print("Failed to add camera input for the new device: \(error)")
        }
    }
}
