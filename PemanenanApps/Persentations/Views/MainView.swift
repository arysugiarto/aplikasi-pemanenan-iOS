//
//  MainView.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 18/02/25.
//
import SwiftUI

struct MainView : View{
    @StateObject var viewModel: CreateGradingViewModel
    @StateObject var lhpViewModel: LhpGradingViewModel
    var body: some View{
        VStack(spacing: 20) {
            
            NavigationLink(destination: MainView(viewModel: viewModel, lhpViewModel:lhpViewModel)){
                CardView(title: "Pemanenan", iconName: "tree.fill")
            }
            
            NavigationLink(destination: GradingView(viewModel: viewModel, lhpViewModel:lhpViewModel)){
                CardView(title: "Grading Bersama", iconName: "scalemass.fill")
            }
            Spacer()
           
        }
        .padding(.top, 20)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}
