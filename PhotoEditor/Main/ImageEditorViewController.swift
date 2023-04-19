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
    return slider
  }()

  private let contrastSlider: UISlider = {
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.minimumValue = -1.0
    slider.maximumValue = 1.0
    slider.value = 1.0
    return slider
  }()

  private let saturationSlider: UISlider = {
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.minimumValue = -1.0
    slider.maximumValue = 1.0
    slider.value = 1.0
    return slider
  }()
  
  private let selectImageFilterButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Select a filter", for: .normal)
    return button
  }()

  private let selectImageButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Select a image", for: .normal)
    return button
  }()

  var viewModel: ImageEditorViewModelInterface!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.createView()
    
    brightnessSlider.addTarget(self, action: #selector(brightnessSliderValueChanged(_:)), for: .valueChanged)
    contrastSlider.addTarget(self, action: #selector(contrastSliderValueChanged(_:)), for: .valueChanged)
    saturationSlider.addTarget(self, action: #selector(saturationSliderValueChanged(_:)), for: .valueChanged)
    selectImageFilterButton.addTarget(self, action: #selector(selectImageFilterButtonTapped), for: .touchUpInside)
    selectImageButton.addTarget(self, action: #selector(selectImageButtonTapped), for: .touchUpInside)
  }

  @objc private func selectImageButtonTapped(_ sender: UIButton) {
    viewModel.selectImage(view: self)
  }
  
  @objc private func selectImageFilterButtonTapped(_ sender: UIButton) {
    viewModel.applyFilter()
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
  func updateImage(image: UIImage) {
    imageView.image = image
  }
}

extension ImageEditorViewController {
  func createView() {
    view.backgroundColor = .white
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(imageView)
    contentView.addSubview(brightnessSlider)
    contentView.addSubview(contrastSlider)
    contentView.addSubview(saturationSlider)
    contentView.addSubview(selectImageFilterButton)
    contentView.addSubview(selectImageButton)

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

      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      imageView.bottomAnchor.constraint(equalTo: brightnessSlider.topAnchor, constant: -20),
      imageView.heightAnchor.constraint(equalToConstant: 300),

      brightnessSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      brightnessSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      brightnessSlider.bottomAnchor.constraint(equalTo: contrastSlider.topAnchor, constant: -20),
      
      contrastSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      contrastSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      contrastSlider.bottomAnchor.constraint(equalTo: saturationSlider.topAnchor, constant: -20),

      saturationSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      saturationSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      saturationSlider.bottomAnchor.constraint(equalTo: selectImageFilterButton.topAnchor, constant: -20),
      
      selectImageFilterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      selectImageFilterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      selectImageFilterButton.bottomAnchor.constraint(equalTo: selectImageButton.topAnchor, constant: -20),
      selectImageFilterButton.heightAnchor.constraint(equalToConstant: 44),

      selectImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      selectImageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      selectImageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      selectImageButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
