
class Player

    attr_reader :name
    attr_accessor :losses

    def initialize(name)

        @name = name
        @losses = 0

    end

    def guess
        print "\n #{@name}, please enter your addition to the fragment\n"
        input = gets.chomp
        input
    end


end