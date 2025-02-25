//
//  Cardview.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 18/02/25.
//
import SwiftUI

struct CardView: View {
    var title: String
    var iconName: String

    var body: some View {
        HStack() {
            
            Image(systemName: iconName) // Menampilkan ikon di sebelah kiri
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40) // Ukuran ikon
                            .foregroundColor(.white)
                            .padding(.trailing, 10) // Jarak dengan teks
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 20)
            
          

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("JunggleGreen"))
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal, 16)
    }
}


