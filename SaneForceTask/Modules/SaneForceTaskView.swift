//
//  wasteUi.swift
//  SaneForceTask
//
//  Created by APPLE on 02/05/25.
//

import SwiftUI

struct SaneForceTaskView: View {
    @State private var products = [
        Products(name: "Arokya 150 Ml Milk", quantity: 1),
        Products(name: "ACKLOFEN SP 10T", quantity: 1),
        Products(name: "DOXOGAL 400 TAB 10T", quantity: 1),
        Products(name: "DR. X-100 TABLETS 3x4T", quantity: 1),
        Products(name: "DR. X SHILAJIT CAPSULES 10C", quantity: 1),
        Products(name: "DR. X- SPRAY 15GM", quantity: 1),
        Products(name: "DR. X-100 GOLD TAB 10T", quantity: 1),
        Products(name: "DR. X-100 TABS", quantity: 1),
        Products(name: "DR. X-100 TABS 4T (RED)", quantity: 1),
        Products(name: "DR. X-50 TABLETS", quantity: 1)
    ]
    @StateObject private var viewModel = MainViewModel()
    @StateObject var alertViewModel = AlertViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Sane Force Task")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            List {
                ForEach(products) { product in
                    VStack(spacing: 10) {
                        HStack(spacing: 3) {
                            Text(product.name)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 10) {
                                Text("0")
                                Button(action: {
                                    product.quantity += 1
                                }) {
                                    Text("+")
                                        .frame(width: 30, height: 30)
                                        .background(Color(hex: "6200E9"))
                                        .foregroundColor(.white)
                                        .cornerRadius(4)
                                }
                                Text("\(product.quantity)")
                                Button(action: {
                                    if product.quantity > 0 {
                                        product.quantity -= 1
                                    }
                                }) {
                                    Text("-")
                                        .frame(width: 30, height: 30)
                                        .background(Color(hex: "6200E9"))
                                        .foregroundColor(.white)
                                        .cornerRadius(4)
                                }
                                
                                Text("0")
                            }
                            
                            Button(action: {
                                if let index = products.firstIndex(where: { $0.id == product.id }) {
                                    products.remove(at: index)
                                }
                            }) {
                                Text("DEL")
                                    .padding(5)
                                    .background(Color(hex: "6200E9"))
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                                    .padding(.trailing, 6)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical)
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(PlainListStyle())
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                viewModel.saveProducts(alertViewModel: alertViewModel)
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "6200E9"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .alert(isPresented: $alertViewModel.showAlert) {
            Alert(title: Text(alertViewModel.alertTitle),
                  message: Text(alertViewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    SaneForceTaskView()
}
