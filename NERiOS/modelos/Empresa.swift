//
//  Empresa.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 18/01/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//
// el modelo dedatos con la información básica de lo que se necesita mostrar

import Foundation

class EmpresaModel
    
{
    var uid: String
    var nombre: String
    var ciudad: String
    var provincia :String
    var foto: String
    init(uid: String, nombre: String, ciudad : String,provincia:String, foto:String)
    {
        self.uid = uid
        self.nombre = nombre
        self.ciudad = ciudad
        self.provincia=provincia
        self.foto=foto
    }
}

class EmpresaModelLong
{
    var uid: String
    var nombre: String
    var ciudad: String
    var provincia: String
    var direccion: String
    var telefono: String
    var coorLat: String
    var coorLon: String
    init(uid: String, nombre: String, ciudad: String, provincia: String, direccion: String,
         telefono: String, coorLat: String, coorLon: String)
    {
        self.uid = uid
        self.nombre = nombre
        self.ciudad = ciudad
        self.provincia = provincia
        self.direccion = direccion
        self.telefono = telefono
        self.coorLat = coorLat
        self.coorLon = coorLon
    }
}
