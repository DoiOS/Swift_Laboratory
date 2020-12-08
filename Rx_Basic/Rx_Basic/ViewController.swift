//
//  ViewController.swift
//  Rx_Basic
//
//  Created by Sungmin on 2020/12/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 네이밍을 아무리 막 지었다고하지만 아래 두개는 심한듯.. 죄송..ㅎ
    @IBAction func didTapBaseObservableCode(_ sender: Any) {
        let viewController = ObservableTestViewController()
        present(viewController, animated: true)
    }

    @IBAction func didTapBaseSubjectCode(_ sender: Any) {
        let viewController = SubjectTestViewController()
        present(viewController, animated: true)
    }

}

