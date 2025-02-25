//
//  MainView.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 18/02/25.
//
import SwiftUI

struct GradingView : View{
    
    @StateObject var viewModel: CreateGradingViewModel
    @StateObject var lhpViewModel: LhpGradingViewModel
    
    var body: some View{
        VStack(spacing: 20) {
           
            NavigationLink(destination: CreateGradingView(viewModel: viewModel)){
                CardView(title: "Buat Grading", iconName: "scalemass.fill")
            }
            
            NavigationLink(destination: LhpGradingView(viewModel: lhpViewModel)){
                CardView(title: "Buat Grading (Dari LHP)", iconName: "scalemass.fill")
            }
            
            NavigationLink(destination: MainView(viewModel: viewModel, lhpViewModel: lhpViewModel)){
                CardView(title: "Daftar Grading", iconName: "list.bullet")
            }
            Spacer()
           
        }
        .padding(.top, 20)
        .navigationTitle("Grading Bersama")
        .navigationBarTitleDisplayMode(.inline)
    }
}
