//
//  ViewController.swift
//  systemViewController
//
//  Created by Student on 29/08/25.
//

import UIKit
import SafariServices

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareButtontapped(_ sender: UIButton) {
        
        guard let image = imageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true,completion: nil)
        
    }
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.apple.com")
        {
            let safariVC = SFSafariViewController(url:url)
            present(safariVC, animated: true)
        }
    }
    
    @IBAction func camerabuttonTapped(_ sender: UIButton) {
       let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertcontroller = UIAlertController(title: "Choose Image SOURCE ", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertcontroller.addAction(cancelAction)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "camera", style: .default,handler: {action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true,completion: nil)})
            alertcontroller.addAction(cameraAction)
        }
        
        
  
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "photo Library", style: .default,handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true,completion: nil)})
            alertcontroller.addAction(photoLibraryAction)
            
        }
        
        
       

        alertcontroller.popoverPresentationController?.sourceView = sender
        present(alertcontroller,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let slectedImage = info[.originalImage] as? UIImage else{return}
        imageView.image = slectedImage
        dismiss(animated: true,completion: nil)
    }
}

