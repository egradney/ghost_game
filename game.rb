require_relative "player"
require_relative "dictionary"

class Game

    def initialize(player_1, player_2)

        @players = [Player.new(player_1), Player.new(player_2)]
        @fragment = ''
        @current_player = @players[0]
        @previous_player = @players[1]
        @dictionary = ['cormorant', 'stuck']

    end

    def take_turn

        frag_add = @current_player.guess
        
        if self.valid_play?(frag_add)
            @fragment += frag_add
            puts "\n new fragment is: #{@fragment}"
            if !self.lose?(@fragment)
                self.switch_player
            end
        else
            print "\n please enter a valid addition"
            print "\n current fragment is: #{@fragment}"
            self.take_turn
        end

        @fragment
    end

    def switch_player

        if @current_player == @players[0]
            @current_player = @players[1]
            @previous_player = @players[0]
        else
            @current_player = @players[0]
            @previous_player = @players[1]
        end
    end

    def lose?(frag)

        if @dictionary.any? { |word| word == frag }
            return true
        end
         false
    end

    def valid_play?(string)

        ('a'...'z').include?(string) && @dictionary.any? { |word| word.start_with?(@fragment + string) }

    end


    def play_round

        if self.lose?(self.take_turn)
            print "\n #{@current_player.name} has lost the game!\n game over"
    
            return nil
        
        else
            self.play_round
        end


    end

end

Game.new('will', 'jess').play_round