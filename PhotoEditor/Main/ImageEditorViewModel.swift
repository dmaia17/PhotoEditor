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
  var selectedImage: UIImage?
  var imagePicker = UIImagePickerController()
  
  private weak var view: ImageEditorViewInterface?
  
  init(view: ImageEditorViewInterface) {
    self.view = view
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
}

extension ImageEditorViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.selectedImage = image
      view?.updateImage(image: image)
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
