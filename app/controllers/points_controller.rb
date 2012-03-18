class PointsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /points
  # GET /points.json
  def index
    @points = Point.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
    @point = Point.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: @point }
    end
  end

  # GET /points/new
  # GET /points/new.json
  def new
    @point = Point.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/1/edit
  def edit
    @point = Point.find(params[:id])
  end
  
  # POST /points
  # POST /points.json
  def create
    @point = Point.new(params[:point])
    #@point = Point.where(:departure_lat => params[:departure_lat])
    @point.user_id = current_user.id
    @point.active = true
    
    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render json: @point, status: :created, location: @point }
      else
        format.html { render action: "new" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /points/1
  # PUT /points/1.json
  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end
  
  # GET /points/match
  # GET /points/match.json
  def match
     
    #) && Point.where(:offer => !offer)
    
    #@points = Point.where(:departure_lat => (dep_lat - (dep_range * 0.009))..(dep_lat + (dep_range * 0.009))) && Point.where(:departure_lng => (dep_lng - (dep_range * 0.008))..(dep_lng + (dep_range * 0.008))) && Point.where(:arrival_lat => (arr_lat - (arr_range * 0.009))..(arr_lat + (arr_range * 0.009))) && Point.where(:arrival_lng => (arr_lng - (arr_range * 0.008))..(arr_lng + (arr_range * 0.008))) && Point.where(:active => true) && Point.where(:offer => !offer)
 
    @current_point = Point.find(params[:id])
    
    @dep_lat = @current_point.departure_lat 
    @dep_lng = @current_point.departure_lng
    @dep_lat_range = @current_point.distance_departure_range * 0.009
    @dep_lng_range = @current_point.distance_departure_range * 0.008
    
    @arr_lat = @current_point.arrival_lat 
    @arr_lng = @current_point.arrival_lng
    @arr_lat_range = @current_point.distance_arrival_range * 0.009
    @arr_lng_range = @current_point.distance_arrival_range * 0.008
    
    @time_min = @current_point.time_range_from
    @time_max = @current_point.time_range_to
        
    if @current_point.offer == true
      @status = false
    else
      @status = true
    end
    
    #@usr_id != @current_point.user_id
    
    @points = Point.where(:departure_lat => @dep_lat - @dep_lat_range..@dep_lat + @dep_lat_range, 
                          :departure_lng => @dep_lng - @dep_lng_range..@dep_lng + @dep_lng_range, 
                          :arrival_lat => @arr_lat - @arr_lat_range..@arr_lat + @arr_lat_range, 
                          :arrival_lng => @arr_lng - @arr_lng_range..@arr_lng + @arr_lng_range,
                          :start_time => @time_min..@time_max,
                          :active => true,
                          :offer => @status).limit(20).all
 
    
    respond_to do |format|
      format.html 
      format.json { render json: @points }
    end
    
  end
  
end
