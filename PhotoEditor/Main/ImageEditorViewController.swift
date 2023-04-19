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
    imageView.backgroundColor = .lightGray
    return imageView
  }()
  
  private let brightnessSlider: UISlider = {
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.minimumValue = -1.0
    slider.maximumValue = 1.0
    slider.isEnabled = false
    return slider
  }()
  
  private let contrastSlider: UISlider = {
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.minimumValue = -1.0
    slider.maximumValue = 1.0
    slider.value = 1.0
    slider.isEnabled = false
    return slider
  }()
  
  private let saturationSlider: UISlider = {
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.minimumValue = -1.0
    slider.maximumValue = 1.0
    slider.value = 1.0
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
  }
  
  private func configureActions() {
    brightnessSlider.addTarget(self, action: #selector(brightnessSliderValueChanged(_:)), for: .valueChanged)
    contrastSlider.addTarget(self, action: #selector(contrastSliderValueChanged(_:)), for: .valueChanged)
    saturationSlider.addTarget(self, action: #selector(saturationSliderValueChanged(_:)), for: .valueChanged)
    imageFilterButton.addTarget(self, action: #selector(imageFilterButtonClicked), for: .touchUpInside)
    saveImageButton.addTarget(self, action: #selector(saveImageButtonClicked), for: .touchUpInside)
    discardChangesButton.addTarget(self, action: #selector(discardChangesButtonClicked), for: .touchUpInside)
    selectImageButton.addTarget(self, action: #selector(selectImageButtonClicked), for: .touchUpInside)
  }
  
  @objc private func imageFilterButtonClicked(_ sender: UIButton) {
    viewModel.applyFilterClicked(view: self)
  }
  
  @objc private func saveImageButtonClicked(_ sender: UIButton) {
    viewModel.saveImageClicked()
  }
  
  @objc private func discardChangesButtonClicked(_ sender: UIButton) {
    viewModel.discardImageChangesClicked()
  }
  
  @objc private func selectImageButtonClicked(_ sender: UIButton) {
    viewModel.selectImageClicked(view: self)
  }
  
  @objc private func brightnessSliderValueChanged(_ sender: UISlider) {
    viewModel.brightnessValue = sender.value
  }
  
  @objc private func contrastSliderValueChanged(_ sender: UISlider) {
    viewModel.contrastValue = sender.value
  }
  
  @objc private func saturationSliderValueChanged(_ sender: UISlider) {
    viewModel.saturationValue = sender.value
  }
}

extension ImageEditorViewController: ImageEditorViewInterface {
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
      
      contrastSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      contrastSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      contrastSlider.bottomAnchor.constraint(equalTo: saturationSlider.topAnchor, constant: -Margins.defaultMargin),
      
      saturationSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.defaultMargin),
      saturationSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.defaultMargin),
      saturationSlider.bottomAnchor.constraint(equalTo: selectImageButton.topAnchor, constant: -Margins.defaultMargin),
      
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
