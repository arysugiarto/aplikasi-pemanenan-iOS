//
//  ContentView.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 18/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: CreateGradingViewModel
    @StateObject var lhpViewModel: LhpGradingViewModel
    
    var body: some View {
        NavigationStack{
            MainView(viewModel: viewModel, lhpViewModel: lhpViewModel)
        }
    
    }
}

