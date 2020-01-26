//
//  ViewController.swift
//  UISamples
//
//  Created by rabbit on 2020/01/24.
//  Copyright © 2020 rabbit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 画面を自動回転させない
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }

    // 画面の向きをポートレイトに固定
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }

    @IBOutlet weak var label: UILabel!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        pushButton()
    }

    @IBAction func stepperAction(_ sender: UIStepper) {
        pushStepper(sender)
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        changeSwitch(sender)
    }

    @IBAction func segmentedCtrlAction(_ sender: UISegmentedControl) {
        changeSegmentedCtrl(sender)
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        changeSlider(sender)
    }

    @IBOutlet weak var textField: UITextField!

    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        changeDatePicker(sender)
    }

    @IBOutlet weak var picker: UIPickerView!
    let pickerData = [["1", "2", "3"], ["A", "B", "C", "D", "E"]]






    override func viewDidLoad() {
        super.viewDidLoad()

        // for Debug
        label.text = "Locale : " +  NSLocale.current.identifier    // ローカライゼーションをやらないと"en_JP"となる。プロジェクトのlocalizationsにjapaneseを追加すると"ja_JP"となる。

        // for TextField
        textField.delegate = self

        // for PickerView
        picker.dataSource = self
        picker.delegate = self

    }
    
}

// for Button
extension ViewController {
    func pushButton() {
        label.text = "Button : Pressed !"
    }
}

// for Stepper
extension ViewController {
    func pushStepper(_ sender: UIStepper) {
        label.text = "Stepper : \(Int(sender.value))"
    }
}

// for Switch
extension ViewController {
    func changeSwitch(_ sender: UISwitch) {
        label.isHidden = !sender.isOn
    }
}

// for SegmentedControl
extension ViewController {
    func changeSegmentedCtrl(_ sender: UISegmentedControl) {
        label.text = "SegmentCtrl : " +  (sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "nil")
    }
}

// for Slider
extension ViewController {
    func changeSlider(_ sender: UISlider) {
        label.text = "Slider :  \(sender.value)"
    }
}

// for TextField
extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let str = textField.text ?? "nil"
        label.text = (str != "" ? "TextField : " + str : "TextField : empty")
        textField.resignFirstResponder()
//        view.endEditing(true) // hide keyboard
        return true
    }
}

// for DatePicker
extension ViewController {
    func changeDatePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        label.text = "DatePicker : \(formatter.string(from: sender.date))"
    }
}

// for PickerView
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let row1 = picker.selectedRow(inComponent: 0)
        let row2 = picker.selectedRow(inComponent: 1)
        let item1 = self.pickerView(picker, titleForRow: row1, forComponent: 0)
        let item2 = self.pickerView(picker, titleForRow: row2, forComponent: 1)
        label.text = "PickerView : \(item1!)-\(item2!)"
    }
}
