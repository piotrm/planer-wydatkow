class IncomesController < ApplicationController
  # GET /incomes
  # GET /incomes.json
  def index
    @incomes = Income.find_all_by_user_id(current_user.id)
    @incomes_json = @incomes.to_gmaps4rails do |income, marker|
      marker.infowindow render_to_string(partial: "/incomes/infowindow", locals: { income: income })
      marker.title "Wydatek"
      marker.json({ amount: income.amount, date: income.date })
      # marker.picture({
      #   :picture => "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-3875d7/shapecolor-color/shadow-1/border-dark/symbolstyle-contrast/symbolshad     owstyle-dark/gradient-iphone/information.png",
      #   :width => 32,
      #   :height => 32})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incomes }
    end
  end

  # GET /incomes/1
  # GET /incomes/1.json
  def show
    @income = Income.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @income }
    end
  end

  # GET /incomes/new
  # GET /incomes/new.json
  def new
    @income = Income.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @income }
    end
  end

  # GET /incomes/1/edit
  def edit
    @income = Income.find(params[:id])
  end

  # POST /incomes
  # POST /incomes.json
  def create
    date = if params[:income][:date] == ""
      Date.today
    else
      Date.strptime(params[:income][:date],'%m/%d/%Y')
    end

    @income = Income.new(
      amount: process_amount(params[:income][:amount]),
      longitude: params[:income][:longitude],
      latitude: params[:income][:latitude],
      description: params[:income][:description],
      date: date,
      user_id: current_user.id
    )

    respond_to do |format|
      if @income.save
        format.html { redirect_to incomes_path, notice: 'Income was successfully created.' }
        format.json { render json: @income, status: :created, location: @income }
      else
        format.html { render action: "new" }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /incomes/1
  # PUT /incomes/1.json
  def update
    @income = Income.find(params[:id])

    respond_to do |format|
      if @income.update_attributes(params[:income])
        format.html { redirect_to @income, notice: 'Income was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy
    @income = Income.find(params[:id])
    @income.destroy

    respond_to do |format|
      format.html { redirect_to incomes_url }
      format.json { head :no_content }
    end
  end

  private

  def process_amount(amount)
    ((amount.gsub(",",".").to_f*100)/100)*100
  end
end