//
//  SubjectTestViewController.swift
//  Rx_Basic
//
//  Created by Sungmin on 2020/12/09.
//

import RxSwift

class SubjectTestViewController: UIViewController {

    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    private let disposeBag = DisposeBag()
    private let basicSubject = PublishSubject<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        bind()
    }

    private func bind() {
        // basicSubject에 변화가 감지될 때마다 onNext 블록 수행
        basicSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { text in
                // onError, onComplete도 잘 처리해주면 좋다.
                print("subjectOne :",text)
                self.resultTextLabel.text = text
            })
            .disposed(by: disposeBag)
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension SubjectTestViewController: UITextFieldDelegate {
    // textField에 입력 후 return 하면 subject에 데이터 전달
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        defer {
            textField.resignFirstResponder()
        }

        guard let text = textField.text else {
            basicSubject.onNext("")
            return true
        }
        basicSubject.onNext(text)

        return true
    }
}
