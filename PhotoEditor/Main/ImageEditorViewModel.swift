//
//  ImageEditorViewModel.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import Foundation
import UIKit
import CoreImage

class ImageEditorViewModel: NSObject {
  var originalImage: UIImage?
  
  var selectedImage: UIImage? {
    didSet {
      view?.imageSelected(image: selectedImage!)
    }
  }
  
  var brightnessValue: Float = 0.0 {
    didSet {
      changeProperties()
    }
  }
  
  var contrastValue: Float = 1.0 {
    didSet {
      changeProperties()
    }
  }
  
  var saturationValue: Float = 1.0 {
    didSet {
      changeProperties()
    }
  }
  
  private var imagePicker = UIImagePickerController()
  private var filter: CIFilter? = CIFilter(name: "CIColorControls")
  
  let filterOptions = [
    OptionFilters.sepia.description,
    OptionFilters.bloom.description,
    OptionFilters.median.description,
    OptionFilters.invert.description,
    OptionFilters.edges.description,
    OptionFilters.grayscale.description
  ]
  
  private weak var view: ImageEditorViewInterface?
  
  init(view: ImageEditorViewInterface) {
    self.view = view
  }
  
  private func changeProperties(newImage: Bool = false) {
    if !newImage {
      view?.enableUpdatedsButton()
    }
    
    if let originalImage, let filter, let sourceImage = CIImage(image: originalImage) {
      filter.setValue(sourceImage, forKey: kCIInputImageKey)
      filter.setValue(brightnessValue, forKey: kCIInputBrightnessKey)
      filter.setValue(contrastValue, forKey: kCIInputContrastKey)
      filter.setValue(saturationValue, forKey: kCIInputSaturationKey)
      
      guard let output = filter.outputImage else { return }
      guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
      let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
      
      selectedImage = filteredImage
    }
  }
  
  private func applyFiltersOnImage(index: Int) {
    view?.enableUpdatedsButton()
    
    switch index {
    case OptionFilters.sepia.index:
      if let originalImage, let sourceImage = CIImage(image: originalImage) {
        let sepiaFilter = CIFilter(name:"CISepiaTone")
        sepiaFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
        
        guard let output = sepiaFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.bloom.index:
      if let originalImage, let sourceImage = CIImage(image: originalImage) {
        let bloomFilter = CIFilter(name:"CIBloom")
        bloomFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        bloomFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
        bloomFilter?.setValue(10, forKey: kCIInputRadiusKey)
        
        guard let output = bloomFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.median.index:
      if let originalImage, let sourceImage = CIImage(image: originalImage) {
        let medianFilter = CIFilter(name: "CIMedianFilter")
        medianFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let output = medianFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.invert.index:
      if let originalImage, let sourceImage = CIImage(image: originalImage) {
        let invertFilter = CIFilter(name: "CIColorInvert")
        invertFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let output = invertFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.edges.index:
      if let originalImage, let sourceImage = CIImage(image: originalImage) {
        let edgesFilter = CIFilter(name:"CIEdges")
        edgesFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        edgesFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
        
        guard let output = edgesFilter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    case OptionFilters.grayscale.index:
      if let originalImage, let sourceImage = CIImage(image: originalImage) {
        let filter = CIFilter(name: "CIColorControls")
        filter!.setValue(sourceImage, forKey: kCIInputImageKey)
        filter!.setValue(0.0, forKey: kCIInputSaturationKey)
        
        guard let output = filter?.outputImage else { return }
        guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
        let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        selectedImage = filteredImage
      }
      
    default:
      break
    }
  }
}

extension ImageEditorViewModel: ImageEditorViewModelInterface {
  func applyFilterClicked(view: UIViewController) {
    let alertController = UIAlertController(title: "Select an filter", message: nil, preferredStyle: .alert)
    
    for (index, option) in filterOptions.enumerated() {
      let action = UIAlertAction(title: option, style: .default) { (action) in
        self.applyFiltersOnImage(index: index)
      }
      
      alertController.addAction(action)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    view.present(alertController, animated: true, completion: nil)
  }
  
  func saveImageClicked() {
    print("TODO: save image")
  }
  
  func discardImageChangesClicked() {
    brightnessValue = 0.0
    contrastValue = 1.0
    saturationValue = 1.0
    
    selectedImage = originalImage
    view?.configureViewsToInitialState()
  }
  
  func selectImageClicked(view: UIViewController) {
    if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
      imagePicker.delegate = self
      imagePicker.sourceType = .savedPhotosAlbum
      imagePicker.allowsEditing = false
      
      view.present(imagePicker, animated: true, completion: nil)
    }
  }
}

extension ImageEditorViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.originalImage = image
      self.selectedImage = image
      changeProperties(newImage: true)
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
