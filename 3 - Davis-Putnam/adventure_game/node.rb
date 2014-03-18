class Node
  attr_accessor :name, :tolls, :treasures, :next_nodes

  def initialize(line)
    parse_attributes(line)
  end

  def parse_attributes(line)
    attrs = line.split

    # 0 is name
    @name = attrs[0]

    # 1 is label "TREASURES"
    # 2 is a treasure name or label "TOLLS"
    @treasures = []
    i = 2
    while(attrs[i] != "TOLLS" && i < attrs.length)
      @treasures << attrs[i]
      i = i + 1
    end

    # skip over "TOLLS" label
    i = i + 1

    # next attributes are tolls
    @tolls = []
    while(attrs[i] != "NEXT" && i < attrs.length)
      @tolls << attrs[i]
      i = i + 1
    end

    # skip over "NEXT" label
    i = i + 1

    # final attributes are possible next nodes
    @next_nodes = []
    while(attrs[i] != "\n" && i < attrs.length)
      @next_nodes << attrs[i]
      i = i + 1
    end

  end
end
