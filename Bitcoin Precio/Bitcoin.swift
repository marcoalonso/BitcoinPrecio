//
//  Bitcoin.swift
//  Bitcoin Precio
//
//  Created by Marco Alonso Rodriguez on 11/01/23.
//

import Foundation

struct Bitcoin: Codable {
    let time: String
    let asset_id_quote: String
    let rate: Double
}
