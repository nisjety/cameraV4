//
//  CameraStateManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 18/08/2024.
//

import Foundation
import Combine

final class CameraStateManager {

    func observeState(mediaLibrary: MediaLibrary, captureService: CaptureService, cameraModel: CameraModel) {
        Task {
            for await thumbnail in mediaLibrary.thumbnails.compactMap({ $0 }) {
                await MainActor.run {
                    cameraModel.thumbnail = thumbnail
                }
            }
        }

        Task {
            for await activity in await captureService.$captureActivity.values {
                await MainActor.run {
                    if activity.willCapture {
                        cameraModel.flashScreen()
                    } else {
                        cameraModel.updateCaptureActivity(activity)
                    }
                }
            }
        }

        Task {
            for await capabilities in await captureService.$captureCapabilities.values {
                await MainActor.run {
                    cameraModel.isHDRVideoSupported = capabilities.isHDRSupported
                }
            }
        }
    }
}
