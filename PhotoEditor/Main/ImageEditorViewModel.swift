//
//  ImageEditorViewModel.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import Foundation
import UIKit
import CoreImage
import Photos

class ImageEditorViewModel: NSObject {

    private weak var view: ImageEditorViewInterface?
    private var imagePicker = UIImagePickerController()
    private var originalImage: UIImage?

    var selectedImage: UIImage? {
        didSet {
            if let selectedImage {
                view?.imageSelected(image: selectedImage)
            }
        }
    }

    var brightnessValue: Float = 0.0 {
        didSet {
            applyFiltersOnImage()
        }
    }

    var contrastValue: Float = 1.0 {
        didSet {
            applyFiltersOnImage()
        }
    }

    var saturationValue: Float = 1.0 {
        didSet {
            applyFiltersOnImage()
        }
    }

    private var currentFilter: OptionFilters = OptionFilters.original {
        didSet {
            applyFiltersOnImage()
        }
    }

    let filterOptions = [
        OptionFilters.sepia.description,
        OptionFilters.bloom.description,
        OptionFilters.median.description,
        OptionFilters.invert.description,
        OptionFilters.grayscale.description
    ]

    init(view: ImageEditorViewInterface) {
        self.view = view
    }

    private func applyFilter(image: UIImage, filter: CIFilter) -> UIImage? {
        guard let output = filter.outputImage else { return nil }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return nil }
        return UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
    }

    private func imageWithNewPropertiesApplied(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let filter: CIFilter? = CIFilter(name: "CIColorControls")

            if let originalImage = self.originalImage, let filter, let sourceImage = CIImage(image: originalImage) {
                filter.setValue(sourceImage, forKey: kCIInputImageKey)
                filter.setValue(self.brightnessValue, forKey: kCIInputBrightnessKey)
                filter.setValue(self.contrastValue, forKey: kCIInputContrastKey)
                filter.setValue(self.saturationValue, forKey: kCIInputSaturationKey)

                let filteredImage = self.applyFilter(image: originalImage, filter: filter)
                completion(filteredImage)
            } else {
                completion(nil)
            }
        }
    }

    private func applyFiltersOnImage() {
        imageWithNewPropertiesApplied(completion: { filteredImage in
            self.view?.enableUpdatedsButton()

            switch self.currentFilter {
            case OptionFilters.sepia:
                let filter = CIFilter(name:"CISepiaTone")

                if let filteredImage, let filter, let sourceImage = CIImage(image: filteredImage) {
                    filter.setValue(sourceImage, forKey: kCIInputImageKey)
                    filter.setValue(0.9, forKey: kCIInputIntensityKey)

                    self.selectedImage = self.applyFilter(image: filteredImage, filter: filter)
                }

            case OptionFilters.bloom:
                let filter = CIFilter(name:"CIBloom")

                if let filteredImage, let filter, let sourceImage = CIImage(image: filteredImage) {
                    filter.setValue(sourceImage, forKey: kCIInputImageKey)
                    filter.setValue(0.9, forKey: kCIInputIntensityKey)
                    filter.setValue(10, forKey: kCIInputRadiusKey)

                    self.selectedImage = self.applyFilter(image: filteredImage, filter: filter)
                }

            case OptionFilters.median:
                let filter = CIFilter(name: "CIMedianFilter")

                if let filteredImage, let filter, let sourceImage = CIImage(image: filteredImage) {
                    filter.setValue(sourceImage, forKey: kCIInputImageKey)

                    self.selectedImage = self.applyFilter(image: filteredImage, filter: filter)
                }

            case OptionFilters.invert:
                let filter = CIFilter(name: "CIColorInvert")

                if let filteredImage, let filter, let sourceImage = CIImage(image: filteredImage) {
                    filter.setValue(sourceImage, forKey: kCIInputImageKey)

                    self.selectedImage = self.applyFilter(image: filteredImage, filter: filter)
                }

            case OptionFilters.grayscale:
                let filter = CIFilter(name: "CIColorControls")

                if let filteredImage, let filter, let sourceImage = CIImage(image: filteredImage) {
                    filter.setValue(sourceImage, forKey: kCIInputImageKey)
                    filter.setValue(0.0, forKey: kCIInputSaturationKey)

                    self.selectedImage = self.applyFilter(image: filteredImage, filter: filter)
                }

            default:
                self.selectedImage = filteredImage
            }
        })

    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let view {
            let alertController = UIAlertController(title: nil, message: "Image saved on gallery!", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)

            view.getView().present(alertController, animated: true, completion: nil)
        }
    }
}

extension ImageEditorViewModel: ImageEditorViewModelInterface {
    func applyFilterClicked() {
        if let view {
            let alertController = UIAlertController(title: "Select a filter", message: nil, preferredStyle: .alert)

            for (index, option) in filterOptions.enumerated() {
                let action = UIAlertAction(title: option, style: .default) { (action) in
                    self.currentFilter = OptionFilters.fromIndex(index)
                }

                alertController.addAction(action)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            view.getView().present(alertController, animated: true, completion: nil)
        }
    }

    func saveImageClicked() {
        if let selectedImage {
            UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(saveCompleted), nil)
        }
    }

    func discardImageChangesClicked() {
        brightnessValue = 0.0
        contrastValue = 1.0
        saturationValue = 1.0
        currentFilter = OptionFilters.original

        selectedImage = originalImage
        view?.configureViewsToInitialState()
    }

    func selectImageClicked() {
        if let view {
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false

                view.getView().present(imagePicker, animated: true, completion: nil)
            }
        }
    }
}

extension ImageEditorViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            originalImage = image
            selectedImage = image
            currentFilter = OptionFilters.original

            applyFiltersOnImage()
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
