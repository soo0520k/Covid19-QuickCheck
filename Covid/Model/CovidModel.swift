
//  CovidModel.swift
//  Created by Hyunsoo kim on 10/8/20.
//
import Foundation

struct CovidModel {
    let caseToday: Int
    let caseTotal: Int
    let deathToday: Int
    let deathTotal: Int
    let dailyIncreases: [Int]
    
    var caseTodayString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:caseToday))!
    }
    var caseTotalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:caseTotal))!
    }
    var deathTodayString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:deathToday))!
    }
    var deathTotalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:deathTotal))!
    }

}
