//
//  AddRegistrationTableViewController.swift
//  HotelCodable
//
//  Created by Student on 27/08/25.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController,SelectRoomTypeTableViewControllerDelegate{
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType=roomType
        updateRoomType()
    }
    var registration: Registration?{
        guard let roomType = roomType else{
            return nil
        }
        let firstname=FirstNametextField.text ?? ""
        let lastname=LastNameTextField.text ?? ""
        let email=EmailTexTField.text ?? ""
        let checkinDate=CheckIndatePicker.date
        let checkoutDate=checkOutDatePicker.date
        let adultsGuest=Int(adultStepper.value)
        let childguest=Int(childStepper.value)
        let wifi = wifiSwitch.isOn
      
        
        return Registration(firstName: firstname, lastName: lastname, emailAddress: email, checkInDate: checkinDate, checkOutDate: checkoutDate, numberOfAdults: adultsGuest, numberOfChildren: childguest, wifi: wifi, roomType: roomType)
    }
    var roomType: RoomType?
    
    @IBOutlet weak var roomTypeDetail: UILabel!
    @IBOutlet weak var EmailTexTField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var FirstNametextField: UITextField!
    
    @IBOutlet weak var checkoutDateLabel: UILabel!
    @IBOutlet weak var CheckIndatePicker: UIDatePicker!
    @IBOutlet weak var checkInDatelabel: UILabel!

    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var adultsLabel: UILabel!
    
    @IBOutlet weak var childLabel: UILabel!
    
    @IBOutlet weak var childStepper: UIStepper!
    @IBOutlet weak var adultStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    
    
    let checkinDatePickerCellIndexPath=IndexPath(row: 1,section: 1)
    let checkoutDatePickerCellindexPath=IndexPath(row: 3,section: 1)
    let checkindatelabelindexPath=IndexPath(row: 0, section: 1)
    let checkoutlabelIndexPath=IndexPath(row: 2, section: 1)
    
    var isCheckInDatePickerVisible: Bool = false{
        didSet{
            CheckIndatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var isCheckOutDatePickerVisible: Bool = false{
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday=Calendar.current.startOfDay(for: Date())
        CheckIndatePicker.minimumDate=midnightToday
        checkOutDatePicker.date=midnightToday
        
        updateDateView()
        updateNumberOfGuests()
        updateRoomType()
  
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkinDatePickerCellIndexPath where isCheckInDatePickerVisible == false: return 0
        case checkoutDatePickerCellindexPath where isCheckOutDatePickerVisible  == false: return 0
        default: return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkinDatePickerCellIndexPath: return 190
        case checkoutDatePickerCellindexPath: return 190
        default:
            return UITableView.automaticDimension
            
        }
    }
//    @IBAction func DoneButtonTapped(_ sender: Any) {
//        let firstname=FirstNametextField.text ?? ""
//        let lastname=LastNameTextField.text ?? ""
//        let email=EmailTexTField.text ?? ""
//        let checkinDate=CheckIndatePicker.date
//        let checkoutDate=checkOutDatePicker.date
//        let adultsGuest=Int(adultStepper.value)
//        let childguest=Int(childStepper.value)
//        let wifi = wifiSwitch.isOn
//        let roomChoice = roomType?.name ?? "Not Set"
//        
//        
//        
//        print("Done Button Tapped")
//        print("first name: \(firstname)")
//        print("last name: \(lastname)")
//        print("email: \(email)")
//        print("Check-In Date: \(checkinDate)")
//        print("Check-Out Date: \(checkoutDate)")
//        print("Adults Guests: \(adultsGuest)")
//        print("Child Guests: \(childguest)")
//        print("Wi-Fi: \(wifi)")
//        print("Room Type: \(roomChoice)")
//        
//    }
    
    
    @IBAction func datePickerValue(_ sender: UIDatePicker) {
        updateDateView()
    }
    func updateDateView(){
        checkOutDatePicker.minimumDate=Calendar.current.date(byAdding: .day,value: 1 ,to: CheckIndatePicker.date)
        
        checkInDatelabel.text=CheckIndatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkoutDateLabel.text=checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == checkindatelabelindexPath && isCheckOutDatePickerVisible == false{
            isCheckInDatePickerVisible.toggle()
        }
        else if indexPath == checkoutlabelIndexPath && isCheckInDatePickerVisible == false{
            isCheckOutDatePickerVisible.toggle()
        }
        else if indexPath == checkindatelabelindexPath || indexPath == checkoutlabelIndexPath{
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        }
        else{
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    func updateNumberOfGuests(){
        adultsLabel.text="\(Int(adultStepper.value))"
        childLabel.text="\(Int(childStepper.value))"
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchtapped(_ sender: Any) {

    }
    func updateRoomType(){
        if roomType == roomType{
            roomTypeDetail.text=roomType?.name
        }
        else{
            roomTypeDetail.text="Not Selected"
        }
    }
   
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
       let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate=self
        selectRoomTypeController?.roomType=roomType
        
        return selectRoomTypeController
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
}
