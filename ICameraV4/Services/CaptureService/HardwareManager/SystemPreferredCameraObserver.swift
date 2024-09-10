//
//  SystemPreferredCameraObserver.swift
//  iCameraV3
//
//  Created by Ima Da Costa on 03/08/2024.
//

import Foundation
import AVFoundation

class SystemPreferredCameraObserver: NSObject {
    
    private let systemPreferredKeyPath = "systemPreferredCamera"
    
    let changes: AsyncStream<AVCaptureDevice?>
    private var continuation: AsyncStream<AVCaptureDevice?>.Continuation?

    // Additional Properties to Manage Advanced Capabilities
    private var observationTask: Task<Void, Never>?
    private let lidarManager: LidarManager
    private let cameraConfigurationManager: CameraConfigurationManager
    
    init(lidarManager: LidarManager = LidarManager(),
         cameraConfigurationManager: CameraConfigurationManager = CameraConfigurationManager()) {
        
        let (changes, continuation) = AsyncStream<AVCaptureDevice?>.makeStream()
        self.changes = changes
        self.continuation = continuation
        
        self.lidarManager = lidarManager
        self.cameraConfigurationManager = cameraConfigurationManager
        
        super.init()
        
        // Observe the system's preferred camera
        AVCaptureDevice.self.addObserver(self, forKeyPath: systemPreferredKeyPath, options: [.new], context: nil)
        startObservingAdvancedCapabilities()
    }

    deinit {
        continuation?.finish()
        observationTask?.cancel()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case systemPreferredKeyPath:
            if let newDevice = change?[.newKey] as? AVCaptureDevice {
                continuation?.yield(newDevice)
                handleDeviceChange(newDevice)
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func handleDeviceChange(_ newDevice: AVCaptureDevice) {
        // Adjust configuration based on the new device and its capabilities
        if lidarManager.isLiDARAvailable(for: newDevice) {
            lidarManager.configureForDepthSensing(on: newDevice)
        }
        
        cameraConfigurationManager.adjustConfiguration(for: newDevice)
    }
    
    private func startObservingAdvancedCapabilities() {
        observationTask = Task {
            for await device in changes {
                guard let device = device else { continue }
                
                // Check and configure the device based on its advanced capabilities
                if lidarManager.isLiDARAvailable(for: device) {
                    lidarManager.configureForDepthSensing(on: device)
                }
                
                cameraConfigurationManager.adjustConfiguration(for: device)
            }
        }
    }
}
