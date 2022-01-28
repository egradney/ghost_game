

class AiPlayer

    attr_reader :name
    attr_accessor :losses

    def initialize(name)

        @name = name
        @losses = 0
    end

    def guess
        alpha = 'abcdefghijklmnopqrstuvwxyz'
        input = alpha[rand(26)]
         
    end



end