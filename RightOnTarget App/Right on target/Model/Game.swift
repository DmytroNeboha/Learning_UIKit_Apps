
import UIKit



protocol GameProtocol {
    var score: Int {get}
    var currendRound: GameRoundProtocol! {get}
    var isGameEnded: Bool {get}
    var secretValueGenerator: GeneratorProtocol {get}
    
    func restartGame()
    func startNewRound()
}


class Game: GameProtocol {
    
    var currendRound: GameRoundProtocol!
    var secretValueGenerator: GeneratorProtocol
    private var rounds: [GameRoundProtocol] = []
    private var roundsCount: Int!
    
    var score: Int {
        var totalScore: Int = 0
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
    
    init(valueGenerator: GeneratorProtocol, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    

    func restartGame() {
        rounds = []
        startNewRound()
    }
    
    func startNewRound() {
        let newSecretValue = self.getNewSecretValue()
        currendRound = GameRound(secretValue: newSecretValue)
        rounds.append(currendRound)
    }
    
    private func getNewSecretValue() -> Int {
        return secretValueGenerator.getRandomValue()
    }
}
    
    
