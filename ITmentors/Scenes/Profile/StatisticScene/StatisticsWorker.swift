//
//  StatisticsWorker.swift
//  ITmentors
//
//  Created by Alexey Vadimovich on 28.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Firebase
import FirebaseFirestore
class StatisticsWorker {
    func loadStats(completion: @escaping ([Int]) -> (), error: @escaping () -> ()){
        var numberOfClickThroughs = 0
        var numberOfProfileViews = 0
        guard let urUUID = Defaults.getShortUUID() else {error();return}
        let ref = Firestore.firestore().collection("Mentors").document(urUUID).collection("Stats").document("Stats")
        ref.getDocument { document, error in
            guard error == nil else {return}
            if document?.exists != true {return}
            
            let views = document?.get("NumberOfProfileViews") as? Int
            let clicks = document?.get("NumberOfClickThroughs") as? Int

            numberOfProfileViews = views ?? 0
            numberOfClickThroughs = clicks ?? 0

            completion([numberOfProfileViews, numberOfClickThroughs])
        }
        
    }
}

