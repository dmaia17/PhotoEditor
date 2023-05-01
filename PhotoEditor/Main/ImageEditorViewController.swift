//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import UIKit

class ImageEditorViewController: UIViewController {
    var viewModel: ImageEditorViewModelInterface!
    var debounceTimer: Timer?
    var editorPhotoView = ImageEditorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        configureSliders()
    }

    override func loadView() {
        super.loadView()

        self.view = editorPhotoView
    }

    private func configureActions() {
        editorPhotoView.imageFilterButton.addTarget(self, action: #selector(imageFilterButtonClicked), for: .touchUpInside)
        editorPhotoView.saveImageButton.addTarget(self, action: #selector(saveImageButtonClicked), for: .touchUpInside)
        editorPhotoView.discardChangesButton.addTarget(self, action: #selector(discardChangesButtonClicked), for: .touchUpInside)
        editorPhotoView.selectImageButton.addTarget(self, action: #selector(selectImageButtonClicked), for: .touchUpInside)
    }

    private func configureSliders() {
        editorPhotoView.brightnessSlider.delegate = self
        editorPhotoView.brightnessSlider.isEnabled = false

        editorPhotoView.contrastSlider.delegate = self
        editorPhotoView.contrastSlider.isEnabled = false

        editorPhotoView.saturationSlider.delegate = self
        editorPhotoView.saturationSlider.isEnabled = false

        editorPhotoView.brightnessSlider.configureView(text: "Brightness", value: 0.0, minValue: -1.0, maxValue: 1.0)
        editorPhotoView.contrastSlider.configureView(text: "Contrast", value: 1.0, minValue: 0.0, maxValue: 2.0)
        editorPhotoView.saturationSlider.configureView(text: "Saturation", value: 1.0, minValue: 0.0, maxValue: 2.0)
    }

    @objc private func imageFilterButtonClicked(_ sender: UIButton) {
        viewModel.applyFilterClicked()
    }

    @objc private func saveImageButtonClicked(_ sender: UIButton) {
        viewModel.saveImageClicked()
    }

    @objc private func discardChangesButtonClicked(_ sender: UIButton) {
        viewModel.discardImageChangesClicked()
    }

    @objc private func selectImageButtonClicked(_ sender: UIButton) {
        viewModel.selectImageClicked()
    }
}

extension ImageEditorViewController: ImageEditorViewInterface {
    func getView() -> UIViewController {
        return self
    }

    func imageSelected(image: UIImage) {
        DispatchQueue.main.async {
            self.editorPhotoView.imageView.image = image
            
            self.editorPhotoView.brightnessSlider.isEnabled = true
            self.editorPhotoView.contrastSlider.isEnabled = true
            self.editorPhotoView.saturationSlider.isEnabled = true
            self.editorPhotoView.imageFilterButton.isEnabled = true
            self.editorPhotoView.imageView.backgroundColor = .clear
        }
    }

    func enableUpdatedsButton() {
        DispatchQueue.main.async {
            self.editorPhotoView.saveImageButton.isEnabled = true
            self.editorPhotoView.discardChangesButton.isEnabled = true
        }
    }

    func configureViewsToInitialState() {
        DispatchQueue.main.async {
            self.editorPhotoView.brightnessSlider.value = 0.0
            self.editorPhotoView.contrastSlider.value = 1.0
            self.editorPhotoView.saturationSlider.value = 1.0

            self.editorPhotoView.saveImageButton.isEnabled = false
            self.editorPhotoView.discardChangesButton.isEnabled = false
        }
    }
}

extension ImageEditorViewController: PHESliderProtocol {
    func valueChanged(_ sender: PHESlider, value: Float) {
        debounceTimer?.invalidate()

        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            switch sender {
            case self.editorPhotoView.brightnessSlider:
                self.viewModel.brightnessValue = value
            case self.editorPhotoView.contrastSlider:
                self.viewModel.contrastValue = value
            case self.editorPhotoView.saturationSlider:
                self.viewModel.saturationValue = value
            default:
                break
            }
        }
    }
}
