require_relative "player"
require_relative "ai_player"

class Game

    def initialize(players)

        @players = players.keys.map do |player_name| 
                        if players[player_name] == 'human'
                            Player.new(player_name) 
                        else
                            AiPlayer.new(player_name)
                        end
                    end


        
        @fragment = ''
        @current_player = @players[0]
        @previous_player = @players[1]
        @dictionary = File.readlines("dictionary.txt").map(&:chomp)
        @number_of_current_players = @players.length

    end

    def take_turn

        if @current_player.is_a? Player

            frag_add = @current_player.guess
            
            if self.valid_play?(frag_add)
                @fragment += frag_add
                puts "\n new fragment is: '#{@fragment}'"
                if !self.lose?(@fragment)
                    self.switch_player
                end
            else
                print "\n please enter a valid contribution"
                print "\n current fragment is: '#{@fragment}'"
                self.take_turn
            end

        else

            possible_words = @dictionary.select { |word| word.start_with?(@fragment) }
            fragment_length = @fragment.length
            frag_add = @current_player.guess(@fragment, fragment_length, @number_of_current_players, possible_words )
            
            if self.valid_play?(frag_add)

                @fragment += frag_add
                puts "\n #{@current_player.name}'s contribution is '#{frag_add}'"
                puts "\n new fragment is: '#{@fragment}'"
                if !self.lose?(@fragment)
                    self.switch_player
                end

            else
                self.take_turn
            end

        end

        @fragment
    end

    def switch_player

        i = @players.index(@current_player)

        if i == @players.length-1
            @current_player = @players[0]
        else
            @current_player = @players[i+1]
        end

        if @current_player.losses == 5
            self.switch_player
        end


    end

    def lose?(frag)

        if @dictionary.any? { |word| word == frag }
            return true
        end

        false
    end

    def valid_play?(string)

        ('a'..'z').include?(string) && @dictionary.any? { |word| word.start_with?(@fragment + string) }

    end

    def win?

        @players.one? { |player| player.losses < 5 }

    end


    def play_round


        if self.lose?(self.take_turn)
            print "\n Match found! #{@current_player.name} has lost the round!\n"
            @current_player.losses += 1

            case @current_player.losses

                when 1
                    puts '---------------------'
                    print "\n #{@current_player.name} has 'G'\n"
                    puts '---------------------'
                when 2
                    puts '---------------------'
                    print "\n #{@current_player.name} has 'GH'\n"
                    puts '---------------------'
                when 3
                    puts '---------------------'
                    print "\n #{@current_player.name} has 'GHO'\n"
                    puts '---------------------'
                when 4
                    puts '---------------------'
                    print "\n #{@current_player.name} has 'GHOS'\n"
                    puts '---------------------'
                when 5
                    puts '---------------------'
                    print "\n #{@current_player.name} has 'GHOST!' \n They're out!\n"
                    @number_of_current_players += -1
                    if self.win?
                        winner = @players.select { |player| player.losses < 5 }
                        print "\n#{winner[0].name} WINS!\n"
                        return nil
                    end

            end

            @fragment = ''
            self.switch_player
            self.play_round

        else
            self.play_round
        end

    end

    def run 

        self.play_round

    end


end

Game.new('Will' => 'human', 'Jess'=> 'human', 'Tammy' => 'ai').run



# possible_words = @dictionary.select { |word| word.start_with?(@fragment) }
# fragment_length = @fragment.length


# # attempt to find moves that will force opponents to complete a word
# # by finding words that can be completed before AiPlayer's next turn
# if possible_words.any? { |possible| possible.length < fragment_length + @number_of_current_players }
#     winners = possible_words.select { |possible| possible.length < @fragment.length + 1 + @number_of_current_players }
#     possible_letters = winners.map { |possible_word| possible_word[fragment_length]}
#     random_winning_move = possible_letters.sample
#     frag_add = random_winning_move
# else

#     frag_add = @current_player.guess


#         if self.valid_play?(frag_add)


#             @fragment += frag_add
#             puts "\n #{@current_player.name}'s contribution is '#{frag_add}'"
#             puts "\n new fragment is: '#{@fragment}'"
#             if !self.lose?(@fragment)
#                 self.switch_player
#             end

#         else
#             self.take_turn
#         end

#     end

# end