//
//  ObservableTestViewController.swift
//  Rx_Basic
//
//  Created by Sungmin on 2020/12/06.
//

import RxSwift

class ObservableTestViewController: UIViewController {

    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var progressBarRightMargin: NSLayoutConstraint!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBarRightMargin.constant = view.bounds.width
        // Do any additional setup after loading the view.
    }

    // 옵저버블은.. 이런식으로 함수에서 반환할때 해주는게 좋은 것 같다!
    private func stringAfterDelay() -> Observable<String> {
        // ProgressBar Animation -> 그냥 심심해서 넣어봄
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 5,
                                                       delay: 0,
                                                       options: .curveEaseInOut) {
            self.progressBarRightMargin.constant = 0
            self.view.layoutIfNeeded()
        }

        return Observable.create { emitter in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                emitter.onNext("비동기로 만들어낸 문자열 입니다.")
                emitter.onCompleted()
            })
            return Disposables.create()
        }
    }

    @IBAction func didTapButton(_ sender: Any) {
        stringAfterDelay()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { text in
                self.textLabel.text = text
            })
            .disposed(by: disposeBag)
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
