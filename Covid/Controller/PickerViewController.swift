//
//  PickerViewController.swift
//  Covid
//
//  Created by Hyunsoo kim on 11/16/20.


import UIKit

class PickerViewController: UIViewController,CovidManagerDelegate,UIPickerViewDataSource, UIPickerViewDelegate  {

    var covidManager = CovidManager()

    @IBOutlet weak var statesPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager.delegate = self
        statesPicker.dataSource = self
        statesPicker.delegate = self
    }

    
    @IBAction func SearchPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "Result", sender: self)
    }

    var confirmedToday: String = ""
    var confirmedTotal: String = ""
    var deathToday: String = ""
    var deathTotal: String = ""
    var confirmedRecords = [Int]()
    
    func didUpdateNumber(_ covidManager: CovidManager, covid: CovidModel) {
      DispatchQueue.main.async {
        self.confirmedToday = covid.caseTodayString
        self.confirmedTotal = covid.caseTotalString
        self.deathToday = covid.deathTodayString
        self.deathTotal = covid.deathTotalString
        self.confirmedRecords = covid.dailyIncreases
        }
    }
    func didFailWithError(error: Error){
            print(error)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Result" {
            let destinationVC = segue.destination as! CovidViewController
            destinationVC.cToday = confirmedToday
            destinationVC.cTotal = confirmedTotal
            destinationVC.dToday = deathToday
            destinationVC.dTotal = deathTotal
            destinationVC.caseRecords = confirmedRecords
        }
    }
    

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1  }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return covidManager.stateArray.count}
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return covidManager.stateArray[row] }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedState = covidManager.stateArray[row]
            covidManager.getStateData(for: selectedState)
        }
}
