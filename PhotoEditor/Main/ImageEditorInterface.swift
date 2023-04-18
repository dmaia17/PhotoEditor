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
  var brightnessValue: Float { get set }
  var contrastValue: Float { get set }
  var saturationValue: Float { get set }
  
  func selectImage(view: UIViewController)
  
  func updateBrightness(value: Float)
  func updateContrast(value: Float)
  func updateSaturation(value: Float)
}
