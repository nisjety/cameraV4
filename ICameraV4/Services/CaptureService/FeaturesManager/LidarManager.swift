//
//  LidarManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class LidarManager: NSObject, AVCaptureDepthDataOutputDelegate {

    private var depthDataOutput: AVCaptureDepthDataOutput?

    // Configures depth sensing on a given capture session.
    func configureForDepthSensing(on session: AVCaptureSession, with device: AVCaptureDevice) {
        guard isLiDARAvailable(for: device) else {
            print("LiDAR not available on \(device.localizedName)")
            return
        }

        depthDataOutput = AVCaptureDepthDataOutput()
        depthDataOutput?.isFilteringEnabled = true // Enable smoothing of depth data

        // Setup a delegate to receive depth data frames
        depthDataOutput?.setDelegate(self, callbackQueue: DispatchQueue(label: "depthDataQueue"))

        guard let depthOutput = depthDataOutput, session.canAddOutput(depthOutput) else {
            print("Unable to add depth data output to the session.")
            return
        }

        session.addOutput(depthOutput)
        depthOutput.connection(with: .depthData)?.isEnabled = true
        print("LiDAR depth sensing configured for \(device.localizedName)")
    }

    // Checks if LiDAR is available on the device.
    func isLiDARAvailable(for device: AVCaptureDevice) -> Bool {
        return device.activeFormat.supportedDepthDataFormats.contains { format in
            format.mediaType == .depthData
        }
    }

    // MARK: - AVCaptureDepthDataOutputDelegate
    func depthDataOutput(_ output: AVCaptureDepthDataOutput, didOutput depthData: AVDepthData, timestamp: CMTime, connection: AVCaptureConnection) {
        // Process the depth data
        print("Received depth data at time: \(timestamp.seconds)")
        // Example: Use depthData here for custom processing or display.
    }
}
