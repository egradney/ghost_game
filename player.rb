
class Player

    attr_reader :name

    def initialize(name)

        @name = name
        @ghost = ''

    end

    def guess
        print "\n #{@name} please enter your addition to the fragment\n"
        input = gets.chomp
        input
    end


end