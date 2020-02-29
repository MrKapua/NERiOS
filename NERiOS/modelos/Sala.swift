//
//  Sala.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 31/01/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//
// modelo de datos para la información que se va a mostrar en la lista de todas las salas a mostrar

import Foundation

class SalaModel
{
    var uid: String
    var nombre: String
    var jugadores :String
    var precio :String
    var tematica :String
    var ref : String
    var reserva : String
    
    init(uid: String, nombre:String, jugadores:String, precio:String, tematica:String, ref:String, reserva:String)
    {
        self.uid = uid
        self.nombre = nombre
        self.jugadores = jugadores
        self.precio = precio
        self.tematica = tematica
        self.ref = ref
        self.reserva = reserva
    }
    
}
