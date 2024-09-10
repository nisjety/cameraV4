//
//  CaptureModeConfigurationManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation

final class CaptureModeConfigurationManager {

    // Configures the session for slo-mo mode.
    func configureForSloMoMode(session: AVCaptureSession, movieOutput: AVCaptureMovieFileOutput, device: AVCaptureDevice) {
        session.beginConfiguration()
        session.sessionPreset = .high
        
        // Find a format that supports high frame rate
        let desiredFrameRate = 120 // Example for 120 fps
        let availableFormats = device.formats.filter { format in
            format.videoSupportedFrameRateRanges.contains { range in
                range.maxFrameRate >= Double(desiredFrameRate)
            }
        }
        
        if let format = availableFormats.first {
            do {
                try device.lockForConfiguration()
                device.activeFormat = format
                device.activeVideoMinFrameDuration = CMTime(value: 1, timescale: CMTimeScale(desiredFrameRate))
                device.activeVideoMaxFrameDuration = CMTime(value: 1, timescale: CMTimeScale(desiredFrameRate))
                device.unlockForConfiguration()
                print("Configured \(device.localizedName) for Slo-Mo Mode at \(desiredFrameRate) fps")
            } catch {
                print("Failed to configure Slo-Mo Mode: \(error)")
            }
        } else {
            print("No compatible format found for the desired frame rate.")
        }
        
        if session.canAddOutput(movieOutput) {
            session.addOutput(movieOutput)
        }
        
        session.commitConfiguration()
    }
    
    // Configures the session for photo mode.
    func configureForPhotoMode(session: AVCaptureSession, photoOutput: AVCapturePhotoOutput) {
        session.beginConfiguration()
        session.sessionPreset = .photo
        session.inputs.forEach { session.removeInput($0) }
        session.outputs.forEach { session.removeOutput($0) }

        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        
        session.commitConfiguration()
    }
    
    // Configures the session for video mode.
    func configureForVideoMode(session: AVCaptureSession, movieOutput: AVCaptureMovieFileOutput) {
        session.beginConfiguration()
        session.sessionPreset = .high
        session.inputs.forEach { session.removeInput($0) }
        session.outputs.forEach { session.removeOutput($0) }

        if session.canAddOutput(movieOutput) {
            session.addOutput(movieOutput)
        }
        
        session.commitConfiguration()
    }

    // Configures the session for panorama mode.
    func configureForPanoramaMode(session: AVCaptureSession) {
        session.beginConfiguration()
        session.sessionPreset = .high
        // Add specific configurations for panorama mode
        session.commitConfiguration()
    }

    // Configures the session for time-lapse mode.
    func configureForTimeLapseMode(session: AVCaptureSession, movieOutput: AVCaptureMovieFileOutput) {
        session.beginConfiguration()
        session.sessionPreset = .high
        if session.canAddOutput(movieOutput) {
            session.addOutput(movieOutput)
        }
        session.commitConfiguration()
    }
    
    // Configures the session for portrait mode.
    func configureForPortraitMode(session: AVCaptureSession, photoOutput: AVCapturePhotoOutput) {
        session.beginConfiguration()
        session.sessionPreset = .photo
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        // Additional settings for portrait mode
        session.commitConfiguration()
    }
    
    // Configures the session for Portrait-Movie (Filmatick) mode.
    func configureForPortraitMovieMode(session: AVCaptureSession, movieOutput: AVCaptureMovieFileOutput) {
        session.beginConfiguration()
        session.sessionPreset = .high
        if session.canAddOutput(movieOutput) {
            session.addOutput(movieOutput)
        }
        // Specific settings for cinematic or portrait movie mode
        session.commitConfiguration()
    }
}
