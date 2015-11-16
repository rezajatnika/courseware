require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = users(:lecturer).courses.new(
      name: 'Introduction to Unit Testing',
      code: 'ut-101'
    )
  end

  test 'should respond to corresponding attributes' do
    ['name', 'code', 'lecturer_id', 'slug'].each do |attr|
      assert Course.attribute_names.include? attr
    end
  end

  test 'should valid' do
    assert @course.valid?
  end

  test 'should not valid without name' do
    @course.name = ''
    assert_not @course.valid?
  end

  test 'should not valid without code' do
    @course.code = ''
    assert_not @course.valid?
  end

  test 'should not valid without lecturer' do
    @course.lecturer = nil
    assert_not @course.valid?
  end

  test 'should generate slug before validation' do
    @course.save
    assert_equal 'introduction-to-unit-testing', @course.slug
  end

  test 'should belongs to lecturer' do
    assert_equal users(:lecturer), @course.lecturer
  end

  test 'should have many students and feeds' do
    [:students, :feeds, :enrollments].each do |attr|
      assert @course.respond_to?(attr)
    end
  end

  test 'should encode course' do
    @course.save
    assert_equal Base64.urlsafe_encode64(@course.slug), @course.encode_course
  end
end
