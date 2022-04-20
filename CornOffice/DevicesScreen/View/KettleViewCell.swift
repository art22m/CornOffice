//
//  KettleViewCell.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit

class KettleViewCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier = "KettleViewCell"
    
    // MARK: - UI
    
    let kettleLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "kettle")
        return image
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    let deviceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    let controlPanelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "Control panel"
        
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.text = "Temperature:"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let turnOnButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "power"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        clipsToBounds = true
        
        backgroundColor = .clear
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 5, bottom: 0, right: 5))
    }
    
    // MARK: - Layout
    
    func setupViews() {
        contentView.addSubview(kettleLogo)
        contentView.addSubview(placeLabel)
        contentView.addSubview(deviceNameLabel)
        contentView.addSubview(controlPanelLabel)
        
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(turnOnButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            kettleLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            kettleLogo.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            kettleLogo.widthAnchor.constraint(equalToConstant: 50),
            kettleLogo.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            placeLabel.leadingAnchor.constraint(equalTo: kettleLogo.trailingAnchor, constant: 5),
            placeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            placeLabel.heightAnchor.constraint(equalToConstant: 30),
            placeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            deviceNameLabel.leadingAnchor.constraint(equalTo: kettleLogo.trailingAnchor, constant: 5),
            deviceNameLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 5),
            deviceNameLabel.heightAnchor.constraint(equalToConstant: 25),
            deviceNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            controlPanelLabel.topAnchor.constraint(equalTo: kettleLogo.bottomAnchor, constant: 10),
            controlPanelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            controlPanelLabel.heightAnchor.constraint(equalToConstant: 25),
            controlPanelLabel.trailingAnchor.constraint(equalTo: turnOnButton.leadingAnchor, constant: 10)
            
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: controlPanelLabel.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 25),
            temperatureLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: controlPanelLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 10),
            valueLabel.heightAnchor.constraint(equalToConstant: 25),
            valueLabel.trailingAnchor.constraint(equalTo: turnOnButton.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            turnOnButton.topAnchor.constraint(equalTo: kettleLogo.bottomAnchor, constant: 10),
            turnOnButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            turnOnButton.heightAnchor.constraint(equalToConstant: 60),
            turnOnButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Settings
    func configure(with deviceModel: DeviceModel) {
        placeLabel.text = deviceModel.place
        deviceNameLabel.text = deviceModel.name
        valueLabel.text = String(deviceModel.value) + "°С"
        
        if deviceModel.status {
            turnOnButton.backgroundColor = .systemGray
        } else {
            turnOnButton.backgroundColor = .systemGreen
        }
    }
    
    func animate() {
        self.layoutIfNeeded()
    }
    
}
