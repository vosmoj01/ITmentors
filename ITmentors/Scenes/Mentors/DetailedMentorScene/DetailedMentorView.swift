//
//  DetailedMentorView.swift
//  ITmentors
//
//  Created by Alexey Vadimovich on 22.11.2022.
//

import UIKit
protocol DetailedMentorViewDelegate: AnyObject {
    func openMentorLink(withUrlAsString: String)
}

// for i in 1...20{
//let vieww = UIImageView()
//vieww.image = UIImage(named: "animals\(Int.random(in: 1...7))")
//vieww.contentMode = .scaleAspectFill
//vieww.backgroundColor = .clear
//
//let viewHeight = view.bounds.height
//let viewWigth = view.bounds.width
//
//let randomY = CGFloat(viewHeight) + CGFloat.random(in: -300...(-50))
//let randomX = CGFloat.random(in: -30...50)
//let randomHeight = CGFloat.random(in: 40...80)
//
//let randomSpeed = Double.random(in: 1.5...2.3)
//let viewFrame = CGRect(x: randomX, y: randomY, width: randomHeight, height: randomHeight)
//vieww.frame = viewFrame
//view.addSubview(vieww)
//
//let randXMult = CGFloat.random(in: 0.5...1.5)
//let randYMult = CGFloat.random(in: 0.7...0.95)
//UIView.animateKeyframes(withDuration: randomSpeed, delay: 0.0, options: [.calculationModeCubic], animations: {
//    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: randomSpeed / 4.4, animations: {
//        vieww.center =  CGPoint(x: 200 * randXMult, y: randomY * randYMult - 0.1)
//        vieww.alpha = 0.2
//    })
//    UIView.addKeyframe(withRelativeStartTime: randomSpeed / 4.4, relativeDuration: randomSpeed / 3.3, animations: {
//        //                    vieww.center =  CGPoint(x: , y: viewWigth * )
//        vieww.center =  CGPoint(x: 300 * randXMult , y: randomY * randYMult - 0.2)
//        vieww.alpha = 0.3
//    })
//
//    UIView.addKeyframe(withRelativeStartTime: randomSpeed / 3.3 + randomSpeed / 4, relativeDuration: randomSpeed / 3.3, animations: {
//        vieww.center =  CGPoint(x: 500 * randXMult, y: randomY * randYMult - 0.3)
//        vieww.alpha = 0.6
//    })
//}, completion: { _ in
//    vieww.removeFromSuperview()
//})

class DetailedMentorView: UIView{
    
    weak var delegate: DetailedMentorViewDelegate?
    
    
    var model: DetailedMentor.ShowMentorInfo.ViewModel? {
        didSet{
            guard let model = model else {return}
            guard let imageData = model.imageData else {return}
            mentorImageView.image = UIImage(data: imageData)
            shortDiscriptionLabel.text = model.shortDiscription
            messageLink = model.messageLink ?? ""
            arrayOfLanguages = model.languages
            descriptionLabel.text = model.discription
            
            addCollection()
            setSubviews()
            setConstraints()
        }
    }
    var messageLink = ""
    var arrayOfLanguages: [Language] = []
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .AppPalette.backgroundColor

        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mentorImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.image = UIImage()
        iv.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        iv.layer.borderWidth = 2
        iv.layer.cornerRadius = (UIScreen.main.bounds.width * 0.7) / 2
        return iv
    }()
    private let shortDiscriptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5
        return l
    }()
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    private let writeToMentorButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .AppPalette.thirdElementColor
        b.addTarget(self, action: #selector(writeMentor), for: .touchUpInside)
        b.setTitle("Связаться с ментором", for: .normal)
        b.layer.cornerRadius = 10
        return b
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
    
    @objc func writeMentor(){
        delegate?.openMentorLink(withUrlAsString: messageLink)
    }
}
extension DetailedMentorView{
    
    
    func addCollection(){
        addSubview(collectionViewOfLanguages)

        collectionViewOfLanguages.delegate = self
        collectionViewOfLanguages.dataSource = self
        collectionViewOfLanguages.register(LanguageCollectionViewCell.self, forCellWithReuseIdentifier: "LanguageCell")
    }
    
    func setSubviews(){
        addSubview(mentorImageView)
        addSubview(shortDiscriptionLabel)
        addSubview(descriptionLabel)
        addSubview(writeToMentorButton)
    }
    func setConstraints(){
        

        
        mentorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(mentorImageView.snp.width)
            make.centerX.equalToSuperview()
        }
        shortDiscriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mentorImageView.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
//        let screensize: CGRect = UIScreen.main.bounds
//        let itemsWidth = screensize.width * 0.9
//        var heigth = 0
//        //calculate collectionViewHeight
//        for i in 1...arrayOfLanguages.count + 1 {if i % 3 == 0{heigth += 35}}
//        if heigth == 0 {heigth = 30}
        
        collectionViewOfLanguages.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
            make.top.equalTo(shortDiscriptionLabel.snp.bottom).offset(10)
        }
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionViewOfLanguages.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(40.0)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        writeToMentorButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(70)
            make.right.equalToSuperview().offset(-70)
            make.height.equalTo(40)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
        }
    }
}





//MARK: UICollectionViewDataSource

extension DetailedMentorView: UICollectionViewDataSource {

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
extension DetailedMentorView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


//MARK: UICollectionViewDelegateFlowLayout
extension DetailedMentorView: UICollectionViewDelegateFlowLayout {
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
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let CellWidth = 90
        let CellCount = collectionView.numberOfItems(inSection: 0)
        let CellSpacing = 5
        let collectionViewWidth = collectionView.frame.width
        guard CGFloat(CellWidth * CellCount) < collectionViewWidth else {return UIEdgeInsets()}
        let totalCellWidth = CellWidth * CellCount
        let totalSpacingWidth = CellSpacing * (CellCount - 1)

        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
