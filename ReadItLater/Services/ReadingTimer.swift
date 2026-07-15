//
//  ReadingTimer.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation
import Observation

@Observable
final class ReadingTimer {

    private var startDate: Date?

    private var accumulatedTime: TimeInterval = 0

    private(set) var currentSessionTime: TimeInterval = 0

    private var timer: Timer?


    func beginSession() {

        guard startDate == nil else {
            return
        }

        accumulatedTime = 0
        currentSessionTime = 0

        startDate = Date()

        startInternalTimer()

    }


    private func startInternalTimer() {

        timer?.invalidate()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in

            guard let self,
                  let startDate = self.startDate else {
                return
            }

            self.currentSessionTime =
                self.accumulatedTime +
                Date().timeIntervalSince(startDate)

        }

    }


    func pause() {

        guard let startDate else {
            return
        }

        accumulatedTime += Date().timeIntervalSince(startDate)

        currentSessionTime = accumulatedTime

        self.startDate = nil

        timer?.invalidate()

        timer = nil

    }


    func resume() {

        guard timer == nil else {
            return
        }

        startDate = Date()

        startInternalTimer()

    }


    func stop() -> TimeInterval {

        pause()

        let elapsed = accumulatedTime

        accumulatedTime = 0
        currentSessionTime = 0

        return elapsed

    }


    deinit {

        timer?.invalidate()

    }

}
