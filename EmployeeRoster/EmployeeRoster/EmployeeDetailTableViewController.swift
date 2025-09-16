
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeTableViewControllerDelegate {
    var employeeType: EmployeeType?
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.text = employeeType.description
        employeeTypeLabel.textColor = .black
        updateSaveButtonState()
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    var isEditingBirthday:Bool = false{
        didSet{
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let datePickerIndexPath = IndexPath(row: 2, section: 0)
        if indexPath == datePickerIndexPath && isEditingBirthday == false {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    
    @IBAction func dobDatePickerAction(_ sender: Any) {
        dobLabel.text = dobDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let birthdayCell = IndexPath(row: 1, section: 0)
        if indexPath==birthdayCell{
            isEditingBirthday.toggle()
        }
        tableView.deselectRow(at: indexPath , animated: true)
        dobLabel.textColor = .label
        dobLabel.text = dobDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    private func updateSaveButtonState() {
        let nameText =  nameTextField.text ?? ""
        let isEmployeeTypeSelected = employeeType != nil
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = !nameText.isEmpty && isEmployeeTypeSelected
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        guard let employeeType = self.employeeType else {return}
        let employee = Employee(name: name, dateOfBirth: dobDatePicker.date , employeeType: employeeType)
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }

    @IBSegueAction func showEmployeeTypes(_ coder: NSCoder) -> EmployeeTypeTableViewController? {
       let controller = EmployeeTypeTableViewController(coder: coder)
        controller?.delegate = self
        controller?.employeeType = self.employeeType
        return controller
    }
}
