//
//  ViewController.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/17/24.
//

import UIKit

class MainViewController: UIViewController {
    let titlelabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "환율 계산기"
        label.textAlignment = .center
        
        return label
    }()
    
    let remittanceCountryLabel: KeyValueLabel = {
        let label = KeyValueLabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.keyLabel.text = "송금국가 :"
        label.valueLabel.text = "미국(USD)"
        
        return label
    }()
   
    let receivingCountryLabel: KeyValueLabel = {
        let label = KeyValueLabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.keyLabel.text = "수취국가 :"
        label.valueLabel.text = ""
        
        return label
    }()
    
    let exchangeRateLabel: KeyValueLabel = {
        let label = KeyValueLabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.keyLabel.text = "환율 :"
        label.valueLabel.text = ""
        
        return label
    }()
    
    let inquiryTimeLabel: KeyValueLabel = {
        let label = KeyValueLabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.keyLabel.text = "조회시간 :"
        label.valueLabel.text = ""
        label.refreshButton.isHidden = false
        
        return label
    }()
    
    let remittanceAmountLabel: KeyValueLabel = {
        let label = KeyValueLabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.keyLabel.text = "송금액 :"
        label.valueLabel.text = "미국(USD)"
        label.textField.isHidden = false
        
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "수취금액은 113,004,98 KRW 입니다."
        
        return label
    }()
    
    let currencyManager: CurrencyManager = CurrencyManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        remittanceAmountLabel.textField.delegate = self
        currencyManager.getCurrencyData { result in
            switch result {
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setText()
    }
}

extension MainViewController {
    private func setLayout() {
        view.addSubview(titlelabel)
        view.addSubview(remittanceCountryLabel)
        view.addSubview(receivingCountryLabel)
        view.addSubview(exchangeRateLabel)
        view.addSubview(inquiryTimeLabel)
        view.addSubview(remittanceAmountLabel)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            titlelabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titlelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titlelabel.widthAnchor.constraint(equalToConstant: 250),
            titlelabel.heightAnchor.constraint(equalToConstant: 75),
            
            remittanceCountryLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 20),
            remittanceCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            remittanceCountryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            receivingCountryLabel.topAnchor.constraint(equalTo: remittanceCountryLabel.bottomAnchor, constant: 10),
            receivingCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            receivingCountryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
     
            exchangeRateLabel.topAnchor.constraint(equalTo: receivingCountryLabel.bottomAnchor, constant: 10),
            exchangeRateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exchangeRateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            inquiryTimeLabel.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor, constant: 10),
            inquiryTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inquiryTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            remittanceAmountLabel.topAnchor.constraint(equalTo: inquiryTimeLabel.bottomAnchor, constant: 10),
            remittanceAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            remittanceAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: remittanceAmountLabel.bottomAnchor, constant: 50),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            resultLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setText() {
        remittanceCountryLabel.setValueText("미국(USD)")
        receivingCountryLabel.setValueText("한국 (KRW)")
        exchangeRateLabel.setValueText("1,130.05 KRW / USD")
        inquiryTimeLabel.setValueText("2019-03-20 16:13")
        remittanceAmountLabel.setValueText("USD")
    }
}

//MARK: - 숫자만 입력 받을 수 있게 설정
extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.range(of: "^[0-9]*$", options: .regularExpression) != nil {
            return true
        }
        return false
    }
}
