//
//  MentorCell.swift
//  ITmentors
//
//  Created by Alexey Vadimovich on 28.09.2022.
//

import Foundation
import UIKit
import SnapKit
protocol CellModelRepresentable {
    var cellModel: CellIdentifiable? { get set }
}
protocol goToDetailedMentorScreenDelegateProtocol: AnyObject{
    func goToDetailedMentorScreen(withData: MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel)
}

class MentorCell: UITableViewCell, CellModelRepresentable {
    var goToDetailedMentorScreenDelegate: goToDetailedMentorScreenDelegateProtocol?
    
    var cellModel: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    private var arrayOfLanguages: [Language] = []
    
    private func updateViews() {
        guard let cellModel = cellModel as? MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel else { return }
        
        arrayOfLanguages = cellModel.languages
        nameLabel.text = cellModel.name
        discriptionLabel.text = cellModel.shortDiscription
        mentorImageView.image = UIImage(data: cellModel.imageData ?? Data())
        
        backgroundColor = .AppPalette.secondElementColor

        addSubviews()
        addConstraints()
    }
    
    
    
    private let mentorImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.image = UIImage()
        iv.layer.cornerRadius = 40
        iv.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        iv.layer.borderWidth = 2
        iv.isUserInteractionEnabled = false
        return iv
    }()
    private let discriptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5
        return l
    }()
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.textAlignment = .left
        l.font = UIFont.boldSystemFont(ofSize: 30)
        return l
    }()
    private let collectionViewOfLanguages: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 6
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
       return collectionView
    }()
    private let goToMentorDetailesScreenButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.AppPalette.thirdElementColor, renderingMode: .alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(goToMentorDetailesScreen), for: .touchUpInside)
       return b
    }()
    
    @objc func goToMentorDetailesScreen(){
        guard let cellModel = cellModel as? MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel else {return}
        goToDetailedMentorScreenDelegate?.goToDetailedMentorScreen(withData: cellModel)
    }
    
}

extension MentorCell{
    func addSubviews(){
        
        collectionViewOfLanguages.delegate = self
        collectionViewOfLanguages.dataSource = self
        collectionViewOfLanguages.register(LanguageCollectionViewCell.self, forCellWithReuseIdentifier: "LanguageCell")
        
        contentView.addSubview(collectionViewOfLanguages)
        contentView.addSubview(mentorImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(discriptionLabel)
        contentView.addSubview(goToMentorDetailesScreenButton)

    }
    
    func addConstraints(){
        collectionViewOfLanguages.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(mentorImageView.snp.right).offset(15)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        mentorImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(mentorImageView.snp.height)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(mentorImageView.snp.right).offset(15)
            make.top.equalToSuperview().offset(5)
        }
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
            make.left.equalTo(mentorImageView.snp.right).offset(15)
            make.bottom.equalTo(collectionViewOfLanguages.snp.top).offset(-7)
            make.right.equalTo(goToMentorDetailesScreenButton.snp.left).offset(-7)
        }
        goToMentorDetailesScreenButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(collectionViewOfLanguages.snp.top).offset(-20)
            make.height.width.equalTo(30)
        }
    }
}



//MARK: UICollectionViewDataSource

extension MentorCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfLanguages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCell", for: indexPath) as! LanguageCollectionViewCell
        cell.setup(language: arrayOfLanguages[indexPath.row])

        return cell
    }
}


//MARK: UICollectionViewDataSource
extension MentorCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      goToMentorDetailesScreen()
    }

}


//MARK: UICollectionViewDelegateFlowLayout
extension MentorCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
    }
    
}
