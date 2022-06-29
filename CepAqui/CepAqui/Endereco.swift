//
//  Endereco.swift
//  CepAqui
//
//  Created by Virtual Machine on 20/06/22.
//

import Foundation

struct Endereco: Codable {
    let cep: String
    let logradouro: String
    let bairro: String
    let localidade: String
    let uf: String
}
