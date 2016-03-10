require 'rails_helper'

RSpec.describe StudentsController do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET student' do
    before(:each) do
      @johnny = Student.create(first_name: 'Johnny')
    end

    it 'renders student page' do
      get :show, id: @johnny.id

      expect(response).to render_template('show')
      # expect(response.body).to include('Johnny') # what is going on here!!!
    end
  end

  describe 'Post and show index' do
    it 'posts to student and renders the show page' do
      post :create, {student: {first_name: 'Johnny B. Good'}}

      expect(response).to have_http_status(302)
    end
  end

end
