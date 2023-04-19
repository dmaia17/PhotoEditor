//
//  ImageEditorInterface.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import Foundation
import UIKit

protocol ImageEditorViewInterface: AnyObject {
  func imageSelected(image: UIImage)
  func enableUpdatedsButton()
  func configureViewsToInitialState()
}

protocol ImageEditorViewModelInterface: AnyObject {
  var brightnessValue: Float { get set }
  var contrastValue: Float { get set }
  var saturationValue: Float { get set }
  
  func applyFilterClicked(view: UIViewController)
  func saveImageClicked()
  func discardImageChangesClicked()
  func selectImageClicked(view: UIViewController)
}

enum OptionFilters {
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
    }
  }
}
