//
//  ImageEditorView.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 01/05/23.
//

import Foundation
import UIKit

class ImageEditorView: UIView {
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
        button.setTitle("Select an image", for: .normal)
        return button
    }()
}
