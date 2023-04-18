//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import UIKit

class ImageEditorViewController: UIViewController {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .lightGray
    return imageView
  }()
  
  var viewModel: ImageEditorViewModelInterface!
  private var filter: CIFilter? = CIFilter(name: "CIColorControls")
  private var filteredImage: CIImage?
  private var originalImage: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.createView()
    
  }
  
  @objc private func selectImageButtonTapped(_ sender: UIButton) {
    viewModel.selectImage(view: self)
  }
  
  @objc private func brightnessSliderValueChanged(_ sender: UISlider) {
    viewModel.updateBrightness(value: sender.value)
  }
  
  @objc private func contrastSliderValueChanged(_ sender: UISlider) {
    viewModel.updateContrast(value: sender.value)
  }
  
  @objc private func saturationSliderValueChanged(_ sender: UISlider) {
    viewModel.updateSaturation(value: sender.value)
  }
}

extension ImageEditorViewController: ImageEditorViewInterface {
  func updateImage(image: UIImage) {
    imageView.image = image
    originalImage = image
  }
}

extension ImageEditorViewController {
  func createView() {
    view.backgroundColor = .white
    view.addSubview(imageView)
    
    let selectImageButton = UIButton(type: .system)
    selectImageButton.translatesAutoresizingMaskIntoConstraints = false
    selectImageButton.setTitle("Select Image", for: .normal)
    selectImageButton.addTarget(self, action: #selector(selectImageButtonTapped), for: .touchUpInside)
    view.addSubview(selectImageButton)
    
    let brightnessSlider = UISlider()
    brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
    brightnessSlider.minimumValue = -1.0
    brightnessSlider.maximumValue = 1.0
    brightnessSlider.addTarget(self, action: #selector(brightnessSliderValueChanged(_:)), for: .valueChanged)
    view.addSubview(brightnessSlider)
    
    let contrastSlider = UISlider()
    contrastSlider.translatesAutoresizingMaskIntoConstraints = false
    contrastSlider.minimumValue = -1.0
    contrastSlider.maximumValue = 1.0
    contrastSlider.addTarget(self, action: #selector(contrastSliderValueChanged(_:)), for: .valueChanged)
    view.addSubview(contrastSlider)
    
    let saturationSlider = UISlider()
    saturationSlider.translatesAutoresizingMaskIntoConstraints = false
    saturationSlider.minimumValue = -1.0
    saturationSlider.maximumValue = 1.0
    saturationSlider.addTarget(self, action: #selector(saturationSliderValueChanged(_:)), for: .valueChanged)
    view.addSubview(saturationSlider)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      imageView.bottomAnchor.constraint(equalTo: brightnessSlider.topAnchor, constant: -20),
      
      brightnessSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      brightnessSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      brightnessSlider.bottomAnchor.constraint(equalTo: contrastSlider.topAnchor, constant: -20),
      
      contrastSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      contrastSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      contrastSlider.bottomAnchor.constraint(equalTo: saturationSlider.topAnchor, constant: -20),
      
      saturationSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      saturationSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      saturationSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      saturationSlider.bottomAnchor.constraint(equalTo: selectImageButton.topAnchor, constant: -20),
      
      selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      selectImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      selectImageButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
