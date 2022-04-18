//
//  SensorCollectionViewCell.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

class SensorCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let identifier = "SensorCollectionViewCell"
    
    // MARK: - UI
    
    let sensorLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "thermometer")
        image.tintColor = .black
        return image
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    let sensorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let sensorValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 35, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 20
        
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        addSubview(sensorLogo)
        addSubview(placeLabel)
        addSubview(sensorValueLabel)
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            placeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            placeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            placeLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            sensorLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            sensorLogo.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 15),
            sensorLogo.widthAnchor.constraint(equalToConstant: 50),
            sensorLogo.heightAnchor.constraint(equalToConstant: 75)
        ])

        NSLayoutConstraint.activate([
            sensorValueLabel.leadingAnchor.constraint(equalTo: sensorLogo.trailingAnchor, constant: 10),
            sensorValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sensorValueLabel.centerYAnchor.constraint(equalTo: sensorLogo.centerYAnchor),
            sensorValueLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Settings
    func configure(v1: String, v2: String, v3: String) {
        placeLabel.text = v1
        sensorNameLabel.text = v2
        sensorValueLabel.text = v3
    }
}
