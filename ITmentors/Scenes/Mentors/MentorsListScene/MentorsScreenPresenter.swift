//
//  MentorsScreenPresenter.swift
//  ITmentors
//
//  Created by Alexey Vadimovich on 27.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MentorsScreenPresentationLogic {
    func presentMentors(response: MentorsScreen.ShowMentorCells.Response)
}

class MentorsScreenPresenter: MentorsScreenPresentationLogic {
    
    weak var viewController: MentorsScreenDisplayLogic?
    
    // MARK: Do something
    
    func presentMentors(response: MentorsScreen.ShowMentorCells.Response) {
        // создадим пустой массив, который мы потом передадидим во ViewController
        var rows: [MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel] = []

        // пройдемся по элементам массива, полученного из Interactor'a.
        // мы не можем сразу приравнять массив из Interactor'a к массиву ViewModel'и из-за разным типов данных
        //  поэтому делаем следущее:
        for i in response.mentorCellsData{
            let newElement = MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel(cellData: i)
            rows.append(newElement)
        }
        
        // в итоге вернем созданный массив во ViewController.
        let viewModel = MentorsScreen.ShowMentorCells.ViewModel(rows: rows)
        viewController?.displayMentorCells(viewModel: viewModel)
    }
}
