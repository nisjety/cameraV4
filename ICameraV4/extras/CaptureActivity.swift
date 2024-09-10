//
//  CaptureActivity.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import Foundation

enum CaptureActivity {
    case idle
    case capturingPhoto
    case recordingVideo
    case paused
    case stopped
    // Add other states as needed

    static func allCases() -> [CaptureActivity] {
        return [.idle, .capturingPhoto, .recordingVideo, .paused, .stopped]
    }
}

func handleCaptureActivity(_ activity: CaptureActivity) {
    switch activity {
    case .idle:
        // Handle idle state
        print("Camera is idle.")
    case .capturingPhoto:
        // Handle photo capture state
        print("Capturing photo.")
    case .recordingVideo:
        // Handle video recording state
        print("Recording video.")
    case .paused:
        // Handle paused state
        print("Recording paused.")
    case .stopped:
        // Handle stopped state
        print("Recording stopped.")
    }
}
