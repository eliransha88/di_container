//
//  DIPropertyWrapper.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 14/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

/// Immediate injection property wrapper. Note that embedded container and name properties will be used if set prior to service instantiation.
/// Wrapped dependent service is resolved immediately using container upon struct initialization.
@propertyWrapper public struct Inject<ServiceType> {
    private var service: ServiceType
    
    public init() {
        // We unwrap here because we want it to crash because that means someone didn't register the instance in the DI
        self.service = AppDIContainer.shared.resolve(ServiceType.self)!
    }
    
    public var wrappedValue: ServiceType {
        get {
            return service
        }
        
        mutating set {
            service = newValue
        }
    }
    
    public var projectedValue: Inject<ServiceType> {
        get {
            return self
        }
        
        mutating set {
            self = newValue
        }
    }
}
