import UIKit

async {
    if let csvURL = URL(string: "https://static.data.gouv.fr/resources/fichier-consolide-des-bornes-de-recharge-pour-vehicules-electriques/20210604-184648/irve-2.0.0.csv?test=3") {

        for try await line in csvURL.lines {
            let values = line.split(separator: ",")
            let owner = values[6]
            if owner.count <= 11 {
                break
            }
            let address = values[11]
            let longitude = values[13]
            let latitude = values[14]
            print(" - \(owner) : \(address) : \(longitude) , \(latitude)")
        }
    }
    
}
