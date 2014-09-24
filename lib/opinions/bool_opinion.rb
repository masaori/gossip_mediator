include GossipMediator

class BoolOpinion < Opinion
    def initialize
        @value = rand(10) > 2 ? true : false
    end

    def mediate(another)
        ret = rand(2) == 0 ? @value : another.value
        @value = ret
        another.value = ret
    end
end