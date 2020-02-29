//
//  ViewControllerSalaDetalle.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 16/02/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase


class ViewControllerSalaDetalle: UIViewController
{
    @IBOutlet weak var imgSala: UIImageView!
    @IBOutlet weak var lbl_nombre_sala: UILabel!
    @IBOutlet weak var lbl_tematica_sala: UILabel!
    @IBOutlet weak var lbl_tiempo_sala: UILabel!
    @IBOutlet weak var lbl_tipo_sala: UILabel!
    @IBOutlet weak var lbl_precio: UILabel!
    @IBOutlet weak var lbl_descripcion_sala: UILabel!
    var referencia=""
    var url = ""
    
    @IBAction func abrirWEB(_ sender: Any)
    {
        if let url2 = URL(string: url) {
            UIApplication.shared.open(url2, options: [:])
        }
    }

    @IBAction func btn_reserva(_ sender: Any) {
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print (referencia)
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let mail = Auth.auth().currentUser?.email
        
        let parentRef = Database.database().reference().child("Salas").child(referencia)
        parentRef.observeSingleEvent(of: .value, with: {snapshot in
            let dicSala = snapshot.value as! [String:  Any]
            let nombre = dicSala["nombre"] as? String ?? ""
            let precio = dicSala["precio"] as? String ?? ""
            //let jugadores = dicSala["provincia"] as? String ?? ""
            //let reserva = dicSala["reserva"] as? String ?? ""
            let tiempo = dicSala["tiempo"] as? String ?? ""
            let tipo = dicSala["tipo"] as? String ?? ""
            let descripcion  = dicSala["descripcion"] as? String ?? ""
            let tematica  = dicSala["tematica"] as? String ?? ""
            let webUrl = dicSala["reserva"] as? String ?? ""
            //nombre, provincia, ciudad,telefono,lat,lon,mail,facebook,web
            self.lbl_nombre_sala.text = nombre
            self.lbl_precio.text = precio
            self.lbl_tiempo_sala.text = tiempo
            self.lbl_tipo_sala.text = tipo
            self.lbl_tematica_sala.text = tematica
            self.lbl_descripcion_sala.text = descripcion
            self.url=webUrl
         })

    }

}
