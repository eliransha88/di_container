//
//  AppDIContainer.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 14/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

class AppDIContainer {
    
    static let shared = AppDIContainer()
    
    let container: DIContainer = DIContainer.shared
    
    private init() {}
    
    func setup() {
        container.register(ShareWhatsappMessageServiceProtocol.self, instance: ShareWhatsappMessageService())
        container.register(NutritionalPlanServiceProtocol.self, instance: NutritionalPlanService())
    }
    
    func resolve<T>(_ protocolType: T.Type) -> T?  {
        container.resolve(protocolType)
    }
}
