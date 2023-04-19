//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import UIKit

class ImageEditorViewController: UIViewController {
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let contentView: UIView = {
    let contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    return contentView
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "emptyImage")
    return imageView
  }()
  
  private let brightnessSlider: PHESlider = {
    let slider = PHESlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.isEnabled = false
    return slider
  }()
  
  private let contrastSlider: PHESlider = {
    let slider = PHESlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.isEnabled = false
    return slider
  }()
  
  private let saturationSlider: PHESlider = {
    let slider = PHESlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.isEnabled = false
    return slider
  }()
  
  private let imageFilterButton: PHEButton = {
    let button = PHEButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Select a filter", for: .normal)
    button.isEnabled = false
    return button
  }()
  
  private let saveImageButton: PHEButton = {
    let button = PHEButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Save image", for: .normal)
    button.isEnabled = false
    return button
  }()
  
  private let discardChangesButton: PHEButton = {
    let button = PHEButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Discard changes", for: .normal)
    button.isEnabled = false
    return button
  }()
  
  private let selectImageButton: PHEButton = {
    let button = PHEButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Select a image", for: .normal)
    return button
  }()
  
  var viewModel: ImageEditorViewModelInterface!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createView()
    configureActions()
    configureSliders()
  }
  
  private func configureActions() {
    imageFilterButton.addTarget(self, action: #selector(imageFilterButtonClicked), for: .touchUpInside)
    saveImageButton.addTarget(self, action: #selector(saveImageButtonClicked), for: .touchUpInside)
    discardChangesButton.addTarget(self, action: #selector(discardChangesButtonClicked), for: .touchUpInside)
    selectImageButton.addTarget(self, action: #selector(selectImageButtonClicked), for: .touchUpInside)
  }
  
  private func configureSliders() {
    brightnessSlider.delegate = self
    brightnessSlider.isEnabled = false
    
    contrastSlider.delegate = self
    contrastSlider.isEnabled = false
    
    saturationSlider.delegate = self
    saturationSlider.isEnabled = false
    
    brightnessSlider.configureView(text: "Brightness", value: 0.0, minValue: -1.0, maxValue: 1.0)
    contrastSlider.configureView(text: "Contrast", value: 1.0, minValue: 0.0, maxValue: 2.0)
    saturationSlider.configureView(text: "Saturation", value: 1.0, minValue: 0.0, maxValue: 2.0)
  }
  
  @objc private func imageFilterButtonClicked(_ sender: UIButton) {
    viewModel.applyFilterClicked()
  }
  
  @objc private func saveImageButtonClicked(_ sender: UIButton) {
    viewModel.saveImageClicked()
  }
  
  @objc private func discardChangesButtonClicked(_ sender: UIButton) {
    viewModel.discardImageChangesClicked()
  }
  
  @objc private func selectImageButtonClicked(_ sender: UIButton) {
    viewModel.selectImageClicked()
  }
}

extension ImageEditorViewController: ImageEditorViewInterface {
  func getView() -> UIViewController {
    return self
  }
  
  func imageSelected(image: UIImage) {
    imageView.image = image
    
    brightnessSlider.isEnabled = true
    contrastSlider.isEnabled = true
    saturationSlider.isEnabled = true
    imageFilterButton.isEnabled = true
    imageView.backgroundColor = .clear
  }
  
  func enableUpdatedsButton() {
    saveImageButton.isEnabled = true
    discardChangesButton.isEnabled = true
  }
  
  func configureViewsToInitialState() {
    brightnessSlider.value = 0.0
    contrastSlider.value = 1.0
    saturationSlider.value = 1.0
    
    saveImageButton.isEnabled = false
    discardChangesButton.isEnabled = false
  }
}

extension ImageEditorViewController {
  func createView() {
    view.backgroundColor = .backgroundColor
    view.addSubview(scrollView)
    
    scrollView.addSubview(contentView)
    contentView.addSubview(imageView)
    contentView.addSubview(brightnessSlider)
    contentView.addSubview(contrastSlider)
    contentView.addSubview(saturationSlider)
    
    contentView.addSubview(selectImageButton)
    contentView.addSubview(imageFilterButton)
    contentView.addSubview(saveImageButton)
    contentView.addSubview(discardChangesButton)
    
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 62),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.defaultMargin),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      imageView.bottomAnchor.constraint(equalTo: brightnessSlider.topAnchor, constant: -Margins.defaultMargin),
      imageView.heightAnchor.constraint(equalToConstant: 300),
      
      brightnessSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      brightnessSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      brightnessSlider.bottomAnchor.constraint(equalTo: contrastSlider.topAnchor, constant: -Margins.defaultMargin),
      brightnessSlider.heightAnchor.constraint(equalToConstant: 50),
      
      contrastSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      contrastSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      contrastSlider.bottomAnchor.constraint(equalTo: saturationSlider.topAnchor, constant: -Margins.defaultMargin),
      contrastSlider.heightAnchor.constraint(equalToConstant: 50),
      
      saturationSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      saturationSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      saturationSlider.bottomAnchor.constraint(equalTo: selectImageButton.topAnchor, constant: -Margins.defaultMargin),
      saturationSlider.heightAnchor.constraint(equalToConstant: 50),
      
      selectImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      selectImageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      selectImageButton.bottomAnchor.constraint(equalTo: imageFilterButton.topAnchor, constant: -Margins.defaultMargin),
      
      imageFilterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      imageFilterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      imageFilterButton.bottomAnchor.constraint(equalTo: saveImageButton.topAnchor, constant: -Margins.defaultMargin),
      
      saveImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      saveImageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      saveImageButton.bottomAnchor.constraint(equalTo: discardChangesButton.topAnchor, constant: -Margins.defaultMargin),
      
      discardChangesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      discardChangesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      discardChangesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margins.defaultMargin)
    ])
  }
}

extension ImageEditorViewController: PHESliderProtocol {
  func valueChanged(_ sender: PHESlider, value: Float) {
    switch sender {
    case brightnessSlider:
      viewModel.brightnessValue = value
    case contrastSlider:
      viewModel.contrastValue = value
    case saturationSlider:
      viewModel.saturationValue = value
    default:
      break
    }
  }
}
