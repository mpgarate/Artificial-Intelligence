# state = State.new([1][-3,4])
# state.clauses => [1][-3,4]

class State
  attr_accessor :clauses, :pure_literal, :singleton_clause

  @clauses = []

  # clauses.class => Array
  def initialize(clauses)
      @clauses = clauses
  end

  def is_empty?
    if @clauses.size == 0
      return true
    else
      return false
    end
  end

  def has_pure_literal?
    literals = Hash.new
    @clauses.each do |clause|
      clause.literals.each do |literal|
        if literals.has_key? literal.name
          if literals[literal.name] != literal.value
            literals.delete(literal.name)
          end
        else
          literals[literal.name] =  literal.value
        end
      end
    end

    if literals.length > 1
      str = literals.first[0] 
      if literals.first[1] == false
        str = "-#{str}" 
      end

      @pure_literal = Literal.new(str)
      return true
    else
      @pure_literal = nil
      return false
    end
  end

  def has_singleton_clause?
    @clauses.each do |clause|
      if clause.is_singleton? then
        puts "setting singleton_clause: #{clause}"
        @singleton_clause = clause
        return true
      end
    end
    return false
  end

  def has_empty_clause?
    @clauses.each do |clause|
      return true if clause.contains? nil
    end
    return false
  end

  def has_any_literal?(literal)
    @clauses.each do |clause|
      return true if clause.contains? literal
    end
    return false
  end

  def has_no_literal?(literal)
    return !has_any_literal?(literal)
  end

  def delete_every(literal)
    clauses_to_delete = []

    @clauses.each do |clause|
      if clause.contains? literal then
        clauses_to_delete << clause
      end
    end

    clauses_to_delete.each do |c|
      @clauses.delete(c)
    end

    puts "deleted every #{literal} from #{@clauses}"
  end

  def propagate(literal)
    clauses_to_delete = []

    @clauses.each do |clause|
      if clause.contains? literal
        clauses_to_delete << clause
      elsif clause.contains? literal.negate
        clause.delete(literal.negate)
      end
    end

    puts "About to delete:"
    puts "#{clauses_to_delete}"
    clauses_to_delete.each do |c|
      puts "DELETING #{c}"
      @clauses.delete(c)
      puts @clauses
    end

    return self
  end
end
