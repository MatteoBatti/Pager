//
//  Event.swift
//  Pager
//
//  Created by Matteo Battistini on 08/03/2018.
//

import Foundation

class Event<T> {
    var value: T {
        didSet {
            self.trigger()
        }
    }
    private var observer: [() -> Void]? = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func addObserver<T: AnyObject>(_ observer: T, handler: @escaping (T) -> Void ) {
        self.observer?.append({ [weak observer] in
            observer.map(handler)
        })
    }
    
    func trigger() {
        self.observer?.forEach {
            $0()
        }
    }
}
