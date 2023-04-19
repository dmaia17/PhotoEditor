//
//  PHESlider.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 19/04/23.
//

import Foundation
import UIKit

public protocol PHESliderProtocol {
  func valueChanged(_ sender: PHESlider, value: Float)
}

final public class PHESlider: UIView {
  
  public var delegate: PHESliderProtocol?
  
  public var text: String = "" {
    didSet {
      textLabel.text = text
    }
  }
  
  public var minValue: Float = 0.0 {
    didSet {
      slider.minimumValue = minValue
    }
  }
  public var maxValue: Float = 0.0 {
    didSet {
      slider.maximumValue = maxValue
    }
  }
  
  public var value: Float = 0.0 {
    didSet {
      slider.value = value
    }
  }
  
  //MARK: - LifeCycle -
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setupUI()
    constraintUI()
  }
  
  // MARK: - UI
    
  private var textLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    return label
  }()
  
  private var slider: UISlider = {
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    return slider
  }()
  
  ///if the "isEnabled" variable is false, it disables the view interactions
  public var isEnabled: Bool = true {
    didSet {
      setDisable(disabled: !isEnabled)
    }
  }
  
  public func configureView(text: String, value: Float, minValue: Float, maxValue: Float) {
    self.text = text
    self.value = value
    self.minValue = minValue
    self.maxValue = maxValue
  }
  
  private func setDisable(disabled: Bool) {
    if disabled {
      textLabel.textColor = .gray
      slider.isEnabled = false
    } else {
      textLabel.textColor = .black
      slider.isEnabled = true
    }
  }
  
  @objc private func sliderValueChanged(_ sender: UISlider) {
    if let delegate {
      delegate.valueChanged(self, value: sender.value)
    }
  }
  
  private func setupUI() {
    slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
  }
  
  private func constraintUI() {
    addSubview(textLabel)
    addSubview(slider)
    
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      textLabel.widthAnchor.constraint(equalToConstant: 90),

      slider.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor),
      slider.trailingAnchor.constraint(equalTo: trailingAnchor),
      slider.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
