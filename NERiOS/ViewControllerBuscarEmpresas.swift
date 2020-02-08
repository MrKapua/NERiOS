//
//  ViewControllerBuscarEmpresas.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 26/01/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit

class ViewControllerBuscarEmpresas: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    
    
    @IBAction func btn_buscar(_ sender: Any)
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destino = storyboard.instantiateViewController(withIdentifier: "listaEmpresaS") as? ViewControllerEmpresas else{return}
        destino.nombre=provincia
        if(provincia=="Todas")
        {
            destino.opcion = 3
        }
        else
        {
            destino.opcion = 2
        }
        navigationController?.pushViewController(destino, animated: true)
    }
    @IBOutlet weak var listaProvincias: UIPickerView!
    var provincia = "Todas"
    let pickerProvincias = ["Todas","Álava","Albacete","Alicante","Almería","Asturias","Ávila","Badajoz","Baleares","Barcelona","Burgos","Cáceres","Cádiz","Cantabria","Castellón","Ceuta","Ciudad Real","Córdoba","Cuenca","Gerona","Granada","Guadalajara","Guipúzcoa","Huelva","Huesca","Jaén","La Coruña","La Rioja","Las Palmas","León","Lérida","Lugo","Madrid","Málaga","Melilla","Murcia","Navarra","Orense","Palencia","Pontevedra","Salamanca","Santa Cruz de Tenerife","Segovia","Sevilla","Soria","Tarragona","Teruel","Toledo","Valencia","Valladolid","Vizcaya","Zamora","Zaragoza"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerProvincias[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerProvincias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        provincia = pickerProvincias[row]
        print (provincia)
    }
}


