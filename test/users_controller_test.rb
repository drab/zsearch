require 'test_helper'

class UsersControllerTest < Minitest::Test

  def setup
    @users_controller = UsersController.new
  end

  def test_it_raises_an_error_when_search_field_is_invalid
    assert_raises FieldNotValid do
      @users_controller.search("i_m_not_a_field", "please_fail")
    end
  end

  def test_it_adds_basic_tickets_information_to_user_it_finds
    ZendeskService.stub(:new, ZendeskServiceStub.new) do
      users = @users_controller.search(:_id, 1)
      assert_equal 1, users.length
      user = users.first
      assert_equal "A Catastrophe in Korea (North) (pending)", user.ticket_0
      assert_equal "A Catastrophe in Hungary (closed)", user.ticket_1
    end
  end

end