//
//  Database.swift
//  nouveautes-ios15
//
//  Created by Maxime Britto on 16/06/2021.
//

import Foundation

protocol Database {
    func addShow(show:Show) async throws -> Show
    func removeShow(show:Show) async throws -> Show
    func getAllShows() async throws -> [Show]
}

let defaultDatabase:Database = FakeDatabase(fakeData: [
    
    Show(name: "The Big Bang Theory", year: 2007),
    Show(name: "Silicon Valley", year: 2014),
    Show(name: "Mythic Quest", year: 2020),
    Show(name: "Friends", year: 1994),
    Show(name: "How I Met Your Mother", year: 2006)
])

class FakeDatabase : Database {
    private var _showList:[Show] = []
    init(fakeData:[Show]) {
        _showList.append(contentsOf: fakeData)
    }
    func addShow(show: Show) async throws -> Show {
        _showList.append(show)
        return show
    }
    
    func removeShow(show: Show) async throws -> Show {
        if let existingPosition = _showList.firstIndex(of: show) {
            _showList.remove(at: existingPosition)
        }
        return show
    }
    
    func getAllShows() async throws -> [Show] {
        return _showList
    }
    
    
}
