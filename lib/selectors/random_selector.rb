include GossipMediator

class RandomSelector < Selector
    def generate_list

        ret = []
        LIST_COUNT.times { ret << @universal_list[rand(@universal_list.count)] }

        return ret
    end    
end