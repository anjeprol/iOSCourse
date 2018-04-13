//
//  NetworkManager.swift
//  WebServices
//
//  Created by Antonio Prado on 4/13/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
    func connectionFinishSuccessfull(session: NetworkManager, response: NSDictionary)
    func connectionFinishWithError(session: NetworkManager, error: String)
    
}

class NetworkManager: NSObject, URLSessionDataDelegate, URLSessionDelegate {
    var delegate: NetworkManagerDelegate?
    var dataResponse: Data? //Bytes descargados
    var dataTask: URLSessionDataTask? // Desencadena el conjunto de tareas de descarga
    
    //Funciones que consumen los servicios web
    func getCars(){
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlStr = "https://www.code3e.com/JSON/CarsInfo.php"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
        var request = URLRequest(url: URL(string: urlStr )!)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        
        //        let body = "email=\("email")&password=\("password")"
        //        request.httpBody = body.data(using: .utf8)
        
        dataResponse = Data()
        dataTask = session.dataTask(with: request)
        dataTask?.resume()
    }
    
    // Funciones del protocolo de Apple de Networking
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        if let httpResponse = response as? HTTPURLResponse {
            
            if httpResponse.statusCode == 200 {
                completionHandler(URLSession.ResponseDisposition.allow) // Comienza la descarga
            } else {
                print("Status code different to 200: \(httpResponse.statusCode)")
                completionHandler(.cancel)
            }
        } else {
            print("Ups response fue nil")
            delegate?.connectionFinishWithError(session: self, error: "Algo salió, response nil")
        }
    }
    
    // Descarga de datos
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        dataResponse?.append(data)
    }
    
    // Finalice la descarga con esto...
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error == nil {
            do {
                if let result = try JSONSerialization.jsonObject(with: dataResponse!, options: .mutableContainers) as? NSDictionary {
                    delegate?.connectionFinishSuccessfull(session: self, response: result)
                } else {
                    delegate?.connectionFinishWithError(session: self, error: "Diccionario nulo")
                }
            } catch let error {
                delegate?.connectionFinishWithError(session: self, error: error.localizedDescription)
            }
        } else {
            delegate?.connectionFinishWithError(session: self, error: error!.localizedDescription)
        }
    }
}
