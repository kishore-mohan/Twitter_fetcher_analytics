class RetailersController < ApplicationController
  def index
    redirect_to Retailer.sorted_by_name.first
  end

  def show
    @retailer = Retailer.sorted_by_name.detect{|a| [a.id.to_s, a.name].include?(params[:id].to_s) }
  end
end
