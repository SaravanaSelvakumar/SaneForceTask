//
//  Main.swift
//  SaneForceTask
//
//  Created by APPLE on 02/05/25.
//

import SwiftUI
import Observation
import Foundation



class MainViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var productId =  ""
    
    func fetchProducts(alertViewModel: AlertViewModel) {
        guard let url = URL(string: "\(baseURL)?axn=get/taskproducts&divisionCode=258") else {
            alertViewModel.displayAlert(message: "Invalid URL.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    alertViewModel.displayAlert(message: error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    alertViewModel.displayAlert(message: "No data received from server.")
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode([Product].self, from: data)
                    self.products = decodedResponse
                } catch {
                    alertViewModel.displayAlert(message: JSON_CONVERSION_ERROR)
                }
            }
        }.resume()
    }
    
    func saveProducts(alertViewModel: AlertViewModel) {
        guard let url = URL(string: "\(baseURL)?axn=save/taskproddets&divisionCode=258") else {
            alertViewModel.displayAlert(message: "Invalid URL.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postData: [String: Any] = ["data": products.map {
            [
                "product_code": $0.product_code,
                "product_name": $0.product_name,
                    "product_unit": $0.product_unit,
                    "convQty": $0.convQty
            ] as [String: Any]
        }]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: [])
        } catch {
            alertViewModel.displayAlert(message: "Failed to encode product data.")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertViewModel.displayAlert(message: "Save Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    alertViewModel.displayAlert(message: "Unexpected server response.")
                    return
                }
                print("Products saved successfully!")
                alertViewModel.displayAlert(message: "Products saved successfully!")
                self.fetchProducts(alertViewModel: alertViewModel)
            }
        }.resume()
    }
}
