# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    session[:return_to] = request.referrer
  end
end
