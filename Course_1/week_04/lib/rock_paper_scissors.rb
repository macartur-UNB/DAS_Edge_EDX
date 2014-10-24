class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)

    if player1[1] ~= "[^SRP]" or player1[1] != "R" or player1[1] != "P" or
       player2[1] != "S" or player2[1] != "R" or player2[1] != "P" or
        raise RockPaperScissors::NoSuchStrategyError   
    end


    if  player1[1] == "S" and player2[1] == "P" or 
        player1[1] == "P" and player2[1] == "R" or
        player1[1] == 'R' and player2[1] == "S" or
        player1[1] == player2[1]
        return player1
    else
        return player2

    end
  end

  def self.tournament_winner(tournament)
    
  end

end
