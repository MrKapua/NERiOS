//
//  ViewControllerModDatosPersonales.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 02/02/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerModDatosPersonales: UIViewController, UITextFieldDelegate , UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var lbl_nombreNew: UITextField!
    @IBOutlet weak var lbl_apellidoNew: UITextField!
    
    var provincia = "Álava"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    let pickerProvincias = ["Álava","Albacete","Alicante","Almería","Asturias","Ávila","Badajoz","Baleares","Barcelona","Burgos","Cáceres","Cádiz","Cantabria","Castellón","Ceuta","Ciudad Real","Córdoba","Cuenca","Gerona","Granada","Guadalajara","Guipúzcoa","Huelva","Huesca","Jaén","La Coruña","La Rioja","Las Palmas","León","Lérida","Lugo","Madrid","Málaga","Melilla","Murcia","Navarra","Orense","Palencia","Pontevedra","Salamanca","Santa Cruz de Tenerife","Segovia","Sevilla","Soria","Tarragona","Teruel","Toledo","Valencia","Valladolid","Vizcaya","Zamora","Zaragoza"]
    
    
    
    @IBAction func btn_guardar(_ sender: UIButton)
    {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        guard let user = Auth.auth().currentUser?.uid else { return }
        if(!lbl_apellidoNew.text!.isEmpty)
        {
            ref.child("Usuario/\(user)/apellido").setValue(lbl_apellidoNew.text)
        }
        if (!lbl_nombreNew.text!.isEmpty)
        {
            ref.child("Usuario/\(user)/nombre").setValue(lbl_nombreNew.text)
        }
        ref.child("Usuario/\(user)/provincia").setValue(provincia)
        dismiss(animated: true, completion: nil)
        MostrarToast(mensaje: "La información se actualizará al volver a entrar en los datos personales")
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
    @IBAction func btn_salir(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
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
    
    

}
