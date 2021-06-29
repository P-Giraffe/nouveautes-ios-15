//
//  Todo.swift
//  todos
//
//  Created by Maxime Britto on 29/06/2021.
//

struct Todo {
    let id:Int
    let title:String
    var completed:Bool
}


extension Todo : Codable {}

extension Todo : Identifiable {}
