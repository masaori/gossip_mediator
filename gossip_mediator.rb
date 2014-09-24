Dir[File.expand_path "./lib/**/*.rb"].each {|file| require file }

module GossipMediator
    @gossip_count=0
    ###
    ### constants
    ###
    NODE_COUNT=1000
    LIST_COUNT=300
    GOSSIP_LIMIT=50

    OPINION_TYPE=:FloatOpinion
    SELECTOR_TYPE=:RandomSelector

    def average
        return @node_list.inject(0) {|sum, n| sum + n.opinion.value } / @node_list.count
    end

    def diff_average
        avg = average
        return @node_list.inject(0) {|sum, n| sum + ((n.opinion.value - avg) / avg).abs } / @node_list.count
    end

    def mediate_and_gossip(node)
        @gossip_count += 1
        if @gossip_count > GOSSIP_LIMIT
            return
        end

        # if @gossip_count % 5 == 0
        #     puts "#{@gossip_count} :"
        #     @node_list.each {|n| puts "    node :::: #{n} :: #{n.opinion.value} :: #{(n.opinion.value - average) / average * 100}%"}    
        # end

        target_list = node.mediate
        target_list.each do |n|
            mediate_and_gossip(n)
        end
    end

    ###
    ###  main
    ###
    @node_list = []
    NODE_COUNT.times { @node_list << Node.new(OPINION_TYPE, SELECTOR_TYPE, @node_list) }

    puts "Before ::: #{@node_list.count}"
    puts diff_average

    # start mediate
    first_node = @node_list[0]
    mediate_and_gossip(first_node)

    puts "After ::: #{@node_list.count}"
    puts diff_average
end