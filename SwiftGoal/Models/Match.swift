//
//  Match.swift
//  SwiftGoal
//
//  Created by Martin Richter on 11/05/15.
//  Copyright (c) 2015 Martin Richter. All rights reserved.
//

import Argo
import Runes

struct Match {
    let identifier: String
    let homePlayers: [Player]
    let awayPlayers: [Player]
    let homeGoals: Int
    let awayGoals: Int
}

// MARK: Equatable

extension Match: Equatable {}

func ==(lhs: Match, rhs: Match) -> Bool {
    return lhs.identifier == rhs.identifier
}

// MARK: Decodable

extension Match: Decodable {
    static func create(identifier: String)(homePlayers: [Player])(awayPlayers: [Player])(homeGoals: Int)(awayGoals: Int) -> Match {
        return Match(
            identifier: identifier,
            homePlayers: homePlayers,
            awayPlayers: awayPlayers,
            homeGoals: homeGoals,
            awayGoals: awayGoals
        )
    }

    static func decode(json: JSON) -> Decoded<Match> {
        return Match.create
            <^> json <| "id"
            <*> json <|| "home_players"
            <*> json <|| "away_players"
            <*> json <| "home_goals"
            <*> json <| "away_goals"
    }
}