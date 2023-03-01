//
//  ViewController.swift
//  BirthdayNoteTaker
//
//  Created by Vinícius Flores Ribeiro on 30/01/23.
//

import UIKit

class ViewController: UIViewController {

    var nameTextField = UITextField()
    var birthdayTextField = UITextField()
    @objc var saveButton = UIButton()
    let nameLabel = UILabel()
    let birthdayLabel = UILabel()
    @objc var deleteButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")

        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        let screenMidX = view.frame.midX

        nameTextField.placeholder = "name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.frame = CGRect(x: screenMidX - (screenWidth - 32)/2, y: screenHeight * 0.2, width: screenWidth - 32, height: 32)
        view.addSubview(nameTextField)

        birthdayTextField.placeholder = "bithday"
        birthdayTextField.borderStyle = .roundedRect
        birthdayTextField.frame = CGRect(x: screenMidX - (screenWidth - 32)/2, y: nameTextField.frame.maxY + 16, width: screenWidth - 32, height: 32)
        view.addSubview(birthdayTextField)

        saveButton.setTitle("Save", for: UIControl.State.normal)
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        saveButton.frame = CGRect(x: screenMidX - (screenWidth - 32)/2, y: birthdayTextField.frame.maxY + 32, width: screenWidth - 32, height: 32)
        saveButton.addTarget(self, action: #selector(ViewController.saveInformation), for: UIControl.Event.touchUpInside)
        view.addSubview(saveButton)

        nameLabel.text = "Name: \(storedName ?? "")"
        nameLabel.textAlignment = .left
        nameLabel.frame = CGRect(x: 16, y: saveButton.frame.maxY + 32, width: screenWidth - 32, height: 32)
        view.addSubview(nameLabel)

        birthdayLabel.text = "Birthday: \(storedBirthday ?? "")"
        birthdayLabel.textAlignment = .left
        birthdayLabel.frame = CGRect(x: 16, y: nameLabel.frame.maxY + 16, width: screenWidth - 32, height: 32)
        view.addSubview(birthdayLabel)

        deleteButton.setTitle("Delete", for: UIControl.State.normal)
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        deleteButton.frame = CGRect(x: screenMidX - (screenWidth - 32)/2, y: screenHeight - 64, width: screenWidth - 32, height: 32)
        deleteButton.addTarget(self, action: #selector(ViewController.deleteInformation), for: UIControl.Event.touchUpInside)
        view.addSubview(deleteButton)
    }

    @objc func saveInformation() {
        guard let newName = nameTextField.text else {return}
        guard let newBirthday = birthdayTextField.text else {return}

        UserDefaults.standard.setValue(newName, forKey: "name")
        UserDefaults.standard.setValue(newBirthday, forKey: "birthday")
        // Método antigo
        //UserDefaults.standard.synchronize()

        // Usando compactMap
//        nameLabel.text = ["Name:", nameTextField.text].compactMap{$0}.joined(separator: " ")
//        birthdayLabel.text = ["Birthday:", birthdayTextField.text].compactMap{$0}.joined(separator: " ")
        nameLabel.text = "Name: \(newName)"
        birthdayLabel.text = "Birthday: \(newBirthday)"

    }

    @objc func deleteInformation() {

        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")

        if storedName as? String != nil {
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name:"

        }

        if storedBirthday as? String != nil {
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text = "Birthday:"
        }
    }
}

