

class AiPlayer

    attr_reader :name
    attr_accessor :losses

    def initialize(name)

        @name = name
        @losses = 0
    end


    def guess(fragment, fragment_length, number_of_current_players, possible_words)

        if fragment_length > 0
            alpha = 'abcdefghijklmnopqrstuvwxyz'
            
            alpha.each_char do |letter|
                potentials = possible_words.select { |word| word.start_with?("#{fragment}#{letter}") }

                if potentials.length > 0

                    if potentials.all? { |potential| (potential.length - (fragment.length + 1) ) % number_of_current_players != 0 && potential.length != "#{fragment}#{letter}".length }
                    input = letter

                    return input
                    end

                end

            end
        end


        if fragment_length > 0 && possible_words.any? { |possible| possible.length < fragment_length + 1+ number_of_current_players}

            winners = possible_words.select { |possible| possible.length < fragment_length + 1 + number_of_current_players && ( (possible.length - fragment.length + 1) % number_of_current_players != 0  ) }
            
            possible_letters = winners.map { |possible_word| possible_word[fragment_length]}

            possible_winning_letters = possible_letters.select { |letter| !possible_words.include?("#{fragment}#{letter}") }

            if possible_winning_letters.length > 0
   
                random_winning_move = possible_winning_letters.sample
                input = random_winning_move
            else
         
                random_move = possible_words.sample[fragment_length]
                input = random_move
            end
        
        else
       
            random_move = possible_words.sample[fragment_length]
            input = random_move
        end

        input


    end


end







































# def guess(fragment, fragment_length, number_of_current_players, possible_words)

#     puts 'getting guess'
    
#     alpha = 'abcdefghijklmnopqrstuvwxyz'

#     letters = []


#     alpha.each do |letter|
#         potentials = possible_words.select { |word| word.start_with?("#{fragment}#{letter}") && word != "#{fragment}#{letter}" }

#         if potentials.all? { |choice| choice.length < (fragment_length + number_of_current_players)}
#             letters << letter
#         end

#     end

#     if letters.length > 0
#         puts "force_win"
#         input = letters.sample

#     elsif possible_words.any? { |possible| possible.length < fragment_length + number_of_current_players }

#         winners = possible_words.select { |possible| possible.length < fragment_length + 1 + number_of_current_players }
        
#         letters = winners.map { |possible_word| possible_word[fragment_length]}

#         if possible_words.length < 10
#             print possible_words
#         end

#         possible_winning_letters = possible_letters.select { |letter| !possible_words.include?("#{fragment}#{letter}") }

#         if possible_winning_letters.length > 0
#             print possible_winning_letters
#             print 'random winning move'
#             random_winning_move = possible_winning_letters.sample
#             input = random_winning_move
#         else
#             print 'random losing move'
#             random_losing_move = possible_letters.sample
#             input = random_losing_move
#         end
    
#     else
#         print 'random move'
#         random_move = possible_words.sample[fragment_length]
#         input = random_move
#     end

# input


# end
