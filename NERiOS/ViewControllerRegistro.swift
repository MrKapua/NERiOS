//
//  ViewControllerRegistro.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 18/12/2019.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerRegistro: UIViewController, UITextFieldDelegate , UIPickerViewDataSource, UIPickerViewDelegate
{
    //registramos los campos que podemos llegar a utilizar
    @IBOutlet weak var lbl_nombre: UITextField!
    @IBOutlet weak var lbl_apellido: UITextField!
    @IBOutlet weak var lbl_mail: UITextField!
    @IBOutlet weak var lbl_pass: UITextField!
    var provincia = ""
    let pickerProvincias = ["Álava","Albacete","Alicante","Almería","Asturias","Ávila","Badajoz","Baleares","Barcelona","Burgos","Cáceres","Cádiz","Cantabria","Castellón","Ceuta","Ciudad Real","Córdoba","Cuenca","Gerona","Granada","Guadalajara","Guipúzcoa","Huelva","Huesca","Jaén","La Coruña","La Rioja","Las Palmas","León","Lérida","Lugo","Madrid","Málaga","Melilla","Murcia","Navarra","Orense","Palencia","Pontevedra","Salamanca","Santa Cruz de Tenerife","Segovia","Sevilla","Soria","Tarragona","Teruel","Toledo","Valencia","Valladolid","Vizcaya","Zamora","Zaragoza"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("ocultarTeclado")))
        view.addGestureRecognizer(tap)
        //por si hay una sesión abierta, la tratamos de cerrar
        try! Auth.auth().signOut()
    }
    //Volvemos a la pantalla principal, cancelando todo lo que hemos hecho
    @IBAction func btn_cancelar(_ sender: Any)
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destino = storyboard.instantiateViewController(withIdentifier: "loginS") as? ViewControllerLogin else{
            return
            }
        navigationController?.pushViewController(destino, animated: true)
    }
    
    @IBAction func btn_registrar(_ sender: Any)
    {
        //vamos a necesitar todos los campos rellenos, si o si
        if(lbl_nombre!.text!.isEmpty || lbl_apellido!.text!.isEmpty || lbl_mail!.text!.isEmpty || lbl_pass!.text!.isEmpty)
        {
            MostrarToast(mensaje: "Faltan datosFaltan datosFaltan datosFaltan datos")
        }
        else
        {
            print (provincia)
            //con el siguiente conjunto de lineas vamos a crear el usuario para Authenticator
             Auth.auth().createUser(withEmail: lbl_mail.text!, password: lbl_pass.text!){ authResult, error in}
             var ref: DatabaseReference!
             ref = Database.database().reference()
             guard let user = Auth.auth().currentUser?.uid else { return }
             
            //Vamos a usar el resto de los datos para registrarlos dentro de la base de datos
             ref.child("Usuario/\(user)/nombre").setValue(lbl_nombre.text)
             ref.child("Usuario/\(user)/apellido").setValue(lbl_apellido.text)
             ref.child("Usuario/\(user)/provincia").setValue(provincia)
             ref.child("Usuario/\(user)/uid").setValue(user)
            
        }
        
        
    }
    
    @objc func ocultarTeclado() {
        //guardamos el teclado, que no nos hace falta siempre
        view.endEditing(true)
    }
    //función en pruebas
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case lbl_nombre:
            lbl_apellido.becomeFirstResponder()
        case lbl_apellido:
            lbl_mail.becomeFirstResponder()
        case lbl_mail:
            lbl_pass.becomeFirstResponder()
        case lbl_pass:
            ocultarTeclado()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    func MostrarToast(mensaje : String)
    {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 140, y: self.view.frame.size.height-100, width: 280, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.adjustsFontSizeToFitWidth=true
        toastLabel.text = mensaje
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()})
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerProvincias[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerProvincias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        provincia = pickerProvincias[row]
        print (provincia)
    }
    
    func volverLogin()
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewDestino = storyboard.instantiateViewController(withIdentifier: "loginS") as? ViewControllerLogin else{return}
        navigationController?.pushViewController(viewDestino, animated: true)
    }
}
