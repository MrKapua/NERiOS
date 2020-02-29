//
//  ViewControllerMain.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 19/12/2019
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerMain: UIViewController
{

    @IBOutlet weak var btn_personal: UIButton!
    @IBOutlet weak var btn_radar: UIButton!
    @IBOutlet weak var btn_busqueda: UIButton!
    @IBOutlet weak var btn_princCiudades: UIButton!
    @IBOutlet weak var lbl_nombre: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cargarBasico()
        //En las siguientes lineas se define la forma del botón
        btn_princCiudades.layer.cornerRadius = 20.0
        btn_princCiudades.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
        btn_radar.layer.cornerRadius = 20.0
        btn_radar.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
        btn_busqueda.layer.cornerRadius = 20.0
        btn_busqueda.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
        btn_personal.layer.cornerRadius = 20.0
        btn_personal.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func btn_datosPersonales(_ sender: Any)
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destino = storyboard.instantiateViewController(withIdentifier: "datosPeronalesS") as? ViewControllerDatosPersonales else{
            return
            }
        navigationController?.pushViewController(destino, animated: true)
    }
    
    public func cargarBasico()
    {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        //obtenemos el uid
        let uid = Auth.auth().currentUser?.uid
        //se crea la referencia con la que obtendremos datos, en este caso el nombre del usuario registrado
        let parentRef = Database.database().reference().child("Usuario").child(uid!)
        parentRef.observeSingleEvent(of: .value, with: {snapshot in
            let dic = snapshot.value as! [String:  Any]
            let nombre = dic["nombre"] as? String ?? ""
            self.lbl_nombre.text="Hola \(nombre) "
         })
    }
}
