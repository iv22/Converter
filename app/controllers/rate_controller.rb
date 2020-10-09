class RateController < ApplicationController
  def index
  end

  def load
    Rate.load
  end
end
