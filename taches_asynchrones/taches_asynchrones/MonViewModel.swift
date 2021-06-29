//
//  MonViewModel.swift
//  taches_asynchrones
//
//  Created by Maxime Britto on 25/06/2021.
//

import Foundation

class MonViewModel : ObservableObject {
    @Published var displayedValue = 0
    
    func loadData() async {
        ///charge les données quelque part puis modifie la variable `displayedValue`
        displayedValue = 5
    }
}
