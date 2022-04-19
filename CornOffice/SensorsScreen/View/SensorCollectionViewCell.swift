//
//  SensorCollectionViewCell.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

enum SensorType {
    
}
class SensorCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let identifier = "SensorCollectionViewCell"
    
    // MARK: - UI
    
    let sensorLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "thermometer")
        image.tintColor = .black
        return image
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
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
        label.font = .systemFont(ofSize: 20, weight: .medium)
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
            sensorLogo.widthAnchor.constraint(equalToConstant: 60),
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
    func configure(sensor: SensorModel) {
        placeLabel.text = sensor.place
        sensorNameLabel.text = sensor.type
        
        switch sensor.type {
            case "temperature_sensor":
                sensorValueLabel.text = String(format: "%0.1f", sensor.value) + "°С"
                sensorLogo.image = UIImage(systemName: "thermometer")
            case "humidity_sensor":
                sensorValueLabel.text = String(format: "%0.1f", sensor.value) + "%"
                sensorLogo.image = UIImage(systemName: "humidity")
            default:
                sensorValueLabel.text = "-"
                sensorLogo.image = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
        }
    }
}
