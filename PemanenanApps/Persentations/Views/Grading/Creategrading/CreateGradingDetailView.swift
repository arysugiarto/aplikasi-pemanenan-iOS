//
//  DetailsGradingView.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 26/02/25.
//

import SwiftUI
import CoreData

struct GradingDetailView: View {
    @StateObject var viewModel: CreateGradingViewModel
        @State private var selectedOrder: String = ""
        @State private var selectedSpecies: String = ""
        @State private var selectedLocation: String = ""
        @State private var selectedDate: Date = Date()
        
        let orderItems = ["0010/SOBI/FPO-KLP/LHP/EKS-I/2023", "0010/SOBI/FPO-KLP/LHP/EKS-I/2024"]
        let speciesItems = ["Jati", "Mahoni", "Sengon"]
        let locationItems = ["Kulon Progo", "Sragen", "Jogja"]
        
        let grading: GradingCreateEntity
        
        init(viewModel: CreateGradingViewModel, grading: GradingCreateEntity) {
            self._viewModel = StateObject(wrappedValue: viewModel)
            self.grading = grading // Ini perlu untuk menyimpan grading
        }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 12) {
                
                Text("Pesanan Penjualan")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                DropDownView(selectedItem: $selectedOrder, items: orderItems)
                
                Text("Species")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                DropDownView(selectedItem: $selectedSpecies, items: speciesItems)
                
                Text("Lokasi TPT Muat")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                DropDownView(selectedItem: $selectedLocation, items: locationItems)
                
                Text("Tanggal")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                DatePicker("Pilih Tanggal", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal, 16)
                
                HStack {
                    Spacer()
                    Button(action: {
                        saveChanges()
                    }) {
                        HStack {
                            Image(systemName: "checkmark").foregroundColor(.white)
                            Text("Simpan").foregroundColor(.white)
                        }
                        .padding()
                        .padding(.horizontal, 16)
                        .background(Color("JunggleGreen"))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.8), lineWidth: 1))
                    }
                    .padding(.trailing, 16)
                }
            }
            .padding(.top, 5)
            .navigationTitle("Details Grading")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Set nilai dari grading ke state
                selectedOrder = grading.noOrderSale ?? ""
                selectedSpecies = grading.species ?? ""
                selectedLocation = grading.location ?? ""
                selectedDate = grading.date ?? Date()
            }
        }
    }
    
    private func saveChanges() {
        viewModel.updateCreateGrading(id: grading.id!,  noOrderSale: selectedOrder, species: selectedSpecies, location: selectedLocation, date: selectedDate)
    }
}

struct DropDownView: View {
    @Binding var selectedItem: String
    let items: [String]
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation { isExpanded.toggle() }
            }) {
                HStack {
                    Text(selectedItem).foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.down").foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }
            
            if isExpanded {
                List(items, id: \ .self) { item in
                    Button(action: {
                        selectedItem = item
                        withAnimation { isExpanded = false }
                    }) {
                        Text(item)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 0)
                            .listRowInsets(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                    }
                }
                .frame(height: 150)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .transition(.opacity)
            }
        }
        .padding(.horizontal, 16)
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
