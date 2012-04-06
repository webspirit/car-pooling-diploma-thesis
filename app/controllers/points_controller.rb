class PointsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /points
  # GET /points.json
  def index
    @points = Point.where(:user_id => current_user.id)

    # if @points.offer == true
      # @status = false
    # else
      # @status = true
    # end
            
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
    @tmp = @point.dup
    
    respond_to do |format|
      if @point.update_attributes(params[:point])
        
      if @tmp.fellow_id
        route = @tmp
        tmp_point = Point.find(@tmp.fellow_id)
        user = tmp_point.user
        UserMailer.deleted_route(user, route).deliver
      end
        
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
    
    if @point.fellow_id
      route = @point
      tmp_point = Point.find(@point.fellow_id)
      user = tmp_point.user
      UserMailer.deleted_route(user, route).deliver
    end
    
    @point.destroy
    
    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end
  
  # GET /points/match
  # GET /points/match.json
  def match
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
  
  def claim
    @search_point = Point.find(params[:id])
    @fellow_point = Point.find(params[:fellow])
    
    if @fellow_point.fellow_id == nil 
      @fellow_point.fellow_id = params[:id]
      @search_point.active = false
      @search_point.fellow_id = params[:fellow]
      @fellow_point.active = false
    end
        
    respond_to do |format|
      if @search_point.save && @fellow_point.save
        
        claimed_user = @search_point.user
        route_user   = @fellow_point.user
        UserMailer.claimed_route(claimed_user, route_user).deliver
        
        format.html { redirect_to @search_point, notice: "Route successfully claimed." }
        #format.json { render json: @point, status: :created, location: @point }
      else
        format.html { render action: "new" }
        #format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
