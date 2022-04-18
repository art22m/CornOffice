//
//  EntranceManager.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import Foundation

protocol EntranceManagerDelegate {
    func didConnectSuccessfully()
    func didFailWithError()
}

struct EntranceManager {
    var delegate: EntranceManagerDelegate?
    
    func entranceRequest(with entranceModel: EntranceModel) {
        guard let url = URL(string: "https://beecoder-qr-code-entrance.herokuapp.com/login") else { return }
        print(entranceModel)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let requestBody = try JSONEncoder().encode(entranceModel)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch {
            self.delegate?.didFailWithError()
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let response = parseResponse(for: data)
                if (response == 200) {
                    delegate?.didConnectSuccessfully()
                } else {
                    delegate?.didFailWithError()
                }
            }
        }
        
        task.resume()
    }
    
    private func parseResponse(for data: Data) -> Int {
        do {
            let decodedData = try JSONDecoder().decode(EntranceResponse.self, from: data)
            print(decodedData)
            return decodedData.status
        } catch {
            return 400
        }
    }
}
