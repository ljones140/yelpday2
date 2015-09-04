class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    user_authorised(@restaurant)
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.id != @restaurant.user_id
      redirect_to restaurants_path
      flash[:notice] = 'You cannae deltitta that capn - it isnt yours to do so'
    else
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to restaurants_path
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def user_authorised(restaurant)
    if current_user.id != restaurant.user_id
      redirect_to restaurants_path
      flash[:notice] = 'You cannae editta that capn - it isnt yours to do so'
    end
  end



end
