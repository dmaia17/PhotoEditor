//
//  ImageEditorView.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 18/04/23.
//

import Foundation
import UIKit

protocol ImageEditorView: AnyObject {
  func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
  func displayImage(_ image: UIImage)
}
