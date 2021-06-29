//
//  main.swift
//  concurrence_acces_donnees
//
//  Created by Maxime Britto on 25/06/2021.
//

import Foundation

print("Hello, World!")

actor Counter  {
    var value = 0
    func increment() -> Int {
        value = value + 1
        return value
    }
    
    nonisolated func sayHello() {
        print("Hello!")
    }
}

let counter = Counter()

asyncDetached {
    print(await counter.increment())
    counter.sayHello()
}
asyncDetached {
    print(await counter.increment())
    counter.sayHello()
}
