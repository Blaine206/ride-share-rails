class DriversController < ApplicationController
  def index
    #give us all drivers
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id].to_i
    @drivers = Driver.find_by(id:driver_id)

    if @drivers.nil?
      head :not_found # would a redirect be better here? Does it matter? It it my decision?
      return
    end
  end

  def new
    @drivers = Driver.new
  end

  def create
    # driver_params_results = driver_params
    # driver_params_results[:available] = true
    # @driver = Driver.new(driver_params_results
    @drivers = Driver.new(name: params[:driver][:name], vin: params[:driver][:vin])
    if @drivers.save
      redirect_to drivers_path(@driver.id)
      return
    else
      render :new
      return
    end

  def edit
    @drivers = Driver.find_by(id:params[:id])

    if @drivers.nil?
      redirect_to driver_path(@drivers.id) #Vs. Head :not_found
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found #redirect_to driver_path(@driver.id) # vs Head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to new_driver_path(@driver.id)
      return
    else
      render :edit
      return
      end
  end

  def create
    driver_params_results = driver_params
    driver_params_results[:available] = true

    @drivers = Driver.new(driver_params_results)
    if @drivers.save
      redirect_to driver_path(@driver.id)
      return
    else
      render :new
      return
    end
  end

  def destroy

  end

  private
  # params = {id: 1, driver: {name: "hello world", author: becca}}
  #
  # params[:id]
  # params[:driver][:name]
  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end

end

