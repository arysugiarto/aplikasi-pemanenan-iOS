//
//  DIContainer.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 19/02/25.
//


import CoreData
import Swinject

class DIContainer {
    static let shared = DIContainer()
    
    let container: Container
    
    private init() {
        container = Container()
        registerDependencies()
    }
    
    private func registerDependencies() {
        let context = PersistenceController.shared.container.viewContext
        
        container.register(CreateGradingRepository.self) { _ in
            CreateGradingRepositoryImpl(context: context)
        }
        
        container.register(CreateGradingUseCase.self) { r in
            CreateGradingUseCase(repository: r.resolve(CreateGradingRepository.self)!)
        }
        
        container.register(CreateGradingViewModel.self) { r in
            CreateGradingViewModel(createGradingUseCase: r.resolve(CreateGradingUseCase.self)!)
        }
        
        //lhp
        container.register(LhpGradingRepository.self) { _ in
            LhpGradingRepositoryImpl(context: context)
        }
        
        container.register(LhpGradingUseCase.self) { r in
            LhpGradingUseCase(repository: r.resolve(LhpGradingRepository.self)!)
        }
        
        container.register(LhpGradingViewModel.self) { r in
            LhpGradingViewModel(lhpGradingUseCase: r.resolve(LhpGradingUseCase.self)!)
        }
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        return container.resolve(type)
    }
}
