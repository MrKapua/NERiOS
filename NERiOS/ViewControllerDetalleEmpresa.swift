//
//  ViewControllerDetalleEmpresa.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 31/01/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class ViewControllerDetalleEmpresa: UIViewController
{
    @IBOutlet weak var lbl_provincia: UILabel!
    @IBOutlet weak var lbl_dirección: UILabel!
    @IBOutlet weak var lbl_ciudad: UILabel!
    @IBOutlet weak var lbl_telefono: UILabel!
    @IBOutlet weak var MKempresa: MKMapView!
    @IBOutlet weak var lbl_nombreEmp: UILabel!
    var uid = ""
    @IBAction func btn_salas(_ sender: Any)
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destino = storyboard.instantiateViewController(withIdentifier: "listaSalasS") as? ViewControllerSalas else{return}
        destino.nombre_empresa=uid
        navigationController?.pushViewController(destino, animated: true)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //print (uid)
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        //let uid = Auth.auth().currentUser?.uid
        let mail = Auth.auth().currentUser?.email
        
        let parentRef = Database.database().reference().child("Empresa").child(uid)
        parentRef.observeSingleEvent(of: .value, with: {snapshot in
            let dic = snapshot.value as! [String:  Any]
            let nombre = dic["nombre"] as? String ?? ""
            let ciudad = dic["ciudad"] as? String ?? ""
            let provincia = dic["provincia"] as? String ?? ""
            let telefono = dic["telf"] as? String ?? ""
            //nombre, provincia, ciudad,telefono,lat,lon,mail,facebook,web
            self.lbl_nombreEmp.text=nombre
            self.lbl_ciudad.text=ciudad
            self.lbl_provincia.text=provincia
            self.lbl_telefono.text=telefono
            
            print (snapshot.key)
         })
    }
    

}
