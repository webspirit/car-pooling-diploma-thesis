class RoutesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.where(:user_id => current_user.id)

    # if @routes.offer == true
      # @status = false
    # else
      # @status = true
    # end
            
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @routes }
    end
  end

  # GET /routes/1
  # GET /routes/1.json
  def show      
    @route = Route.find(params[:id])
    
    respond_to do |format|
      format.html 
      format.json { render json: @route }
    end
  end

  # GET /routes/new
  # GET /routes/new.json
  def new
    @route = Route.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @route }
    end
  end

  # GET /routes/1/edit
  def edit
    @route = Route.find(params[:id])
  end
  
  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(params[:route])
    @route.user_id = current_user.id
    @route.active = true
    
    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render json: @route, status: :created, location: @route }
      else
        format.html { render action: "new" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /routes/1
  # PUT /routes/1.json
  def update
    @route = Route.find(params[:id])
    @tmp = @route.dup
    
    respond_to do |format|
      if @route.update_attributes(params[:route])
        
      if @tmp.fellow_id
        route = @tmp
        tmp_route = Route.find(@tmp.fellow_id)
        user = tmp_route.user
        UserMailer.deleted_route(user, route).deliver
      end
        
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route = Route.find(params[:id])   
    
    if @route.fellow_id
      route = @route
      tmp_route = Route.find(@route.fellow_id)
      user = tmp_route.user
      UserMailer.deleted_route(user, route).deliver
    end
    
    @route.destroy
    
    respond_to do |format|
      format.html { redirect_to routes_url }
      format.json { head :no_content }
    end
  end
  
  # GET /routes/match
  # GET /routes/match.json
  def match
    @current_route = Route.find(params[:id])
    
    @dep_lat = @current_route.departure_lat 
    @dep_lng = @current_route.departure_lng
    @dep_lat_range = @current_route.distance_departure_range * 0.009
    @dep_lng_range = @current_route.distance_departure_range * 0.008
    
    @arr_lat = @current_route.arrival_lat 
    @arr_lng = @current_route.arrival_lng
    @arr_lat_range = @current_route.distance_arrival_range * 0.009
    @arr_lng_range = @current_route.distance_arrival_range * 0.008
    
    @time_min = @current_route.time_range_from
    @time_max = @current_route.time_range_to

    @date = @current_route.date
        
    if @current_route.offer == true
      @status = false
    else
      @status = true
    end
    
    @routes = Route.find(:all, :conditions => 
    ["`routes`.`date` = ? AND 
      `routes`.`active` = 1 AND 
      `routes`.`offer` = ? AND 
      (`routes`.`departure_lat` BETWEEN ? AND ?) AND 
      (`routes`.`departure_lng` BETWEEN ? AND ?) AND 
      (`routes`.`arrival_lat` BETWEEN ? AND ?) AND 
      (`routes`.`arrival_lng` BETWEEN ? AND ?) AND 
      (   (`routes`.`time_range_to` BETWEEN ? AND ?) OR 
          (`routes`.`time_range_from` BETWEEN ? AND ?) OR
          (`routes`.`time_range_from` < ? AND `routes`.`time_range_to` > ?)    
      )",
      @date, 
      @status,
      @dep_lat - @dep_lat_range, @dep_lat + @dep_lat_range,
      @dep_lng - @dep_lng_range, @dep_lng + @dep_lng_range,
      @arr_lat - @arr_lat_range, @arr_lat + @arr_lat_range, 
      @arr_lng - @arr_lng_range, @arr_lng + @arr_lng_range,
      @time_min, @time_max, @time_min, @time_max, @time_min, @time_max]);
      
      
      # @routes = Route.find(:all, :conditions => 
    # ["`routes`.`date` = ? AND 
      # `routes`.`active` = 1 AND 
      # `routes`.`offer` = ? AND 
      # (`routes`.`departure_lat` BETWEEN ? AND ?) AND 
      # (`routes`.`departure_lng` BETWEEN ? AND ?) AND 
      # (`routes`.`arrival_lat` BETWEEN ? AND ?) AND 
      # (`routes`.`arrival_lng` BETWEEN ? AND ?) AND 
      # ((`routes`.`time_range_to` BETWEEN ? AND ?) OR (`routes`.`time_range_from` BETWEEN ? AND ?))",
      # @date, 
      # @status,
      # @dep_lat - @dep_lat_range, @dep_lat + @dep_lat_range,
      # @dep_lng - @dep_lng_range, @dep_lng + @dep_lng_range,
      # @arr_lat - @arr_lat_range, @arr_lat + @arr_lat_range, 
      # @arr_lng - @arr_lng_range, @arr_lng + @arr_lng_range,
      # @time_min, @time_max,@time_min, @time_max]);
            
     # @routes = Route.where(:departure_lat => @dep_lat - @dep_lat_range..@dep_lat + @dep_lat_range,
                          # :departure_lng => @dep_lng - @dep_lng_range..@dep_lng + @dep_lng_range,
                          # :arrival_lat => @arr_lat - @arr_lat_range..@arr_lat + @arr_lat_range, 
                          # :arrival_lng => @arr_lng - @arr_lng_range..@arr_lng + @arr_lng_range,
                          # :date => @date,
                          # :time_range_to => @time_min..@time_max,
                          # :active => true,
                          # :offer => @status).limit(20).all  
              
    respond_to do |format|
      format.html 
      format.json { render json: @routes }
    end
  end
  
  def claim
    @search_route = Route.find(params[:id])
    @fellow_route = Route.find(params[:fellow])
    
    if @fellow_route.fellow_id == nil 
      @fellow_route.fellow_id = params[:id]
      @search_route.active = false
      @search_route.fellow_id = params[:fellow]
      @fellow_route.active = false
    end
        
    respond_to do |format|
      if @search_route.save && @fellow_route.save
        
        claimed_user = @search_route.user
        route_user   = @fellow_route.user
        UserMailer.claimed_route(claimed_user, route_user).deliver
        
        format.html { redirect_to @search_route, notice: "Route successfully claimed." }
        #format.json { render json: @route, status: :created, location: @route }
      else
        format.html { render action: "new" }
        #format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
