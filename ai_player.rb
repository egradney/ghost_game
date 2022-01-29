

class AiPlayer

    attr_reader :name
    attr_accessor :losses

    def initialize(name)

        @name = name
        @losses = 0
    end

    def guess(fragment, fragment_length, number_of_current_players, possible_words)
    # def guess(fragment_length, number_of_current_players, *possible_words)
        # if fragment_length > 0
       
        if possible_words.any? { |possible| possible.length < fragment_length + number_of_current_players }

            winners = possible_words.select { |possible| possible.length < fragment_length + 1 + number_of_current_players }
            possible_letters = winners.map { |possible_word| possible_word[fragment_length]}
            if possible_words.length < 10
                print possible_words
            end

            possible_winning_letters = possible_letters.select { |letter| !possible_words.include?("#{fragment}#{letter}") }

            if possible_winning_letters.length > 0
                puts possible_winning_letters
                puts 'random winning move'
                random_winning_move = possible_winning_letters.sample
                input = random_winning_move
            else
                puts 'random losing move'
                random_losing_move = possible_letters.sample
                input = random_losing_move
            end
            
        else
            puts 'random move'
            random_move = possible_words.sample[fragment_length]
            input = random_move
        end

    input 
         
    end



end