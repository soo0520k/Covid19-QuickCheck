//
//  ViewController.swift
//  Created by Hyunsoo kim on 10/6/20.
//

import Charts
import UIKit

class CovidViewController: UIViewController {

    var lineChart = LineChartView()
    
    var cToday: String?
    var cTotal: String?
    var dToday: String?
    var dTotal: String?
    var caseRecords = [Int]()
    var entries = 0

    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var confirmedCaseTotal: UILabel!
    @IBOutlet weak var deathTotal: UILabel!
    @IBOutlet weak var confirmedCaseToday: UILabel!
    @IBOutlet weak var deathToday: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmedCaseToday.text = String(cToday ?? "")
        confirmedCaseTotal.text = String(cTotal ?? "")
        deathToday.text = String(dToday ?? "")
        deathTotal.text = String(dTotal ?? "")
        lineChart.delegate = self

    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}



// Mark: - CovidManagerDelegate, ChartViewDelegate

extension CovidViewController: ChartViewDelegate {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        lineChart.frame = CGRect(x:0, y:0,
                                 
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)

        var entries = [ChartDataEntry]()
        for x in 0 ..< caseRecords.count {
            entries.append(ChartDataEntry(x: Double(x),
                                          y: Double(caseRecords[x])))
            lineChart.tintColor = UIColor.red }

        let set = LineChartDataSet(entries: entries, label:"Historical records of confirmed cases (From 03/06/2020 to Present)")
        set.colors = [UIColor.red];
        set.drawCirclesEnabled = false;
        set.drawValuesEnabled = false;

        lineChartView.legend.textColor = UIColor.black
        let data = LineChartData(dataSet: set)
        lineChartView.data = data
    }
}


