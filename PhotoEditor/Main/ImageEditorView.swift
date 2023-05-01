//
//  ImageEditorView.swift
//  PhotoEditor
//
//  Created by Daniel Maia dos Passos on 01/05/23.
//

import Foundation
import UIKit

class ImageEditorView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emptyImage")
        return imageView
    }()

    let brightnessSlider: PHESlider = {
        let slider = PHESlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isEnabled = false
        return slider
    }()

    let contrastSlider: PHESlider = {
        let slider = PHESlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isEnabled = false
        return slider
    }()

    let saturationSlider: PHESlider = {
        let slider = PHESlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isEnabled = false
        return slider
    }()

    let imageFilterButton: PHEButton = {
        let button = PHEButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select a filter", for: .normal)
        button.isEnabled = false
        return button
    }()

    let saveImageButton: PHEButton = {
        let button = PHEButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save image", for: .normal)
        button.isEnabled = false
        return button
    }()

    let discardChangesButton: PHEButton = {
        let button = PHEButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Discard changes", for: .normal)
        button.isEnabled = false
        return button
    }()

    let selectImageButton: PHEButton = {
        let button = PHEButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select an image", for: .normal)
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        createView()
    }

    func createView() {
        self.backgroundColor = .backgroundColor
        self.addSubview(scrollView)

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
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 62),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

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
