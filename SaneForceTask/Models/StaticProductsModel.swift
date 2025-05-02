//
//  StatcProductsModel.swift
//  SaneForceTask
//
//  Created by APPLE on 02/05/25.
//
import SwiftUI
import Observation
import Foundation


class Products: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    @Published var quantity: Int

    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
}
