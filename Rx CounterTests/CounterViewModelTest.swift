//
//  CounterViewModelTest.swift
//  Rx CounterTests
//
//  Created by Nikos Galinos,   on 5/9/23.
//

import XCTest
import RxSwift
import RxTest
@testable import Rx_Counter

 class CounterViewModelTest: XCTestCase {
    //Test the CounterViewModel with RxTest
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var viewModel: CounterViewModel!
    // SetUp the test
    override func setUp() {
        super.setUp()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        // Given
        self.viewModel = CounterViewModel()

    }
    // Clear the test
    override func tearDown()  {
        super.tearDown()
        self.scheduler = nil
        self.disposeBag = nil
        self.viewModel = nil
    }
    // Test Increase Action
    func testIncreaseAction() {
        // Given
        let increaseTrigger = scheduler.createHotObservable([.next(100, ())])
        let counterObserver = scheduler.createObserver(String.self)

        // When
        increaseTrigger.bind(to: viewModel.inputs.increase).disposed(by: disposeBag)
        viewModel.outputs.counter.drive(counterObserver).disposed(by: disposeBag)

        // Start the test scheduler
        scheduler.start()

        // Then
        XCTAssertEqual(counterObserver.events, [
            .next(0, "0"), // Initial value
            .next(100, "1"), // After increase
        ])
    }

    // Test Decrease Action
    func testDecreaseAction() {
        // Given
        let decreaseTrigger = scheduler.createHotObservable([.next(100, ())])
        let counterObserver = scheduler.createObserver(String.self)

        // When
        decreaseTrigger.bind(to: viewModel.inputs.decrease).disposed(by: disposeBag)
        viewModel.outputs.counter.drive(counterObserver).disposed(by: disposeBag)

        // Start the test scheduler
        scheduler.start()

        // Then
        XCTAssertEqual(counterObserver.events, [
            .next(0, "0"), // Initial value
            .next(100, "-1"), // After decrease
        ])
    }

    // Test Reset Action
    func testResetAction() {
        // Given
        let resetTrigger = scheduler.createHotObservable([.next(100, ())])
        let counterObserver = scheduler.createObserver(String.self)

        // When
        resetTrigger.bind(to: viewModel.inputs.reset).disposed(by: disposeBag)
        viewModel.outputs.counter.drive(counterObserver).disposed(by: disposeBag)

        // Start the test scheduler
        scheduler.start()

        // Then
        XCTAssertEqual(counterObserver.events, [
            .next(0, "0"), // Initial value
            .next(100, "0"), // After reset
        ])
    }
}
