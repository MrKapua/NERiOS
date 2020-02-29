//
//  ViewControllerLogin.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 07/12/2019.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase //importamos todo lo necesario para cargar datos desde Firebase


class ViewControllerLogin: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var img_logo: UIImageView!
    @IBOutlet weak var lbl_mail: UITextField!
    @IBOutlet weak var lbl_pass: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_registro: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //con esto vamos a ocultar el teclado cuando pulsemos sobre un espacio sin EditText
        let pulsar: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("ocutarTeclado")))
        view.addGestureRecognizer(pulsar)
        lbl_mail.delegate = self
        lbl_pass.delegate = self
        
        
        //botón de login
        btn_login.layer.cornerRadius = 20
        btn_login.layer.borderWidth = 1
        btn_login.layer.borderColor = UIColor.white.cgColor
        //botón de registro
        btn_registro.layer.cornerRadius = 20
        btn_registro.layer.borderWidth = 1
        btn_registro.layer.borderColor = UIColor.blue.cgColor
        
        
        //imagen de temporada, pensada para poder ser modificada con el tiempo
        /*if let url = NSURL(string: "https://www.tailorbrands.com/wp-content/uploads/2019/09/Juicy-logo-100-1-300x300.jpg")
        {
            if let data = NSData(contentsOf: url as URL)
            {
                img_logo.contentMode = UIView.ContentMode.scaleAspectFit
                img_logo.image = UIImage(data: data as Data)
            }
        }
 */
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //según iniciemos la aplicación se ocultará la barra superior, no se va a necesitar,por ahora
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //En esta función se define el comportamiento de la aplicación al pulsar sobre el botón de Login
    @IBAction func btn_Login(_ sender: Any)
    {
        //hacemos la autenticación comrpobando previamente que los campos están rellenos
        if(lbl_mail.text!.isEmpty || lbl_pass.text!.isEmpty)
        {
            //si no lo están mostraremos un toast para hacer ver al usuario final que debe rellenar todos los campos antes de comenzar
            self.MostrarToast(mensaje: "Debes rellenar los campos")
        }
        else
        {
            //si todos los campos están rellenos, se pasa a la siguiente linea de comprobración
            //
            Auth.auth().signIn(withEmail: lbl_mail.text!,password: lbl_pass.text!){[weak self] authResult, error in guard self != nil else{return}
                if error != nil
            {
                //Si tras comprobar Firebase devuelve un error mostrará el siguiente Toast y sale del bucle
                self?.MostrarToast(mensaje: "Login incorrecto")
                return
            }
            else
            {
                
            }
                //En caso de que la autenticación sea correcta pasamos directamente a la siguiente View
                //para ello registramos el storyboard y a la view que queremos abrir
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let destino = storyboard.instantiateViewController(withIdentifier: "mainS") as? ViewControllerMain else{
                    return
                    }
                //y lanzamos la View con una animación
                self?.navigationController?.pushViewController(destino, animated: true)
                
            }
        }
    }
    
    //Las siguiente lineas muestran el comportamiento del botón de registro
    @IBAction func btn_registro(_ sender: Any)
    {
        //se registra el Storyboard y se lanza la pantalla de crear usuario
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
    
    //función para poder mostrar mensaje en pantalla, como en android los Toast
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
