//
//  ViewControllerSalas.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 01/02/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewControllerSalas: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    var nombre_empresa=""
    var salas = [SalaModel]()
    
    @IBOutlet weak var TvSala: UITableView!
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salas.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CellSala", for: indexPath)
            as! TableViewCellSala
        let sala: SalaModel
        sala = salas[indexPath.row]
        
        celda.lbl_nombre.text = sala.nombre
        celda.lbl_precio.text = sala.precio
        celda.lbl_personas.text = sala.jugadores
        celda.lbl_tematica.text = sala.tematica
        celda.lbl_ref.text = sala.ref
        
        return celda
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCellSala
        print(cell.lbl_ref.text!)
        /*
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detallerSala = storyboard.instantiateViewController(withIdentifier: "empresaSalaS") as? ViewControllerDetalleEmpresa else{return}
        
        //detallerEmpresa.uid=cell.lbl_uid.text!
        navigationController?.pushViewController(detallerSala, animated: true)
        */
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //FirebaseApp.configure()
        let salaRef = Database.database().reference().child("Salas")
        
        salaRef.observe(DataEventType.value, with:{(snapshot) in
            if (snapshot.childrenCount>0)
            {
                self.salas.removeAll()
                
                for Sala in snapshot.children.allObjects as![DataSnapshot]
                {
                    
                    let objSala = Sala.value as? [String:AnyObject]
                    let salaUid = objSala?["empresa"]
                    let salaNombre = objSala?["nombre"]
                    let salaJugadores = objSala?["jugadores"]
                    let salaPrecio = objSala?["precio"]
                    let salaTematica = objSala?["tematica"]
                    
                    
                    if((salaUid?.contains(self.nombre_empresa))!)
                    {
                        
                        let salaDato = SalaModel(
                            
                                               uid: salaUid as! String,
                                               nombre: salaNombre as! String,
                                               jugadores: salaJugadores as! String,
                                               precio: salaPrecio as! String,
                                               tematica: salaTematica as! String,
                                               ref: "Sala.key")
                        
                        self.salas.append(salaDato)
                    }
                }
                self.TvSala.reloadData()
            }
        })
        
    }

    
    

}
