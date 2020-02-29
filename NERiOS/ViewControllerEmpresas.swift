//
//  ViewControllerEmpresas.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 18/01/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MapKit
import CoreLocation

class ViewControllerEmpresas: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var nombre = ""
    var opcion = 0
    var punto1 = CLLocation(latitude: 0, longitude: 0)
    var distancia = 0.0
    
    
    
    @IBOutlet weak var TbV_Empresas: UITableView!
    var empresas = [EmpresaModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empresas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
            as! TableViewCellEmpresa
        let empresa: EmpresaModel
        empresa = empresas[indexPath.row]
        
        if let url = NSURL(string:empresa.foto)
        {
            if let data = NSData(contentsOf: url as URL)
            {
                celda.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                celda.imageView?.image = UIImage(data: data as Data)
                celda.imageView?.scalesLargeContentImage=true
            }
        }
        celda.lbl_nombre.text = empresa.nombre
        celda.lbl_ciudad.text = empresa.ciudad
        celda.lbl_provincia.text = empresa.provincia
        celda.lbl_uid.text = empresa.uid
        
        return celda
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCellEmpresa
        print(cell.lbl_uid.text!)
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detalleEmpresa = storyboard.instantiateViewController(withIdentifier: "empresaDetalleS") as? ViewControllerDetalleEmpresa else{return}
        
        detalleEmpresa.uid=cell.lbl_uid.text!
        print(detalleEmpresa.uid)
        
        navigationController?.pushViewController(detalleEmpresa, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print (nombre)
        //FirebaseApp.configure()
        let empresasRef = Database.database().reference().child("Empresa")
        
        empresasRef.observe(DataEventType.value, with:{(snapshot) in
            if (snapshot.childrenCount>0)
            {
                self.empresas.removeAll()
                
                for Empresa in snapshot.children.allObjects as![DataSnapshot]
                {
                    
                    let objEmpresa = Empresa.value as? [String:AnyObject]
                    let empresaNombre = objEmpresa?["nombre"]
                    let empresaCiudad = objEmpresa?["ciudad"]
                    let empresaProvincia = objEmpresa?["provincia"]
                    let empresaUid = objEmpresa?["uid"]
                    let empresaLat = objEmpresa?["latitud"]
                    let empresaLon = objEmpresa?["longitud"]
                    let empresaFoto = objEmpresa?["foto"]
                    if(self.opcion == 3)
                    {
                        let empresaDato = EmpresaModel(uid: empresaUid as! String,
                                                       nombre: empresaNombre as! String,
                                                       ciudad: empresaCiudad as! String,
                                                       provincia: empresaProvincia as! String,
                                                       foto: empresaFoto as! String)
                        
                        self.empresas.append(empresaDato)
                    }
                    else if (self.opcion == 2)
                    {
                        if((empresaProvincia?.contains(self.nombre))!)
                            {
                            let empresaDato = EmpresaModel(uid: empresaUid as! String,
                                                           nombre: empresaNombre as! String,
                                                           ciudad: empresaCiudad as! String,
                                                           provincia: empresaProvincia as! String,
                                                           foto: empresaFoto as! String)
                            
                            self.empresas.append(empresaDato)
                            }
                    }
                    else if(self.opcion == 1)
                    {
                        if((empresaCiudad?.contains(self.nombre))!)
                        {
                        let empresaDato = EmpresaModel(uid: empresaUid as! String,
                                                       nombre: empresaNombre as! String,
                                                       ciudad: empresaCiudad as! String,
                                                       provincia: empresaProvincia as! String,
                                                       foto: empresaFoto as! String)
                        
                        self.empresas.append(empresaDato)
                        }
                    }
                    else if(self.opcion == 4)
                    {
                        var punto2 = CLLocation(latitude: empresaLat as! CLLocationDegrees, longitude: empresaLon as! CLLocationDegrees)
                        if(self.punto1.distance(from: punto2)<self.distancia)
                        {
                        let empresaDato = EmpresaModel(uid: empresaUid as! String,
                                                       nombre: empresaNombre as! String,
                                                       ciudad: empresaCiudad as! String,
                                                       provincia: empresaProvincia as! String,
                                                       foto: empresaFoto as! String)
                        
                        self.empresas.append(empresaDato)
                        }
                    }
                }
                self.TbV_Empresas.reloadData()
                //https://www.youtube.com/watch?v=ge56yTgnjKs  12:40
            }
        })
        
    }

}
