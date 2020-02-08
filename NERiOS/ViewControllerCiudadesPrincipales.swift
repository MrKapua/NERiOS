//
//  ViewControllerCiudadesPrincipales.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 01/02/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit

class ViewControllerCiudadesPrincipales: UIViewController, UITableViewDelegate, UITableViewDataSource
{
        
    let listaCiudades = ["MADRID", "BARCELONA", "VALENCIA", "SEVILLA", "ZARAGOZA", "MALAGA", "BILBAO", "ALICANTE", "CORDOBA", "VALLADOLID"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return listaCiudades.count
       }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellCiudad
    
          cell.lbl_ciudad.text = listaCiudades[indexPath.row]
          //cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])
    
          return cell
       }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    let cell = tableView.cellForRow(at: indexPath) as! TableViewCellCiudad
        print(cell.lbl_ciudad.text!)
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destino = storyboard.instantiateViewController(withIdentifier: "listaEmpresaS") as? ViewControllerEmpresas else{return}
        destino.nombre=cell.lbl_ciudad.text!
        destino.opcion=1
        navigationController?.pushViewController(destino, animated: true)
    }
    
       override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
       }

}
