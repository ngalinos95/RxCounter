//
//  CounterViewController.swift
//  Rx Counter
//
//  Created by Nikos Galinos,   on 4/9/23.
//

import UIKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var increaseLabel: UIButton!
    @IBOutlet weak var decreaseLabel: UIButton!
    @IBOutlet weak var resetLabel: UIButton!

    private let viewModel = CounterViewModel()
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.layer.cornerRadius = 12
        increaseLabel.layer.cornerRadius = 12
        decreaseLabel.layer.cornerRadius = 12
        resetLabel.layer.cornerRadius = 12
        setupBindings()
    }

    private func setupBindings() {
        // Bind counter value to label
        // we use drive operator because the counter emits values
        viewModel.outputs.counter
            .drive(counterLabel.rx.text)
            .disposed(by: disposeBag)

        // Bind increase action to increase button
        increaseLabel.rx.tap
            .bind(to: viewModel.inputs.increase)
            .disposed(by: disposeBag)


        // Bind decrease action to decrease button
        decreaseLabel.rx.tap
            .bind(to: viewModel.inputs.decrease)
            .disposed(by: disposeBag)

        // Bind reset action to reset button
        resetLabel.rx.tap
            .bind(to: viewModel.inputs.reset)
            .disposed(by: disposeBag)
    }
}
