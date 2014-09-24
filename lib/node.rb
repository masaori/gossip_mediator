module GossipMediator

    class Node
        def initialize(opinion_type, selector_type, universal_list)
            @opinion = Object.const_get(opinion_type).new
            @selector = Object.const_get(selector_type).new
            @selector.set_universal(universal_list)
        end

        def mediate
            target_list = @selector.generate_list

            target_list.each do |e|
                @opinion.mediate(e.opinion)
            end

            return target_list
        end

        def opinion
            @opinion
        end
    end

end