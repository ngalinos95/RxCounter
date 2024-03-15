//
//  CounterViewModel.swift
//  Rx Counter
//
//  Created by Nikos Galinos,   on 4/9/23.
//

import Foundation
import RxSwift
import RxCocoa


class CounterViewModel {
    // Create the Model for our Input
    struct CounterViewModelInputs {
        let increase: PublishRelay<Void>
        let decrease: PublishRelay<Void>
        let reset: PublishRelay<Void>
    }
    // Create the Model for our Output

    struct CounterViewModelOutputs {
        let counter: Driver<String>
    }
    let inputs: CounterViewModelInputs
    let outputs: CounterViewModelOutputs

    private let disposeBag = DisposeBag()

    init() {
        let increaseSubject = PublishRelay<Void>()
        let decreaseSubject = PublishRelay<Void>()
        let resetSubject = PublishRelay<Void>()
        let counter = BehaviorRelay<Int>(value: 0)

        // Bind input actions to counter value
        increaseSubject
            .subscribe(onNext: { _ in
                let currentValue = counter.value
                counter.accept(currentValue + 1)
            })
            .disposed(by: disposeBag)

        decreaseSubject
            .subscribe(onNext: { _ in
                let currentValue = counter.value
                counter.accept(currentValue - 1)
            })
            .disposed(by: disposeBag)

        resetSubject
            .subscribe(onNext: { _ in
                counter.accept(0)
            })
            .disposed(by: disposeBag)

        self.inputs = CounterViewModelInputs(
            increase: increaseSubject,
            decrease: decreaseSubject,
            reset: resetSubject
        )

        // Transform the counter BehaviorRelay into a Driver
        self.outputs = CounterViewModelOutputs(
            counter: counter.asDriver()
                .map { String($0) }
        )
    }
}
