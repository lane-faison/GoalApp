//
//  RadioButtonView.swift
//  GoalApp
//
//  Created by Lane Faison on 7/23/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

protocol TimeButtonViewDelegate: class {
    func userTappedButton()
}

class TimeButtonView: UIView {
    
    var viewModel: TimeButtonViewModel?
    
    var delegate: TimeButtonViewDelegate?
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.primaryGreen.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()
    
    func configure(with viewModel: TimeButtonViewModel) {
        self.viewModel = viewModel
        
        button.setTitle(viewModel.title, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        viewModel?.buttonTapped()
        
        delegate?.userTappedButton()
    }
    
    private func setupView() {
        backgroundColor = UIColor.primaryBlue
        
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    func changeAppearance(isSelected: Bool) {
        if isSelected {
            viewModel?.isSelected = true
            button.backgroundColor = .primaryGreen
            button.setTitleColor(.white, for: .normal)
        } else {
            viewModel?.isSelected = false
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        }
        
    }
}
