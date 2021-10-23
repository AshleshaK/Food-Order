//
//  SecondViewController.swift
//  TableViewControllerTask
//
//  Created by Mac on 16/09/21.
//

import UIKit

//MARK: Protocol for Data Passing
protocol SecondViewControllerProtocol : class {
    func passDataToVC1 (text: String?)
}


//MARK: Class to store the Data

class Meal
{
    var mealType : String
    var menu : [String]
    var bill : [String]
    
    
    init(mealType:String, menu:[String], bill:[String]) {
        self.menu = menu
        self.mealType = mealType
        self.bill = bill
    }
    
}

class SecondViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var menuTextField: UITextField!
    @IBOutlet weak var mealTypeTextField: UITextField!
    @IBOutlet weak var yourOrder: UILabel!
    
    weak var delegateVC2 : SecondViewControllerProtocol?
    
    //Array
    var order = [Meal]()
    
    var mealPickerView = UIPickerView()
    var menuPickerView = UIPickerView()
    var pricePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        order.append(Meal(mealType: "Snacks", menu: ["Poha", "Upma","Idli Sambar","Vada Sambar","Masala Dosa","Misal"], bill: ["Rs.25","Rs.25","Rs.50","Rs.50","Rs.80","Rs.90"] ))
                     
        order.append(Meal(mealType: "Main Course", menu: ["Veg Maratha","Paneer Masala","Chicken Biryani","Chicken Masala","Butter Chicken","Saoji Chicken"], bill: ["Rs.200","Rs.250","Rs.300","Rs.250","Rs.300","Rs.350"]))
        
        order.append(Meal(mealType: "Beverages", menu: ["Blue Lagoon","Virgin Mojito","Coke","Caffe Espresso","Caffe Americano","Caffe Latte"], bill: ["Rs.150","Rs.150","Rs.100","Rs.200","Rs.250","Rs.150"]))
        
        //Mark: Picker View
        
        mealTypeTextField.inputView = mealPickerView
        menuTextField.inputView = menuPickerView
        billTextField.inputView = pricePickerView
        
        
        
        mealPickerView.delegate = self
        mealPickerView.dataSource = self
        menuPickerView.delegate = self
        menuPickerView.dataSource = self
        pricePickerView.delegate = self
        pricePickerView.dataSource = self
        
    }
}

//MARK: Methods of Picker View

extension SecondViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return order.count
        }
        if component == 1 {
            let selectedType = pickerView.selectedRow(inComponent: 0)
            return order[selectedType].menu.count
        }
        if component == 2 {
            let selectedItem = pickerView.numberOfRows(inComponent: 0)
            return order[selectedItem-1].bill.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return order[row].mealType
        }
        if component == 1 {
            let selectedType = pickerView.selectedRow(inComponent: 0)
            return order[selectedType].menu[row]
        }
        if component == 2 {
            let selectedItem = pickerView.selectedRow(inComponent: 0)
            return order[selectedItem].bill[row]
        }
        return ""
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        pickerView.reloadComponent(1)
        
        let selectedType = pickerView.selectedRow(inComponent: 0)
        let selectedMenu = pickerView.selectedRow(inComponent: 1)
        let totalBill = pickerView.selectedRow(inComponent: 2)
        let type = order[selectedType].mealType
        let menu = order[selectedType].menu[selectedMenu]
        let bill = order[selectedType].bill[totalBill]
        
        mealTypeTextField.text = type
        menuTextField.text = menu
        billTextField.text = bill
        yourOrder.text = "\(type):\(menu)-\(bill)"
        
    }
    
    //Mark: Button Action

    @IBAction func confirmYourOrder() {
        let yourMeal = yourOrder.text
        delegateVC2?.passDataToVC1(text: yourMeal )
        navigationController?.popViewController(animated: true)
   }
}

 
