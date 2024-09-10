//
//  MicrophoneManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import AVFoundation

final class MicrophoneManager {

    private var activeMicrophoneInput: AVCaptureDeviceInput?

    // Configure the default microphone
    func setupDefaultMicrophone() throws -> AVCaptureDeviceInput {
        guard let microphone = AVCaptureDevice.default(for: .audio) else {
            throw AudioError.microphoneUnavailable
        }
        return try configureMicrophone(microphone)
    }

    // Configure a specific microphone device
    func configureMicrophone(_ microphone: AVCaptureDevice) throws -> AVCaptureDeviceInput {
        let input = try AVCaptureDeviceInput(device: microphone)
        activeMicrophoneInput = input
        return input
    }

    // Handle switching to another microphone if multiple are available
    func switchToNextMicrophone() throws -> AVCaptureDeviceInput? {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.microphone], // Updated for iOS 17
            mediaType: .audio,
            position: .unspecified
        )
        
        let microphones = discoverySession.devices
        guard !microphones.isEmpty else {
            throw AudioError.microphoneUnavailable
        }
        
        guard let currentMicrophone = activeMicrophoneInput?.device else {
            return try configureMicrophone(microphones.first!)
        }
        
        let currentIndex = microphones.firstIndex(of: currentMicrophone) ?? 0
        let nextIndex = (currentIndex + 1) % microphones.count
        return try configureMicrophone(microphones[nextIndex])
    }

    // Additional methods to handle microphone-specific settings
    func setMicrophoneGain(_ gain: Float) throws {
        guard let microphone = activeMicrophoneInput?.device else { return }
        try microphone.lockForConfiguration()
        // Placeholder for setting gain; should be handled through AVAudioSession
        microphone.unlockForConfiguration()
    }

    func enableEchoCancellation(_ enabled: Bool) {
        // Handle echo cancellation settings if supported via AVAudioSession
    }

    func getActiveMicrophoneInput() -> AVCaptureDeviceInput? {
        return activeMicrophoneInput
    }
}

// Define custom errors for microphone management
enum AudioError: Error {
    case microphoneUnavailable
}
