
//  CovidManager.swift
//  Created by Hyunsoo kim on 10/8/20.

import Foundation

protocol CovidManagerDelegate {
    func didUpdateNumber(_ covidManager: CovidManager, covid: CovidModel)
    func didFailWithError(error:Error)
}

struct CovidManager {

var delegate: CovidManagerDelegate?
    
let baseURL = "https://api.covidtracking.com/v1/states/"
    
let stateArray =  ["AL","AK","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"]

    func getStateData(for selectedState: String) {
        let urlString = "\(baseURL)\(selectedState)/daily.json"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data,response,error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
            if let safeData = data {
                if let covid = self.parseJSON(safeData) {
                    self.delegate?.didUpdateNumber(self, covid: covid)
                }
            }
        }
        task.resume()
    }
}

    func parseJSON(_ covidData: Data) -> CovidModel? {
    let decoder = JSONDecoder()
    do {
        var caseList: [Int] = []
        let decodedData  = try decoder.decode([CovidData].self, from: covidData)
        let cToday = decodedData[0].positiveIncrease ?? 0
        let cTotal = decodedData[0].positive ?? 0
        let dToday = decodedData[0].deathIncrease ?? 0
        let dTotal = decodedData[0].death ?? 0
        for i in (0 ..< decodedData.count).reversed() {
            caseList.append(decodedData[i].positiveIncrease ?? 0)
        }
        let covid = CovidModel(caseToday: cToday, caseTotal: cTotal, deathToday: dToday, deathTotal: dTotal, dailyIncreases: caseList)        
        return covid

    } catch {
        delegate?.didFailWithError(error: error)
        print(error)
        return nil
        }
    }
}
