# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
  describe 'Post #create' do
    it 'saves to the database' do
      expect do
        post :create, params: {
          user: {
            email: Faker::Internet.email,
            password: 'password',
            password_confirmation: 'password',
            profile_attributes: attributes_for(:profile)
          }
        }
      end.to change(User, :count).by(1)
      # expect(User.last.profile).to_not eq(nil)
    end

    context 'successful signup' do
      before :each do
        parameters = { params: { user: attributes_for(:user, profile_attributes: attributes_for(:profile)) } }
        post :create, parameters
        @user = User.last
      end

      it "redirects to the new user's page" do
        expect(response).to redirect_to(edit_profile_path(@user.profile))
      end
    end
  end
end
