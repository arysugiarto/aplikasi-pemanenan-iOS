//
//  CreateGradingView.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 18/02/25.
//
import SwiftUI
import CoreData

struct LhpGradingView: View {
    
    @StateObject var viewModel: LhpGradingViewModel
    
    @State private var selectedOrder: String = "Pilih Pesanan"
    @State private var selectedSpecies: String = "Pilih Species"
    @State private var selectedLocation: String = "Pilih TPT Muat"
    @State private var selectedLaporan: String = "Pilih Laporan Pemanenan"
    @State private var selectedDate: Date = Date()
    
    @State private var noGrading = ""
    @State private var noOrderSale = ""
    @State private var species = ""
    @State private var showDeleteConfirmation = false
    @State private var selectedGradingToDelete: UUID?
    
    let orderItems = ["0010/SOBI/FPO-KLP/LHP/EKS-I/2023", "0010/SOBI/FPO-KLP/LHP/EKS-I/2024"]
    let speciesItems = ["Jati", "Mahoni", "Sengon"]
    let locationItems = ["Kulon Progo", "Sragen", "Jogja"]
    
    
    private func dates() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: "01-01-2025") ?? Date()
        let anotherDate = Date() // ✅ Sudah benar
    }

    
   
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
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
            
            Text("Laporan Pemanenan")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal, 16)
            DropDownView(selectedItem: $selectedLaporan, items: locationItems)
            
            
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
                
//                Button(action: {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "dd-MM-yyyy"
//                    let date = dateFormatter.date(from: "01-01-2025") ?? Date() // ✅ Converts string to Date
//
//                    viewModel.addCreateGrading(noGrading: "A010A23BE", noOrderSale: "0010/SOBI/FPO-KLP/LHP/EKS-I/2023", location: "Kulon Progo", date: dateFormatter.date(from: "01-01-2025") ?? Date(), species: "Jati")
//                }) {
//                    HStack {
//                        Image(systemName: "magnifyingglass").foregroundColor(.blue)
//                        Text("Cari").foregroundColor(.blue)
//                    }
//                    .padding()
//                    .frame(width: 120, height: 45)
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue.opacity(0.8), lineWidth: 1))
//                }
//                .padding(.trailing, 16)
//                
//                Spacer()
                
                Button(action: {
                    applyFilter()
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.white)
                        Text("Cari Produk").foregroundColor(.white)
                    }
                    .padding()
                    .padding(.horizontal, 16)
                    .background(Color("JunggleGreen"))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.8), lineWidth: 1))
                }
                .padding(.trailing, 16)

            }
            
            // List of grading items
            List {
                ForEach(viewModel.createGrading, id: \.id) { grading in
                    GradingCard(grading: grading, onLongPress: {
                        selectedGradingToDelete = grading.id
                        showDeleteConfirmation = true
                    })
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .padding(.top, 20)
        .navigationTitle("Buat Grading (dari LHP)")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom, 20)
        .onAppear {
            DispatchQueue.main.async {
                viewModel.loadCreateGrading()
            }
        }
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Hapus Grading"),
                message: Text("Apakah Anda yakin ingin menghapus grading ini?"),
                primaryButton: .destructive(Text("Hapus")) {
                    if let id = selectedGradingToDelete {
                        viewModel.deleteCreateGrading(id: id)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func applyFilter() {
        viewModel.fetchFilteredGradings(
            order: selectedOrder,
            species: selectedSpecies,
            location: selectedLocation,
            date: selectedDate
        )
    }

    
    
    struct GradingCard: View {
        let grading: GradingLhpEntity
        let onLongPress: () -> Void
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Nomor Grading: \(grading.noGrading ?? "-")")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Nomor Pesanan: \(grading.noOrderSale ?? "-")")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    Text("Species: \(grading.species ?? "-")")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
            
            }
            .padding()
            .background(Color("JunggleGreen").opacity(0.9))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.6), lineWidth: 1))
            .shadow(radius: 4)
            .padding(.horizontal, 16)
            .onLongPressGesture {
                onLongPress()
            }
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
                    List(items, id: \.self) { item in
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
    
    
    
}
