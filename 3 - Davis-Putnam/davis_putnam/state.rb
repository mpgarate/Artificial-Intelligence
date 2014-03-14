# state = State.new([1][-3,4])
# state.clauses => [1][-3,4]

class State
  attr_accessor :clauses

  def initialize(clauses)
      @clauses = clauses
  end

  def has_empty_clause?
    @clauses.each do |clause|
      return true if clause == nil
    end
    return false
  end
end