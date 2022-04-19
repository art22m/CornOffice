//
//  SensorManager.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import Foundation

protocol SensorManagerDelegate {
    func didFetchSensors(_ sensorManager: SensorManager, sensors: [SensorModel])
    func didFailWithError(error: Error)
}

struct SensorManager {
    var delegate: SensorManagerDelegate?
    
    func fetchSensors(for email: String) {
        guard let url = URL(string: "https://beecoder-qr-code-entrance.herokuapp.com/gadgets/sensors/\(email)") else { return }
        
        // MARK: - Fetch
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            
            if let safeData = data {
                if let sensors = parseData(jsonData: safeData) {
                    delegate?.didFetchSensors(self, sensors: sensors)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchSensors() {
        guard let url = URL(string: "https://beecoder-qr-code-entrance.herokuapp.com/sensor/all") else { return }
        
        // MARK: - Fetch
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            
            if let safeData = data {
                if let sensors = parseData(jsonData: safeData) {
                    delegate?.didFetchSensors(self, sensors: sensors)
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: - Parse
    
    private func parseData(jsonData: Data) -> [SensorModel]? {
        let decoder = JSONDecoder()
        do {
            let sensors = try decoder.decode([SensorModel].self, from: jsonData)
            
            return sensors
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
