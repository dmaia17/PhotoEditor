//
//  ImageEditorInterface.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import Foundation
import UIKit

protocol ImageEditorViewInterface: AnyObject {
  func updateImage(image: UIImage)
}

protocol ImageEditorViewModelInterface: AnyObject {
  func selectImage(view: UIViewController)
  
  func updateBrightness(value: Float)
  func updateContrast(value: Float)
  func updateSaturation(value: Float)
}
