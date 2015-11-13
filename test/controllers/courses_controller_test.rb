require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  def setup
    @course = courses(:tc101)
  end

  class NoLoggedInUser < CoursesControllerTest
    test 'should get index' do
      get :index
      assert_response 200
    end

    test 'should not get new' do
      get :new
      assert_response 302
      assert_redirected_to new_user_session_path
    end

    test 'should not get show' do
      get :show, { id: @course.slug }
      assert_response 302
      assert_redirected_to new_user_session_path
    end
  end

  class StudentLoggedIn < CoursesControllerTest
    def setup
      super
      UserSession.create(users(:student))
    end

    test 'should get show' do
      get :show, { id: @course.slug }
      assert_response 200
    end

    test 'should not get new' do
      get :new
      assert_response 302
      assert_redirected_to root_path
    end
  end

  class LecturerLoggedIn < CoursesControllerTest
    def setup
      super
      UserSession.create(users(:lecturer))
    end

    test 'should get new' do
      get :new
      assert_response 200
    end

    test 'should post course' do
      assert_difference('Course.count') do
        post :create,  course: { name: 'Dota 2 Basic', code: 'dt-101' }
      end

      course = assigns(:course)
      assert_redirected_to course
    end
  end
end
