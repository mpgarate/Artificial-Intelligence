# state = State.new([1][-3,4])
# state.clauses => [1][-3,4]

class State
  attr_accessor :clauses, :pure_literal, :singleton_clause

  @clauses = []

  # clauses.class => Array
  def initialize(clauses)
      @clauses = clauses
      puts "made state with #{@clauses}"
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
      @pure_literal = literals.first
      return true
    else
      @pure_literal = nil
      return false
    end
  end

  def has_singleton_clause?
    @clauses.each do |clause|
      if clause.is_singleton? then
        @singleton_clause = clause
        return true
      end
    end
  end

  def has_empty_clause?
    @clauses.each do |clause|
      return true if clause.contains? nil
    end
    return false
  end

  def delete_every(literal)
    @clauses.each do |clause|
      if clause.contains? literal then
        @clauses.delete(clause)
      end
    end
  end

  def propagate(literal, s, v)
    @clauses.each do |clause|
      if clause.contains? literal
        @clauses.delete(clause)
      elsif clause.contains? literal.negate
        clause.delete(literal.negate)
      end
    end
  end
end
