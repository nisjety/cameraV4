//
//  LensSelectionManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 19/08/2024.
//

import Foundation
import AVFoundation
import Combine

final class LensSelectionManager: ObservableObject {
    @Published var selectedLenses: [AVCaptureDevice] = []

    private let multiLensDeviceManager: MultiLensDeviceManager
    private var cancellables = Set<AnyCancellable>()

    init(multiLensDeviceManager: MultiLensDeviceManager) {
        self.multiLensDeviceManager = multiLensDeviceManager
        setupInitialLensSelection()
        observeLenses()
    }

    // Set up the initial lens selection based on the current active lenses in MultiLensDeviceManager
    private func setupInitialLensSelection() {
        Task {
            self.selectedLenses = await multiLensDeviceManager.getActiveLenses()
        }
    }

    // Toggle the selection of a lens and sync with MultiLensDeviceManager
    func toggleLens(_ lens: AVCaptureDevice) {
        if selectedLenses.contains(lens) {
            selectedLenses.removeAll { $0 == lens }
        } else {
            selectedLenses.append(lens)
        }
        updateLensConfiguration()
    }

    // Apply the updated lens configuration in MultiLensDeviceManager
    private func updateLensConfiguration() {
        Task {
            await multiLensDeviceManager.updateActiveLenses(selectedLenses)
        }
    }

    // Observe changes in the active lenses managed by MultiLensDeviceManager
    private func observeLenses() {
        multiLensDeviceManager.activeLensesPublisher
            .sink { [weak self] lenses in
                self?.selectedLenses = lenses
            }
            .store(in: &cancellables)
    }
}
