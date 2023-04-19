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
      view?.imageSelected(image: selectedImage!)
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
    OptionFilters.edges.description,
    OptionFilters.grayscale.description
  ]
  
  init(view: ImageEditorViewInterface) {
    self.view = view
  }
  
  private func imageWithNewPropertiesApplied() -> UIImage? {
    let Colorsfilter: CIFilter? = CIFilter(name: "CIColorControls")
    
    if let originalImage, let Colorsfilter, let sourceImage = CIImage(image: originalImage) {
      Colorsfilter.setValue(sourceImage, forKey: kCIInputImageKey)
      Colorsfilter.setValue(brightnessValue, forKey: kCIInputBrightnessKey)
      Colorsfilter.setValue(contrastValue, forKey: kCIInputContrastKey)
      Colorsfilter.setValue(saturationValue, forKey: kCIInputSaturationKey)
      
      guard let output = Colorsfilter.outputImage else { return nil }
      guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return nil }
      let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
      
      return filteredImage
    } else {
      return nil
    }
  }
  
  private func applyFiltersOnImage() {
    var filteredImage = imageWithNewPropertiesApplied()
    view?.enableUpdatedsButton()
    
    switch currentFilter {
    case OptionFilters.sepia:
      if let filteredImage, let sourceImage = CIImage(image: filteredImage) {
        let sepiaFilter = CIFilter(name:"CISepiaTone")
        sepiaFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
        
        guard let output = sepiaFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: filteredImage.scale, orientation: filteredImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.bloom:
      if let filteredImage, let sourceImage = CIImage(image: filteredImage) {
        let bloomFilter = CIFilter(name:"CIBloom")
        bloomFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        bloomFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
        bloomFilter?.setValue(10, forKey: kCIInputRadiusKey)
        
        guard let output = bloomFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: filteredImage.scale, orientation: filteredImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.median:
      if let filteredImage, let sourceImage = CIImage(image: filteredImage) {
        let medianFilter = CIFilter(name: "CIMedianFilter")
        medianFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let output = medianFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: filteredImage.scale, orientation: filteredImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.invert:
      if let filteredImage, let sourceImage = CIImage(image: filteredImage) {
        let invertFilter = CIFilter(name: "CIColorInvert")
        invertFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let output = invertFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: filteredImage.scale, orientation: filteredImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.edges:
      if let filteredImage, let sourceImage = CIImage(image: filteredImage) {
        let edgesFilter = CIFilter(name:"CIEdges")
        edgesFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        edgesFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
        
        guard let output = edgesFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: filteredImage.scale, orientation: filteredImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.grayscale:
      if let filteredImage, let sourceImage = CIImage(image: filteredImage) {
        let filter = CIFilter(name: "CIColorControls")
        filter!.setValue(sourceImage, forKey: kCIInputImageKey)
        filter!.setValue(0.0, forKey: kCIInputSaturationKey)
        
        guard let output = filter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: filteredImage.scale, orientation: filteredImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    default:
      selectedImage = filteredImage
    }
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
      let alertController = UIAlertController(title: "Select an filter", message: nil, preferredStyle: .alert)
      
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
