//
//  MockStore.swift
//  SwiftGoal
//
//  Created by Martin Richter on 06/08/15.
//  Copyright (c) 2015 Martin Richter. All rights reserved.
//

import ReactiveCocoa
@testable import SwiftGoal

class MockStore: StoreType {
    let players: [Player]
    var matches: [Match]? // nil is used to cause error

    var didFetchMatches = false
    var deletedMatch: Match?

    init() {
        let player1 = Player(identifier: "player1", name: "C")
        let player2 = Player(identifier: "player2", name: "A")
        let player3 = Player(identifier: "player3", name: "D")
        let player4 = Player(identifier: "player4", name: "B")

        self.players = [player1, player2, player3, player4]
        self.matches = [
            Match(
                identifier: "1",
                homePlayers: [player1, player2],
                awayPlayers: [player3, player4],
                homeGoals: 2,
                awayGoals: 1
            ),
            Match(
                identifier: "2",
                homePlayers: [player1, player4],
                awayPlayers: [player2, player3],
                homeGoals: 0,
                awayGoals: 1
            )
        ]
    }

    func fetchMatches() -> SignalProducer<[Match], NSError> {
        didFetchMatches = true
        if let matches = self.matches {
            return SignalProducer(value: matches)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            return SignalProducer(error: error)
        }
    }

    func createMatch(parameters: MatchParameters) -> SignalProducer<Bool, NSError> {
        return SignalProducer(value: false)
    }

    func updateMatch(match: Match, parameters: MatchParameters) -> SignalProducer<Bool, NSError> {
        return SignalProducer(value: false)
    }

    func deleteMatch(match: Match) -> SignalProducer<Bool, NSError> {
        deletedMatch = match
        return SignalProducer(value: true)
    }

    func fetchPlayers() -> SignalProducer<[Player], NSError> {
        return SignalProducer(value: players)
    }

    func createPlayerWithName(name: String) -> SignalProducer<Bool, NSError> {
        return SignalProducer(value: false)
    }

    func fetchRankings() -> SignalProducer<[Ranking], NSError> {
        // TODO: Write tests for RankingViewModel that use this
        return SignalProducer(value: [])
    }
}
