//
//  ModalVC.swift
//  MKMapViewTest
//
//  Created by 김은상 on 2023/08/06.
//

import UIKit

class ModalVC: UIViewController {
    //MARK: - Properties
    private lazy var 신대방: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "신대방역 근처 원룸"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var 천육십: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1000 / 60"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var 원룸: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "원룸"
        label.textColor = Constant.appColor
        label.backgroundColor = .white
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.layer.borderColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1.00).cgColor
        label.layer.borderWidth = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var 월세: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "월세"
        label.textColor = Constant.appColor
        label.backgroundColor = .white
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.layer.borderColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1.00).cgColor
        label.layer.borderWidth = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingModal()
    }
    
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(신대방)
        view.addSubview(천육십)
        view.addSubview(월세)
        view.addSubview(원룸)
        
        NSLayoutConstraint.activate([
            신대방.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            신대방.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            신대방.heightAnchor.constraint(equalToConstant: 30),
            신대방.widthAnchor.constraint(equalToConstant: 200),
            
            천육십.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            천육십.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            천육십.heightAnchor.constraint(equalToConstant: 30),
            천육십.widthAnchor.constraint(equalToConstant: 100),
            
            월세.topAnchor.constraint(equalTo: 천육십.bottomAnchor, constant: 10),
            월세.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            월세.heightAnchor.constraint(equalToConstant: 30),
            월세.widthAnchor.constraint(equalToConstant: 50),
            
            원룸.topAnchor.constraint(equalTo: 천육십.bottomAnchor, constant: 10),
            원룸.trailingAnchor.constraint(equalTo: 월세.leadingAnchor, constant: -10),
            원룸.heightAnchor.constraint(equalToConstant: 30),
            원룸.widthAnchor.constraint(equalToConstant: 50),
            
            
        ])
    
        
    }
    
    func settingModal() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = 25
        }
        
        
    }
    
    //MARK: - Actions


    

}
