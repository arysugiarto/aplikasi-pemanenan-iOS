//
//  TebangView.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 04/03/25.
//

import SwiftUI


struct TebangView: View {
    let tree: Tree
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tebang Pohon")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Nomor Pohon: \(tree.treeNumber)")
            Text("Jenis: \(tree.speciesName)")
            Text("Diameter: \(tree.diameter, specifier: "%.2f") cm")
            Text("Area: \(tree.areaName)")
            
            Button(action: {
                print("Pohon \(tree.treeNumber) ditebang")
            }) {
                Text("Konfirmasi Tebang")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Tebang Pohon")
        .navigationBarTitleDisplayMode(.inline)
    }
}
