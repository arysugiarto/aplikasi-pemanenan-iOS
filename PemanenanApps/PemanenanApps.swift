//
//  PemanenanAppsApp.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 18/02/25.
//

import SwiftUI

@main
struct PemanenanAppsApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            let viewModel = DIContainer.shared.resolve(CreateGradingViewModel.self)!
            let lhpViewModel = DIContainer.shared.resolve(LhpGradingViewModel.self)!
            ContentView(viewModel: viewModel, lhpViewModel: lhpViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext) // ✅ Tambahkan ini
        }
    }
}
