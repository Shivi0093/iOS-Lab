import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var forgetUnameField: UIButton!
    @IBOutlet weak var forgetPassField: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Called before the segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }

        if sender == forgetUnameField {
            segue.destination.navigationItem.title = "Forgot Username"
        } else if sender == forgetPassField {
            segue.destination.navigationItem.title = "Forgot Password"
        }else {
            if let username = userNameTextField.text, !username.isEmpty {
                segue.destination.navigationItem.title = username
            } else {
                segue.destination.navigationItem.title = "LoginPage"
            }
        }
    }

    
    @IBAction func forgetUname(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: sender)
    }

    
    @IBAction func forgetPas(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: sender)
    }
}
