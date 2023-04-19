//
//  ImageEditorInterface.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import Foundation
import UIKit

protocol ImageEditorViewInterface: AnyObject {
  func getView() -> UIViewController
  func imageSelected(image: UIImage)
  func enableUpdatedsButton()
  func configureViewsToInitialState()
}

protocol ImageEditorViewModelInterface: AnyObject {
  var brightnessValue: Float { get set }
  var contrastValue: Float { get set }
  var saturationValue: Float { get set }
  
  func applyFilterClicked()
  func saveImageClicked()
  func discardImageChangesClicked()
  func selectImageClicked()
}

enum OptionFilters {
  case original
  case sepia
  case bloom
  case median
  case invert
  case edges
  case grayscale
  
  var description: String {
    switch self {
    case .sepia:
      return "Sepia"
    case .bloom:
      return "Bloom"
    case .median:
      return "Median"
    case .invert:
      return "Color Invert"
    case .edges:
      return "Edges"
    case .grayscale:
      return "Grayscale"
    default:
      return ""
    }
  }
  
  var key: String {
    switch self {
    case .sepia:
      return "CISepiaTone"
    case .bloom:
      return "CIBloom"
    case .median:
      return "CIMedianFilter"
    case .invert:
      return "CIColorInvert"
    case .edges:
      return "CIEdges"
    case .grayscale:
      return "CIColorControls"
    default:
      return ""
    }
  }
  
  var index: Int {
    switch self {
    case .sepia:
      return 0
    case .bloom:
      return 1
    case .median:
      return 2
    case .invert:
      return 3
    case .edges:
      return 4
    case .grayscale:
      return 5
    default:
      return -1
    }
  }
  
  static func fromIndex(_ index: Int) -> OptionFilters {
    switch index {
    case 0:
      return .sepia
    case 1:
      return .bloom
    case 2:
      return .median
    case 3:
      return .invert
    case 4:
      return .edges
    case 5:
      return .grayscale
    default:
      return .original
    }
  }
}
