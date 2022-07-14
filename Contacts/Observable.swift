//
//  Observable.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 13/07/2022.
//

import Foundation

class Observable<T> {
    typealias Observer = (T) -> Void
    
    private var observers: [Observer]
    var value: T? {
        didSet {
            guard let value = value else {
                return
            }
            notifyObservers(value: value)
        }
    }
    
    init(value: T) {
        self.value = value
        self.observers = []
    }
    
    private func notifyObservers(value: T) {
        observers.forEach { observer in
            observer(value)
        }
    }
    
    func bind(observer: @escaping Observer) {
        observers.append(observer)
        guard let value = value else {
            return
        }
        notifyObservers(value: value)
    }
}

