//
//  SelectLanguageViewModel.swift
//  ITmentors
//
//  Created by Alexey Vadimovich on 01.10.2022.
//

import UIKit

protocol SelectLanguagesViewModelProtocol: AnyObject {
    var arrayOfSelectedLanguages: [Language] { get set }
    var arrayOfAllLanguages: [Language] { get set }
    func appendToArray(cellIndexPathRow: Int)
    func removeFromArray(cellIndexPathRow: Int)

}

class  SelectLanguagesViewModel: SelectLanguagesViewModelProtocol {
    var arrayOfSelectedLanguages: [Language] = []
    var arrayOfAllLanguages: [Language] = Language.allCases

    func appendToArray(cellIndexPathRow: Int){
        arrayOfSelectedLanguages.append(arrayOfAllLanguages[cellIndexPathRow])
        print(arrayOfSelectedLanguages)

    }
    func removeFromArray(cellIndexPathRow: Int){
        var number = 0
        if arrayOfSelectedLanguages.count >= 1 {number = 1}
        for i in 0...arrayOfSelectedLanguages.count - number {
//            print(arrayOfSelectedLanguages)
            let elementWeNeedDelete = arrayOfAllLanguages[cellIndexPathRow]
            let elementWeCheck = arrayOfSelectedLanguages[i]
            if elementWeNeedDelete == elementWeCheck{
                arrayOfSelectedLanguages.remove(at: i)
                break
            }
        }

    }
}
