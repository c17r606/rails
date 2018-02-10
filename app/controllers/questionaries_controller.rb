class QuestionariesController < ApplicationController
  before_action :set_questionary, only: [:show, :edit, :update, :destroy]

  def index
    @questionaries = Questionary.all.order('created_at desc')
  end

 def show
 end

 def sendform
  id = params[:id]
  result ='question_id:' + id
  for i in 1..10
    str = 'r' + i.to_s
    if params[str] == nil then
      result += ',' + str + ':0'
    else
      result += ',' + str + ':' + params[str]
    end
  end
  obj = QuestionaryResult.new
  obj.questionary_id = id
  obj.result = result
  obj.save!
  redirect_to '/questionaries'
end

  def new
    @questionary = Questionary.new
  end

  def edit
  end

  def create
    @questionary = Questionary.new(questionary_params)

    respond_to do |format|
      if @questionary.save
        format.html { redirect_to '/questionary_items/new/' + @questionary.id.to_s }
        format.json { render :show, status: :created, location: @questionary }
      else
        format.html { render :new }
        format.json { render json: @questionary.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @questionary.update(questionary_params)
        format.html { redirect_to @questionary, notice: 'Questionary was successfully updated.' }
        format.json { render :show, status: :ok, location: @questionary }
      else
        format.html { render :edit }
        format.json { render json: @questionary.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @questionary.destroy
    respond_to do |format|
      format.html { redirect_to questionaries_url, notice: 'Questionary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_questionary
      @questionary = Questionary.find(params[:id])
    end

    def questionary_params
      params.require(:questionary).permit(:title, :description, :deadline)
    end
end
