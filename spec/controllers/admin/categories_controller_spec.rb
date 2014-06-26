require 'spec_helper'

describe Admin::CategoriesController do
  render_views

  before(:each) do
    Factory(:blog)
    #TODO Delete after removing fixtures
    Profile.delete_all
    henri = Factory(:user, :login => 'henri', :profile => Factory(:profile_admin, :label => Profile::ADMIN))
    request.session = { :user => henri.id }
  end

  it "test_index" do
    get :index
    assert_response :redirect, :action => 'index'
  end

  describe "test_new" do
    before(:each) do
      get :new
    end

    it 'should render template new' do
      assert_template 'new'
      assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
    end

    it 'should have a new category' do
      assigns(:category).should_not be_nil
      assigns(:categories).should_not be_nil
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  it 'test_create' do
    post :new, category: {
      name: "My Category", keywords: "keyword1 keyword2", description: "My new category"
    }
    assert_equal "My Category", Category.last.name
  end

  describe "test_edit" do
    before(:each) do
      get :edit, :id => Factory(:category).id
    end

    it 'should render template new' do
      assert_template 'new'
      assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
    end

    it 'should have valid category' do
      assigns(:category).should_not be_nil
      assert assigns(:category).valid?
      assigns(:categories).should_not be_nil
    end
  end

  it "test_update" do
    category = Factory(:category)
    old_name = category.name
    post :edit, id: category.id, category: category.attributes.merge(name: 'New name')
    assert_response :redirect, :action => 'index'
    new_category = Category.find(category.id)
    assert_equal 'New name', new_category.name
    assert_equal category.keywords, new_category.keywords
  end

  describe "test_destroy with GET" do
    before(:each) do
      test_id = Factory(:category).id
      assert_not_nil Category.find(test_id)
      get :destroy, :id => test_id
    end

    it 'should render destroy template' do
      assert_response :success
      assert_template 'destroy'      
    end
  end

  it "test_destroy with POST" do
    test_id = Factory(:category).id
    assert_not_nil Category.find(test_id)
    get :destroy, :id => test_id

    post :destroy, :id => test_id
    assert_response :redirect, :action => 'index'

    assert_raise(ActiveRecord::RecordNotFound) { Category.find(test_id) }
  end
  
end
