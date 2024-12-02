//
//  DIContainer.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 14/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()
    private var container: [String: Any] = [:]
    
    init() {}
        
    func register<T>(_ protocolType: T.Type, instance: T) {
        let key = String(describing: protocolType)
        container[key] = instance
    }
    
    func registerSingleton<T>(_ protocolType: T.Type, factory: @escaping () -> T) {
        let key = String(describing: protocolType)
        container[key] = SingletonWrapper(factory: factory)
    }
    
    func resolve<T>(_ protocolType: T.Type) -> T? {
        let key = String(describing: protocolType)
        
        if let singletonWrapper = container[key] as? SingletonWrapper {
            return singletonWrapper.getInstance() as? T
        }
        
        return container[key] as? T
    }
}

private extension DIContainer {
    // Wrapper for singleton instances
    
    class SingletonWrapper {
        private let factory: () -> Any
        private var instance: Any?
        
        init(factory: @escaping () -> Any) {
            self.factory = factory
        }
        
        func getInstance() -> Any {
            if instance == nil {
                instance = factory()
            }
            
            // We unwrap here because we want it to crash because that means our DI doesn't work as expected
            return instance!
        }
    }
}
