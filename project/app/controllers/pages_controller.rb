class PagesController < ApplicationController
  def root
    render json: {status: 'OK'}
  end
end
