//
//  PHEButton.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 19/04/23.
//

import Foundation
import UIKit

public class PHEButton: UIButton {
  private var textButton: String = ""
  private var border = CAShapeLayer()
  
  ///if the "isEnabled" variable is falsse, it disables the button interactions
  override public var isEnabled: Bool {
    didSet {
      setDisable(disabled: !isEnabled)
    }
  }
  
  //MARK: LifeCycle
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    defaultConfigs()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    defaultConfigs()
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    setUpBorderView()
    
    self.addTarget(self,action: #selector(pulseAnimation), for: .touchUpInside)
    self.addTarget(self, action: #selector(disableForASec), for: .touchUpInside)
  }
  
  //MARK: Initialize Functions
  private func defaultConfigs() {
    setDisable(disabled: false)
    titleLabel?.textAlignment = .center
    layer.borderWidth = Margins.buttonBorderWidth
    layer.masksToBounds = true
    layer.cornerRadius = Margins.buttonCornerRadius
    
    border.lineDashPattern = nil
    border.strokeColor = UIColor.buttonColor.cgColor
    
    self.backgroundColor = UIColor.buttonColor
    layer.borderColor = UIColor.buttonColor.cgColor
    
    NSLayoutConstraint.activate([
      heightAnchor.constraint(equalToConstant: Margins.buttonHeight)
    ])
  }
  
  //MARK: Public Functions
  ///Set title button
  public func setCustomTitle(text: String) {
    self.textButton = text
    self.setTitle(text, for: .normal)
  }
  
  //MARK: Private Functions
  private func setUpBorderView() {
    border.lineWidth = Margins.buttonDodHeight
    border.frame = self.bounds
    border.fillColor = nil
    border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: Margins.buttonCornerRadius).cgPath
    layer.addSublayer(border)
  }
  
  private func setDisable(disabled: Bool) {
    if disabled {
      border.lineDashPattern = [0]
      border.strokeColor = UIColor.buttonDisableColor.cgColor
      
      self.backgroundColor = UIColor.buttonDisableColor
      layer.borderColor = UIColor.buttonDisableColor.cgColor
    } else {
      border.lineDashPattern = nil
      border.strokeColor = UIColor.buttonColor.cgColor
      
      self.backgroundColor = UIColor.buttonColor
      layer.borderColor = UIColor.buttonColor.cgColor
    }
  }
  
  //MARK: Touch Animation
  @objc func disableForASec() {
    self.isUserInteractionEnabled = false
    DispatchQueue.main.async {
      Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
        self.isUserInteractionEnabled = true
      }
    }
  }
  
  @objc func pulseAnimation() {
    UIView.animate(withDuration: TimeInterval(0.1), animations: {
      self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }, completion: { _ in
      UIView.animate(withDuration: TimeInterval(0.1),  animations: { () -> Void in
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
      })
    })
  }
}
