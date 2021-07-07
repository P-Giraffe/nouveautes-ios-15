//
//  ShowManager.swift
//  nouveautes-ios15
//
//  Created by Maxime Britto on 16/06/2021.
//

import Foundation

class ShowManager : ObservableObject {
    private var _showList:[Show] = []
    private let _db = defaultDatabase
    var showList: [Show] { _showList }
    
    func loadShows() async -> [Show] {
        let loadedShows:[Show]
        do {
            loadedShows = try await _db.getAllShows()
            objectWillChange.send()
            _showList.append(contentsOf: loadedShows)
        } catch {
            loadedShows = []
        }
        return loadedShows
    }
    
    func addShow(name:String, year:Int) async {
        guard findShow(name: name, year: year) == nil else {
            return
        }
        let newShow = Show(name: name, year: year)
        objectWillChange.send()
        _showList.append(newShow)
        _ = try? await _db.addShow(show: newShow)
    }
    
    func findShow(name:String, year:Int) -> Show? {
        return _showList.first(where: {$0.name == name && $0.year == year})
    }
}
