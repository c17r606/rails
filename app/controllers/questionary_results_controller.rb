class QuestionaryResultsController < ApplicationController
  before_action :set_questionary_result, only: [:show, :edit, :update, :destroy]


  def index
    @questionaries = Questionary.all
  end

  def show
    @questionary = Questionary.find params[:id]
    @questionary_results = QuestionaryResult.where('questionary_id = ?',params[:id])
  end

  def new
    @questionary_result = QuestionaryResult.new
  end

  def edit
  end


  def create
    @questionary_result = QuestionaryResult.new(questionary_result_params)

    respond_to do |format|
      if @questionary_result.save
        format.html { redirect_to @questionary_result, notice: 'Questionary result was successfully created.' }
        format.json { render :show, status: :created, location: @questionary_result }
      else
        format.html { render :new }
        format.json { render json: @questionary_result.errors, status: :unprocessable_entity }
      end
    end
  end

  def calc 
    @questionary = Questionary.find params[:id]
    results = QuestionaryResult.where('questionary_id= ?',params[:id])
    @calc = {}
    results.each do |result|
      data = result.result.split ','
      data.each do |value|
        keyval = value.split ':'
        ky = keyval[0].to_s
        vl = keyval[1].to_i
        if ky != 'question_id' then
          if @calc[ky] == nil then
            @calc[ky] = []
          end
          @calc[ky] [vl] = @calc[ky][vl] == nil ? 1 :
          @calc[ky][vl].to_i + 1
        end
      end
    end
  end
 
  def update
    respond_to do |format|
      if @questionary_result.update(questionary_result_params)
        format.html { redirect_to @questionary_result, notice: 'Questionary result was successfully updated.' }
        format.json { render :show, status: :ok, location: @questionary_result }
      else
        format.html { render :edit }
        format.json { render json: @questionary_result.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @questionary_result.destroy
    respond_to do |format|
      format.html { redirect_to questionary_results_url, notice: 'Questionary result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
 
    def set_questionary_result
      @questionary_result = QuestionaryResult.find(params[:id])
    end

    def questionary_result_params
      params.require(:questionary_result).permit(:questionary_id, :result)
    end
  end
 