//
//  CustomLabel.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/19/24.
//

import UIKit

class KeyValueLabel: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 4
        
        return stackView
    }()
    
    let keyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 12.5
        button.isHidden = true
        
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "최대 10,000USD"
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
        textField.borderStyle = .line
        textField.isHidden = true
        textField.font = .systemFont(ofSize: 12, weight: .regular)
        
        return textField
    }()
    
    private var valueLabelWidthConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 25)
    }
}

//MARK: - setting
extension KeyValueLabel {
    private func setLayout() {
        stackView.addArrangedSubview(keyLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(refreshButton)
        stackView.addArrangedSubview(activityIndicator)
        
        addSubview(stackView)
        
        valueLabelWidthConstraint = valueLabel.widthAnchor.constraint(equalToConstant: 200)
        valueLabelWidthConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            keyLabel.widthAnchor.constraint(equalToConstant: 100),
            textField.widthAnchor.constraint(equalToConstant: 100),
            refreshButton.widthAnchor.constraint(equalToConstant: 25),
            activityIndicator.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func setValueLabelWidth(_ size: CGSize) {
        valueLabelWidthConstraint.constant = size.width
    }
    
    func setValueText(_ text: String) {
        print("world")
        valueLabel.text = text
        
        setValueLabelWidth(valueLabel.sizeThatFits(CGSize(width: 250, height: 25)))
    }
}

extension KeyValueLabel {
    func startLodingAnimation() {
        refreshButton.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLodingAnimation() {
        activityIndicator.stopAnimating()
        refreshButton.isHidden = false
    }
}
