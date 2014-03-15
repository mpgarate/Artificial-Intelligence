require_relative 'davis_putnam'
require 'test/unit'
require 'fileutils'

class TestDP < Test::Unit::TestCase
  def test_clause_contains_1
    clause = Clause.new("1 -2 3")
    assert clause.contains? "1"
  end

  def test_clause_contains_2
    clause = Clause.new("1 -2 3")
    assert clause.contains? "-2"
  end

  def test_clause_contains_3
    clause = Clause.new("1 -2 3")
    assert clause.contains? "3"
  end

  def test_clause_contains_nil
    clause = Clause.new("1 -2 3")
    assert clause.contains?(nil) == false
  end

  def test_clause_singleton_t
    clause = Clause.new("1")
    assert clause.is_singleton?
  end

  def test_clause_singleton_f
    clause = Clause.new("1 3")
    assert clause.is_singleton? == false
  end

  def test_clause_delete
    clause = Clause.new("1 -2 3")
    literal = Literal.new("-2")
    clause.delete(literal)
    assert clause.contains?("-2") == false
  end

  def test_clause_delete_last_becomes_nil
    clause = Clause.new("3")
    literal = Literal.new("3")
    clause.delete(literal)
    assert clause.contains? nil
  end

  def test_state_delete_every
    clauses = []
    clauses << Clause.new("1 2 3")
    clauses << Clause.new("1 -2 -3")
    clauses << Clause.new("-2 -3 -4")
    clauses << Clause.new("-1 -2 3")
    clauses << Clause.new("5 6")
    clauses << Clause.new("5 -6")
    clauses << Clause.new("2 -5")
    clauses << Clause.new("-3 -5")
    state = State.new(clauses)

    literal = Literal.new("-4")

    puts "STATE: #{state.clauses}"
    puts "DELETING #{literal}"
    state.delete_every literal
    puts "STATE: #{state.clauses}"

    assert state.has_no_literal? literal
  end
end