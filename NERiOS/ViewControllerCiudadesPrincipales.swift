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
    //creamos una lista de las ciudades más pobladas de España, sacada de internet, no es mutable, por lo que se carga directamente desde una variable
    let listaCiudades = ["MADRID", "BARCELONA", "VALENCIA", "SEVILLA", "ZARAGOZA", "MALAGA", "BILBAO", "ALICANTE", "CORDOBA", "VALLADOLID"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return listaCiudades.count
       }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellCiudad
          cell.lbl_ciudad.text = listaCiudades[indexPath.row]
          return cell
       }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        /*lo que hacemos con esto es seleccionar una ciudad es:
         *  saber la ciudad que seleccionamos
         *  registrar la view a la que vamos a acceder
         *  pasar datos a la siguiente view
         *  abrir la view
         */
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCellCiudad
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destino = storyboard.instantiateViewController(withIdentifier: "listaEmpresaS") as? ViewControllerEmpresas else{return}
        destino.nombre=cell.lbl_ciudad.text!
        destino.opcion=1
        navigationController?.pushViewController(destino, animated: true)
    }
    
       override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
       }

}
