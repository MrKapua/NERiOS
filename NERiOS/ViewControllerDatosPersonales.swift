//
//  ViewControllerDatosPersonales.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 19/12/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerDatosPersonales: UIViewController {

    @IBOutlet weak var img_avatar: UIImageView!
    
    @IBOutlet weak var lbl_nombre: UILabel!
    @IBOutlet weak var lbl_apellido: UILabel!
    @IBOutlet weak var lbl_mail: UILabel!
    @IBOutlet weak var lbl_provincia: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let uid = Auth.auth().currentUser?.uid
        let mail = Auth.auth().currentUser?.email
        
        //MostrarToast(mensaje: uid!)
        let parentRef = Database.database().reference().child("Usuario").child(uid!)
        parentRef.observeSingleEvent(of: .value, with: {snapshot in
            let dic = snapshot.value as! [String:  Any]
            let nombre = dic["nombre"] as? String ?? ""
            let apellido = dic["apellido"]as? String ?? ""
            let provincia = dic["provincia"] as? String ?? ""
            //print (nombre, apellido)
            //self.MostrarToast(mensaje: nombre)
            self.lbl_nombre.text=nombre
            self.lbl_apellido.text=apellido
            self.lbl_mail.text=mail
            self.lbl_provincia.text=provincia
         })
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    @IBAction func btn_cerrarSesion(_ sender: Any)
    {
        try! Auth.auth().signOut()
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewDestino = storyboard.instantiateViewController(withIdentifier: "loginS") as? ViewControllerLogin else{return}
        navigationController?.pushViewController(viewDestino, animated: true)
        
    }
}
