//
//  ViewControllerLogin.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 07/12/2019.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase


class ViewControllerLogin: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lbl_mail: UITextField!
    @IBOutlet weak var lbl_pass: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_registro: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //con esto vamos a ocultar el teclado cuando pulsemos sobre un espacio sin EditText
        let pulsar: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "ocutarTeclado")
        view.addGestureRecognizer(pulsar)
        lbl_mail.delegate = self
        lbl_pass.delegate = self
        
        
        //boton de login
        btn_login.layer.cornerRadius = 20
        btn_login.layer.borderWidth = 1
        btn_login.layer.borderColor = UIColor.white.cgColor
        
        btn_registro.layer.cornerRadius = 20
        btn_registro.layer.borderWidth = 1
        btn_registro.layer.borderColor = UIColor.blue.cgColor
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //según iniciemos la aplicación se ocultará el menú superior, no se va a necesitar,por ahora
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func btn_Login(_ sender: Any)
    {
        //hacemos la autenticación comrpobando previamente que los campos están rellenos
        if(lbl_mail.text!.isEmpty || lbl_pass.text!.isEmpty)
        {
            self.MostrarToast(mensaje: "Debes rellenar los campos")
        }
        else
        {
            Auth.auth().signIn(withEmail: lbl_mail.text!,password: lbl_pass.text!){[weak self] authResult, error in guard let strongSelf = self else{return}
            if let error = error
            {
                self?.MostrarToast(mensaje: "Login incorrecto")
                return
            }
            else
            {
                
            }
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let destino = storyboard.instantiateViewController(withIdentifier: "mainS") as? ViewControllerMain else{
                    return
                    }
                self?.navigationController?.pushViewController(destino, animated: true)
                
            }
        }
    }
    
    @IBAction func btn_registro(_ sender: Any)
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewDestino = storyboard.instantiateViewController(withIdentifier: "registroS") as? ViewControllerRegistro else{return}
        navigationController?.pushViewController(viewDestino, animated: true)
    }
    
    @objc func ocutarTeclado()
    {
        view.endEditing(true)
    }
    
    @objc func keyboardWillCahnge(notification: Notification)
    {
        
    }
    
    func MostrarToast(mensaje : String)
    {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 140,
                                               y: self.view.frame.size.height-100,
                                               width: 280,
                                               height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.adjustsFontSizeToFitWidth=true
        toastLabel.text = mensaje
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: {toastLabel.alpha = 0.0},
                       completion: {(isCompleted) in toastLabel.removeFromSuperview()})
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        lbl_mail.resignFirstResponder()
        lbl_pass.resignFirstResponder()
        return true
    }
}
