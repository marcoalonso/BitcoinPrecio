//
//  ViewController.swift
//  Bitcoin Precio
//
//  Created by Marco Alonso Rodriguez on 11/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var monedaLabel: UILabel!
    @IBOutlet weak var monedaPicker: UIPickerView!
    @IBOutlet weak var fechaBitcoinLabel: UILabel!
    @IBOutlet weak var precioBitcoinLabel: UILabel!
    
    var tipoCambio = ["USD", "MXN", "EUR", "JPY", "BRL", "CAD", "RUB","INR","SEK","NOK","RON"]
    
    var manger = BitcoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manger.delegado = self
        
        monedaPicker.delegate = self
        monedaPicker.dataSource = self
        
        //Obtenga la info la 1 vez
//        manger.actualizarPrecioClosure(moneda: "\(tipoCambio[0])") { precio, error in
//            if let bitcoin = precio {
//                DispatchQueue.main.async {
//                    let precioFormato = String(format: "%.2f", bitcoin.rate)
//                    self.precioBitcoinLabel.text = "$\(precioFormato)"
//                    self.fechaBitcoinLabel.text = "\(bitcoin.time)"
//                }
//            }
//        }
//        manger.actualizarPrecio(moneda: "\(tipoCambio[0])")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manger.actualizarPrecio(moneda: "\(tipoCambio[0])")
    }


}

extension ViewController: BitcoinProtocol {
    func actualizarPrecio(bitcoin: Bitcoin) {
        DispatchQueue.main.async {
            let precioFormato = String(format: "%.2f", bitcoin.rate)
            self.precioBitcoinLabel.text = "$\(precioFormato)"
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy, hh:MM:ss a"
            
            let dataFromAPI = dateFormatter.date(from: bitcoin.time)
            let date = dateFormatter.string(from: dataFromAPI ?? Date.now)
            print("Debug: \(date)")

            self.fechaBitcoinLabel.text = date
        }
    }
    
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipoCambio.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipoCambio[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Vibracion
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        
        manger.actualizarPrecio(moneda: "\(tipoCambio[row])")
        switch tipoCambio[row] {
        case "RON":
            monedaLabel.text = "Leus Romanos"
        case "USD":
            monedaLabel.text = "Dólares Estadounidenses"
        case "MXN":
            monedaLabel.text = "Pesos Mexicanos"
        case "EUR":
            monedaLabel.text = "Euros"
        case "JPY":
            monedaLabel.text = "Yenes"
        case "BRL":
            monedaLabel.text = "Reales Brasileños"
        case "CAD":
            monedaLabel.text = "Dólares Canadienses"
        case "RUB":
            monedaLabel.text = "Rublos Rusos"
        case "INR":
            monedaLabel.text = "Rupias Indias"
        case "SEK":
            monedaLabel.text = "Coronas Suecas"
        case "NOK":
            monedaLabel.text = "Coronas Noruegas"
        default:
            monedaLabel.text = "Moneda sin valor"
        }
    }
    
}

