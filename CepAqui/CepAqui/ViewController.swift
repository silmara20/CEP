//
//  ViewController.swift
//  CepAqui
//
//  Created by Virtual Machine on 20/06/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, CepServiceProtocol {
    

    @IBOutlet weak var cepField: UITextField!
    @IBOutlet weak var ruaField: UITextField!
    @IBOutlet weak var bairroField: UITextField!
    @IBOutlet weak var cidadeField: UITextField!
    @IBOutlet weak var estadoField: UITextField!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cepField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
               
        let service = CepService()
        
               service.delegate = self
               cepField.delegate = self
    }

    // Cep service
        func cepSuccess(endereco: Endereco){
    
        DispatchQueue.main.async {
            self.ruaField.text = endereco.logradouro
            self.bairroField.text = endereco.bairro
            self.cidadeField.text = endereco.localidade
            self.estadoField.text = endereco.uf
        }
    }
        func cepError(messege: String) {
    
        DispatchQueue.main.async {
            print("Cep não encontrado")
        }
    }

    // UITextField
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
      var service = CepService()
        service.callCep(cep: textField.text ?? "", delegate: self)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           guard let textFieldText = textField.text,
               let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                   return false
           }
           let substringToReplace = textFieldText[rangeOfTextToReplace]
           let count = textFieldText.count - substringToReplace.count + string.count
        if count == 8 {
            var service = CepService()
            service.callCep(cep: textField.text! + string , delegate: self)
            
        }
           return count <= 8
       }
   

}
