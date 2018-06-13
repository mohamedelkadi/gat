# frozen_string_literal: true

module V1
  module Private
    class PrivateBaseController < ApplicationController
      before_action :authenticate!
    end
  end
end
