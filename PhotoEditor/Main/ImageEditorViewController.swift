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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    view.addSubview(imageView)
    
    let selectImageButton = UIButton(type: .system)
    selectImageButton.translatesAutoresizingMaskIntoConstraints = false
    selectImageButton.setTitle("Select Image", for: .normal)
    selectImageButton.addTarget(self, action: #selector(selectImageButtonTapped), for: .touchUpInside)
    view.addSubview(selectImageButton)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      imageView.bottomAnchor.constraint(equalTo: selectImageButton.topAnchor, constant: -20),
      selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      selectImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      selectImageButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  @objc private func selectImageButtonTapped(_ sender: UIButton) {
    viewModel.selectImage(view: self)
  }
}

extension ImageEditorViewController: ImageEditorViewInterface {
  func updateImage(image: UIImage) {
    imageView.image = image
  }
}
