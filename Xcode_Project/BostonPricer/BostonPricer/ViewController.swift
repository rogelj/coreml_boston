//
//  ViewController.swift
//  BostonPricer
//
//  Created by J Rogel on 07/01/2018.
//  Copyright © 2018 J Rogel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let crimeData = Array(stride(from: 0.1, through: 0.3, by: 0.01))
    let roomData = Array(4...9)

    @IBOutlet weak var inputPicker: UIPickerView!

    @IBOutlet weak var predictButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Picker data source and delegate
        inputPicker.dataSource = self
        inputPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getPrediction() {
        let selectedCrimeRow = inputPicker.selectedRow(inComponent: inputPredictor.crime.rawValue)
        let crime = crimeData[selectedCrimeRow]

        let selectedRoomRow = inputPicker.selectedRow(inComponent: inputPredictor.rooms.rawValue)
        let rooms = roomData[selectedRoomRow]

        let message = "The picked values are Crime: \(crime) and Rooms: \(rooms)"

        let alert = UIAlertController(title: "Values Picked",
                                      message: message,
                                      preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: nil)

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}

extension ViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        guard let inputVals = inputPredictor(rawValue: component) else {
            fatalError("No predictor for component")
        }

        switch inputVals {
        case .crime:
            return crimeData.count
        case .rooms:
            return roomData.count
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        guard let inputVals = inputPredictor(rawValue: component) else {
            fatalError("No predictor for component")
        }

        switch inputVals {
        case .crime:
            return String(crimeData[row])
        case .rooms:
            return String(roomData[row])
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        guard let inputVals = inputPredictor(rawValue: component) else {
            fatalError("No predictor for component")
        }

        switch inputVals {
        case .crime:
            print(String(crimeData[row]))
        case .rooms:
            print(String(roomData[row]))
        }


    }
}

enum inputPredictor: Int {
    case crime = 0
    case rooms
}
