//
//  Extensions.swift
//  SwiftGoal
//
//  Created by Martin Richter on 23/06/15.
//  Copyright (c) 2015 Martin Richter. All rights reserved.
//

import UIKit
import ReactiveCocoa

extension UIStepper {
    func signalProducer() -> SignalProducer<Int, NoError> {
        return self.rac_newValueChannelWithNilValue(0).toSignalProducer()
            |> map { $0 as! Int }
            |> catch { _ in return SignalProducer<Int, NoError>.empty }
    }
}