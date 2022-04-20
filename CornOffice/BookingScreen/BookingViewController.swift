//
//  BookingViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit

class BookingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        
        self.navigationItem.title = "Booking"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "It seems that all rooms are booked =("
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sensors_screen")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
