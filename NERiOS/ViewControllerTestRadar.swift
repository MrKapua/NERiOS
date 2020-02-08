//
//  ViewControllerTestRadar.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 29/01/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewControllerTestRadar: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var distancia: UITextField!
    
    @IBOutlet weak var MkMapa: MKMapView!
    
    
    @IBOutlet weak var btnLocalizacion: UIButton!
    
    let localizacion = CLLocationManager()
    var punto1 = CLLocation(latitude: 0, longitude: 0)
    var punto2 = CLLocation(latitude: 0, longitude: 0)
    var distanciaTotal = 0.0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        let permiso = CLLocationManager.authorizationStatus()
        
        if permiso == .notDetermined {
            localizacion.requestWhenInUseAuthorization()
        }
        else if permiso == .denied
        {
             alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo.")
            btnLocalizacion.isEnabled = false
            btnLocalizacion.alpha = 0.5
            
            
        }
        else if permiso == .restricted
        {
             alertLocation(tit: "Error de localización", men: "Actualmente tiene restringida la localización del dispositivo.")
            btnLocalizacion.isEnabled = false
            btnLocalizacion.alpha = 0.5
            
        }
        else
        {
            guard let currentCoordinate = localizacion.location?.coordinate else { return }
            
            localizacion.delegate = self
            localizacion.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            localizacion.startUpdatingLocation()
            let x = localizacion.location
            print (x!)
            let region = MKCoordinateRegion(center: x!.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            
            let lat = x?.coordinate.latitude
            let alt = x?.coordinate.longitude
            
            MkMapa.showsUserLocation = true
            MkMapa.delegate = self
            
            MkMapa.setRegion(region, animated: true)
            
            
            
            
            
            
            punto1 = CLLocation(latitude: lat!, longitude: alt!)
            //punto2 = CLLocation(latitude: 40.0559016, longitude: -6.042097)
            //punto2 = CLLocation(latitude: 37.785833, longitude: -122.406417)
            
        }
        
        
    }

    @IBAction func btn_calcularDistancia(_ sender: Any)
    {
        
        let DistanciaEnMetros = punto1.distance(from: punto2)
        print (DistanciaEnMetros)
        //lbl_resultado.text = "\(DistanciaEnMetros)"
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destino = storyboard.instantiateViewController(withIdentifier: "listaEmpresaS") as? ViewControllerEmpresas else{return}
        //destino.nombre=cell.lbl_ciudad.text!
        destino.opcion=4
        destino.punto1=punto1
        
        let valor = Double(distancia.text!)
        
        destino.distancia = valor!*1000
        navigationController?.pushViewController(destino, animated: true)
    }
    
    func alertLocation(tit: String, men: String) {
        
        let alerta = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
}
