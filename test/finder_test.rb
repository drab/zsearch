require 'test_helper'

class FinderTest < Minitest::Test

  def setup
    @finder = Finder.new(ZendeskServiceStub.new.list_users, User)
  end

  def test_it_can_find_by_id
    user = @finder.find_by_id(2)
    assert_equal 2, user._id
  end

  def test_it_can_find_by_id_even_when_its_a_string
    user = @finder.find_by_id("2")
    assert_equal 2, user._id
  end

  def test_it_can_find_all_items_which_match_a_given_criteria
    users = @finder.find_all(:locale, "en-AU")
    assert_equal 2, users.length
    users.each { |u| assert_equal "en-AU", u.locale}
  end

  def test_it_can_find_the_first_which_matches_a_given_criteria
    user = @finder.find(:locale, "en-AU")
    assert_equal 1, user._id
    assert_equal "en-AU", user.locale
  end

end
