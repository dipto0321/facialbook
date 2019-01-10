# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #edit' do
    before :each do
      @user = create(:user)
      sign_in(@user)
      get :edit, params: { id: @user.id }
    end

    it 'assigns to @profile' do
      expect(assigns(:profile)).to eq(@user.profile)
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    before :each do
      @user = create(:user)
      @profile = @user.profile
      @bio = Faker::Lorem.sentence(3)
      sign_in(@user)

      parameters = { params: {
        id: @profile.id,
        profile: {
          user_id: @user.id,
          first_name: @profile.first_name,
          last_name: @profile.last_name,
          birthday: @profile.birthday,
          gender: @profile.gender,
          bio: @bio
        }
      } }

      patch :update, parameters
    end
    it "updates the user's profile in the database" do
      @profile.reload
      expect(@profile.bio).to eq(@bio)
    end
    it "redirects to user's page upon successful update" do
      expect(response).to redirect_to(@user)
    end
  end
end
