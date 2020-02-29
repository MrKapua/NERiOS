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
        //según cargamos la view vamos a comenzar a rellenar todos los datos de la empresa, para ello necesitamos el uid que hemos recuperado del view anterior
        super.viewDidLoad()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let mail = Auth.auth().currentUser?.email
        
        let parentRef = Database.database().reference().child("Empresa").child(uid)
        parentRef.observeSingleEvent(of: .value, with: {snapshot in
            let dic = snapshot.value as! [String:  Any]
            let nombre = dic["nombre"] as? String ?? ""
            let ciudad = dic["ciudad"] as? String ?? ""
            let provincia = dic["provincia"] as? String ?? ""
            let telefono = dic["telf"] as? String ?? ""
            let latitud = dic["latitud"] as? Double ?? 0.0
            let longitud = dic["longitud"] as? Double ?? 0.0
            
            self.lbl_nombreEmp.text=nombre
            self.lbl_ciudad.text=ciudad
            self.lbl_provincia.text=provincia
            self.lbl_telefono.text=telefono
            //con los siguientes datos cargamos el mapa, con sus coordenadas y la distancia de visión del mapa y el marcador deposición del destino
            let x = CLLocation(latitude: latitud, longitude: longitud)
            let region = MKCoordinateRegion(center: x.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            self.MKempresa.setRegion(region, animated: true)
            let anotacion = MKPointAnnotation()
            let posicionAnotacion = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
            anotacion.title = nombre
            anotacion.coordinate = posicionAnotacion
            self.MKempresa.addAnnotation(anotacion)
         })
    }
}
