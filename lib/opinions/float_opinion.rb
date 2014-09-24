include GossipMediator

class FloatOpinion < Opinion
    def initialize
        @value = rand
    end

    def mediate(another)
        ret = (@value + another.value) / 2.0
        @value = ret
        another.value = ret
    end
end