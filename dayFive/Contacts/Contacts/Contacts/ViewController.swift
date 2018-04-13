//
//  ViewController.swift
//  Contacts
//
//  Created by Antonio Prado on 4/13/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    var nameTF: UITextField?
    var addressTF: UITextField?
    var phoneTF: UITextField?
    var emailTF: UITextField?
    var categoryTF: UITextField?
    var saveB: UIButton?
    var searchB: UIButton?
    
    var contact: Contact?
    var category: Category?
    var moc: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF = UITextField.custom(originY: 100, placeholder: "Name", delegate: self)
        view.addSubview(nameTF!)
        
        emailTF = UITextField.custom(originY: 140, placeholder: "Email", delegate: self)
        view.addSubview(emailTF!)
        
        addressTF = UITextField.custom(originY: 180, placeholder: "Address", delegate: self)
        view.addSubview(addressTF!)
        
        phoneTF = UITextField.custom(originY: 220, placeholder: "Phone", delegate: self)
        view.addSubview(phoneTF!)
        
        categoryTF = UITextField.custom(originY: 260, placeholder: "Category", delegate: self)
        view.addSubview(categoryTF!)
        
        saveB = UIButton.custom(rect: CGRect(x: 15, y: 300, width: view.frame.width/2-30, height: 30), title: "Save")
        saveB?.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        view.addSubview(saveB!)
        
        searchB = UIButton.custom(rect: CGRect(x: view.frame.width/2+15, y: 300, width: view.frame.width/2-30, height: 30), title: "Search")
        searchB?.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        view.addSubview(searchB!)
        
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    @objc func savePressed() {
                                                    //For Entity name should be the same as the entity previusly named
        contact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: moc!) as? Contact
        
        let nombre = (nameTF?.text ?? "No identificado") == "" ? "No identificado" : nameTF!.text!
        let dirección = addressTF?.text ?? "No identificado"
        let correo = emailTF?.text ?? "No identificado"
        let teléfono = phoneTF?.text ?? "No identificado"
        let categoría = categoryTF?.text ?? "No identificado"
        
        contact?.name = nombre
        contact?.phone = teléfono
        contact?.address = dirección
        contact?.email = correo
        
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: moc!) as? Category
        
        category?.type = categoría
        
        contact?.relationship = category
        
        do {
            try moc?.save()
            print("Registro guardado!")
            
            //as // upcasting cuando casteas hacía una clase heredada
            //as? // casting puede generar nulos
            //as! // casting puede generar nulos con peligro de crash
            
            for tf in view.subviews where tf is UITextField {
                (tf as! UITextField).text = ""
            }
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @objc func searchPressed() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        request.predicate = NSPredicate(format: "name = %@", nameTF!.text!)
        
        do {
            let getData = try moc?.fetch(request)
            
            if getData!.count > 0 {
                
                let firstContact = getData![0] as! Contact
                nameTF?.text = firstContact.name!
                addressTF?.text = firstContact.address!
                phoneTF?.text = firstContact.phone!
                emailTF?.text = firstContact.email!
                categoryTF?.text = firstContact.relationship!.type!
            } else {
                print("No data!")
            }
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if textField == nameTF {
            emailTF?.becomeFirstResponder()
        } else if textField == emailTF {
            addressTF?.becomeFirstResponder()
        } else if textField == addressTF {
            phoneTF?.becomeFirstResponder()
        } else if textField == phoneTF {
            categoryTF?.becomeFirstResponder()
        } else {
            categoryTF?.resignFirstResponder()
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

