//
//  ViewController.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/17/24.
//

import UIKit
import Combine

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
        label.setValueText(Date().toString)
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
        
        return label
    }()
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
    
        return pickerView
    }()
    
    private let currencies: [CurrencyType] = [.KRW, .JPY, .PHP]
    
    private var currencyVM: CurrencyViewModel = CurrencyViewModel()
    
    var currencyType: CurrencyType {
        return currencies[Local.DB.currencyTag]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addGesture()
        bind()
        getCurrencyData()
        setLayout()
    }
}

//MARK: - view layout setting
extension MainViewController {
    private func setLayout() {
        view.addSubview(titlelabel)
        view.addSubview(remittanceCountryLabel)
        view.addSubview(receivingCountryLabel)
        view.addSubview(exchangeRateLabel)
        view.addSubview(inquiryTimeLabel)
        view.addSubview(remittanceAmountLabel)
        view.addSubview(resultLabel)
        view.addSubview(pickerView)
        
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
            resultLabel.heightAnchor.constraint(equalToConstant: 30),
            
            pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension MainViewController {
    func setupView() {
        setTextField()
        setPickerView()
        
        let currencyName = currencyType == .KRW ? "KRW" : currencyType == .JPY ? "JPY" : "PHP"
        
        receivingCountryLabel.setValueText("\(currencyType.rawValue)")
        exchangeRateLabel.setValueText("?? \(currencyName) / USD")
        
        inquiryTimeLabel.refreshButton.addTarget(self, action: #selector(getCurrencyData), for: .touchUpInside)
    }
    
    func setTextField() {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 45.0))
        
        let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(didTapScreen))
        
        toolBar.setItems([doneButton], animated: false)
        remittanceAmountLabel.textField.inputAccessoryView = toolBar
        remittanceAmountLabel.textField.delegate = self
    }
    
    func setPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(Local.DB.currencyTag, inComponent: 0, animated: false)
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    func bind() {
        currencyVM.textFieldBind(remittanceAmountLabel.textField) { [weak self] in
            let currencyName = self?.currencyType == .KRW ? "KRW" : self?.currencyType == .JPY ? "JPY" : "PHP"
            
            self?.calculateExchangeRate(from: $0, to: currencyName)
        }
    }
    
    func calculateExchangeRate(from usd: String, to currencyName: String) {
        let exchageRate = currencyVM.getExchangeRate(type: currencyType)
        let amount: Double = exchageRate * (Double(usd) ?? 0.0)
        
        resultLabel.text = "수취금액은 \(amount.toCurrency) \(currencyName) 입니다."
    }
}

//MARK: - Objc function
extension MainViewController {
    @objc func didTapScreen() {
        view.endEditing(true)
    }
    
    @objc func getCurrencyData() {
        inquiryTimeLabel.startLodingAnimation()
        
        currencyVM.getCurrencyData { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    guard let text = self.remittanceAmountLabel.textField.text else { return }
                    
                    let currencyName = self.currencyType == .KRW ? "KRW" : self.currencyType == .JPY ? "JPY" : "PHP"
                    let exchangeRate = self.currencyVM.getExchangeRate(type: self.currencyType)
                    
                    self.exchangeRateLabel.setValueText("\(exchangeRate.toCurrency) \(currencyName) / USD")
                    self.calculateExchangeRate(from: text, to: currencyName)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "통신 오류", message: "데이터를 불러오지 못했습니다.\n잠시 후 다시 시도해주세요")
                }
            }
            DispatchQueue.main.async {
                self.inquiryTimeLabel.stopLodingAnimation()
            }
        }
    }
}

//MARK: - 숫자만 입력 받을 수 있게 설정
extension MainViewController: UITextFieldDelegate {
    // 참고 주소 - https://ios-development.tistory.com/688
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldString = textField.text, let newRange = Range(range, in: oldString) else { return false }
        if !string.isEmpty && string.range(of: "^[0-9]*$", options: .regularExpression) == nil {
            showAlert(title: "입력 오류", message: "숫자만 입력해주세요")
            return false
        }
        
        let newString = oldString.replacingCharacters(in: newRange, with: string)
        
        guard newString.count < 6, (Int(newString.isEmpty ? "0" : newString) ?? Int.max) <= 10000 else {
            showAlert(title: "입력 오류", message: "10000USD 이하만 입력 가능합니다.")

            return false
        }
        return true
    }
}

//MARK: - PickerView delegate, datasource 구현
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Local.DB.currencyTag = row
    
        let currencyName = currencyType == .KRW ? "KRW" : currencyType == .JPY ? "JPY" : "PHP"
        let exchangeRate = currencyVM.getExchangeRate(type: currencyType)
        
        receivingCountryLabel.setValueText("\(currencyType.rawValue)")
        exchangeRateLabel.setValueText("\(exchangeRate.toCurrency) \(currencyName) / USD")
        
        guard let usd = remittanceAmountLabel.textField.text else { return }
        
        calculateExchangeRate(from: usd.isEmpty ? "0" : usd, to: currencyName)
    }
}
