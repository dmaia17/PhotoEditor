//
//  PhotoEditorTests.swift
//  PhotoEditorTests
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import XCTest
@testable import PhotoEditor

final class PhotoEditorTests: XCTestCase {
  
  var viewModel: ImageEditorViewModel!
  
  override func setUp() {
    super.setUp()
    let view = ImageEditorViewController()
    viewModel = ImageEditorViewModel(view: view)
  }
  
  override func tearDown() {
    viewModel = nil
    super.tearDown()
  }
  
  func testSelectedImage() {
    let image = UIImage(named: "emptyImage")
    viewModel.selectedImage = image
    XCTAssertEqual(viewModel.selectedImage, image)
  }
  
  func testBrightnessValue() {
    let brightnessValue: Float = 0.5
    viewModel.brightnessValue = brightnessValue
    XCTAssertEqual(viewModel.brightnessValue, brightnessValue)
  }
  
  func testContrastValue() {
    let contrastValue: Float = 0.5
    viewModel.contrastValue = contrastValue
    XCTAssertEqual(viewModel.contrastValue, contrastValue)
  }
  
  func testSaturationValue() {
    let saturationValue: Float = 0.5
    viewModel.saturationValue = saturationValue
    XCTAssertEqual(viewModel.saturationValue, saturationValue)
  }
  
  
  func testFilterOptions() {
    let expectedFilterOptions = [
      OptionFilters.sepia.description,
      OptionFilters.bloom.description,
      OptionFilters.median.description,
      OptionFilters.invert.description,
      OptionFilters.grayscale.description
    ]
    
    XCTAssertEqual(viewModel.filterOptions, expectedFilterOptions)
  }
}
