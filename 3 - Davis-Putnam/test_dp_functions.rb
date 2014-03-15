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
  def test_clause_delete_last
    clause = Clause.new("3")
    literal = Literal.new("3")
    clause.delete(literal)
    assert clause.contains? nil
  end
end