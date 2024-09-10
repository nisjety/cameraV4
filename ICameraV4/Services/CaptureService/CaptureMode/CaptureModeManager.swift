//
//  CaptureModeManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation

final class CaptureModeManager {

    private let captureModeConfigManager = CaptureModeConfigurationManager()
    private let hdrConfigManager = HDRConfigurationManager()
    private let highResPhotoConfigManager = HighResolutionPhotoManager()
    private let cinematicModeManager = CinematicModeManager()

    // Configures the session for the specified capture mode.
    func configureCaptureMode(_ captureMode: CaptureMode, session: AVCaptureSession, photoOutput: AVCapturePhotoOutput, movieOutput: AVCaptureMovieFileOutput) {
        switch captureMode {
        case .photo:
            captureModeConfigManager.configureForPhotoMode(session: session, photoOutput: photoOutput)
        case .video:
            captureModeConfigManager.configureForVideoMode(session: session, movieOutput: movieOutput)
        case .panorama:
            captureModeConfigManager.configureForPanoramaMode(session: session)
        case .timeLapse:
            captureModeConfigManager.configureForTimeLapseMode(session: session, movieOutput: movieOutput)
        case .sloMo:
            configureForSloMoMode(session: session, movieOutput: movieOutput)
        case .portrait:
            configureForPortraitMode(session: session, photoOutput: photoOutput)
        case .filmatick:
            configureForPortraitMovieMode(session: session, movieOutput: movieOutput)
        }
    }
    
    private func configureForSloMoMode(session: AVCaptureSession, movieOutput: AVCaptureMovieFileOutput) {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("No compatible camera found for Slo-Mo Mode")
            return
        }
        captureModeConfigManager.configureForSloMoMode(session: session, movieOutput: movieOutput, device: device)
    }

    private func configureForPortraitMode(session: AVCaptureSession, photoOutput: AVCapturePhotoOutput) {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        session.commitConfiguration()
        print("Configured for Portrait Mode")
    }

    private func configureForPortraitMovieMode(session: AVCaptureSession, movieOutput: AVCaptureMovieFileOutput) {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("No compatible camera found for Portrait Movie Mode")
            return
        }
        cinematicModeManager.enableCinematicMode(for: device, in: session)
    }
}
