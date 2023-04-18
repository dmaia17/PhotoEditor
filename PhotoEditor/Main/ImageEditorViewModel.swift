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
      view?.updateImage(image: selectedImage!)
    }
  }
  
  var brightnessValue: Float = 0.0 {
    didSet {
      applyFilters()
    }
  }
  
  var contrastValue: Float = 1.0 {
    didSet {
      applyFilters()
    }
  }
  
  var saturationValue: Float = 1.0 {
    didSet {
      applyFilters()
    }
  }
  
  private var imagePicker = UIImagePickerController()
  private var filter: CIFilter? = CIFilter(name: "CIColorControls")
  
  private weak var view: ImageEditorViewInterface?
  
  init(view: ImageEditorViewInterface) {
    self.view = view
  }
  
  private func applyFilters() {
    if let originalImage, let filter, let sourceImage = CIImage(image: originalImage) {
      filter.setValue(sourceImage, forKey: kCIInputImageKey)
      filter.setValue(brightnessValue, forKey: kCIInputBrightnessKey)
      filter.setValue(contrastValue, forKey: kCIInputContrastKey)
      filter.setValue(saturationValue, forKey: kCIInputSaturationKey)
      
      guard let output = filter.outputImage else { return }
      guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
      let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
      
      self.selectedImage = filteredImage
    }
  }
  
}

extension ImageEditorViewModel: ImageEditorViewModelInterface {
  func selectImage(view: UIViewController) {
    if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
      imagePicker.delegate = self
      imagePicker.sourceType = .savedPhotosAlbum
      imagePicker.allowsEditing = false
      
      view.present(imagePicker, animated: true, completion: nil)
    }
  }
  
  func updateBrightness(value: Float) {
//    if let originalImage, let filter, let sourceImage = CIImage(image: originalImage) {
//      filter.setValue(sourceImage, forKey: kCIInputImageKey)
//      filter.setValue(value, forKey: kCIInputBrightnessKey)
//
//      guard let output = filter.outputImage else { return }
//      guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
//      let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
//
//      print("updateBrightness: \(value)")
//      self.selectedImage = filteredImage
//    }
  }
  
  func updateContrast(value: Float) {
//    if let originalImage, let filter, let sourceImage = CIImage(image: originalImage) {
//      filter.setValue(sourceImage, forKey: kCIInputImageKey)
//      filter.setValue(value, forKey: kCIInputContrastKey)
//
//      guard let output = filter.outputImage else { return }
//      guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
//      let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
//
//      print("updateContrast: \(value)")
//      self.selectedImage = filteredImage
//    }
  }
  
  func updateSaturation(value: Float) {
//    if let originalImage, let filter, let sourceImage = CIImage(image: originalImage) {
//      filter.setValue(sourceImage, forKey: kCIInputImageKey)
//      filter.setValue(value, forKey: kCIInputSaturationKey)
//
//      guard let output = filter.outputImage else { return }
//      guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return }
//      let filteredImage = UIImage(cgImage: outputCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
//
//      print("updateSaturation: \(value)")
//      self.selectedImage = filteredImage
//    }
  }
}

extension ImageEditorViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.originalImage = image
      self.selectedImage = image
      applyFilters()
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
