//
//  DetailedMentorWorker.swift
//  ITmentors
//
//  Created by Alexey Vadimovich on 29.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore
class DetailedMentorWorker {
    func sendReport(to: String?, with: String?, completion: @escaping () -> (), error: @escaping () -> ()){
        
        guard let to = to, let with = with else {error(); return}
        let ref = Firestore.firestore().collection("Reports").document(to)
        ref.setData(["MentorID" : to as Any,
                     "Reason": with as Any], merge: true){ err in
            guard err == nil else {error(); return}
            completion()
        }
    }

}
