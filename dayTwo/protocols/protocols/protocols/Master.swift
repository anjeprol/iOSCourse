//
//  Master.swift
//  protocols
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import Foundation

protocol MasterDelegate {
    func greeting(to name:String)
    func requestHowMuchMixDoYouNeed() -> Double
    func mixReadyToUse()
}

class Master:NSObject {
    var delegate: MasterDelegate?
    
    override init() {
        super.init()
        print("Initialized object")
        
        // ScheduledTimer es una función estática
        // Closures -> Lambas - > Para procesos asincronos
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            let quantity = self.delegate?.requestHowMuchMixDoYouNeed()
            print("He needs \(quantity ?? 0) kg of mix")
            
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: {_ in
                print("The mix is ready to use it!")
                self.delegate?.mixReadyToUse()
            })
        })
    }
}
