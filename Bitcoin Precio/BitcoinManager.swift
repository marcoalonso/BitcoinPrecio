//
//  BitcoinManager.swift
//  Bitcoin Precio
//
//  Created by Marco Alonso Rodriguez on 11/01/23.
//

import Foundation

protocol BitcoinProtocol {
    func actualizarPrecio(bitcoin: Bitcoin)
}

struct BitcoinManager {
    
    var delegado: BitcoinProtocol?
    
    //1.- Devolver la info closure
    func actualizarPrecioClosure(moneda: String, completionHandler: @escaping (_ precio: Bitcoin?, _ error: Error?) -> ()) {
        let urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(moneda)/?apikey=762DEF17-B7CD-49B7-96EC-57D995E9E339"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { datos, respuesta, error in
                guard let datos = datos else { return }
                
                let decodificador = JSONDecoder()
                
                do {
                    let dataDecodificada = try decodificador.decode(Bitcoin.self, from: datos)
                    print(dataDecodificada)
                    completionHandler(dataDecodificada, nil)
                } catch {
                    print("Debug: error \(error.localizedDescription)")
                    completionHandler(nil, error)
                }
            }.resume()
        }
    }
    
    //Delegado
    func actualizarPrecio(moneda: String) {
        let urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(moneda)/?apikey=762DEF17-B7CD-49B7-96EC-57D995E9E339"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let dataDecodificada = try decoder.decode(Bitcoin.self, from: data)
                    //Mandar a traves del delegado hacia el VC
                    delegado?.actualizarPrecio(bitcoin: dataDecodificada)
                    
                } catch {
                    print("Debug: error \(error.localizedDescription)")
                }
            }
            .resume()
        }
    }
}
