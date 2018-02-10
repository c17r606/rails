class QuestionaryChoicesController < ApplicationController
  before_action :set_questionary_choice, only: [:show, :edit, :update, :destroy]

  def index
    @questionary_choices = QuestionaryChoice.all
  end

  def show
  end

  def new
    @questionary_choice = QuestionaryChoice.new
    @questionary_choice.questionary_item_id = params[:id]
    @questionary_item = QuestionaryItem.find params[:id]

  end

  def edit
  end

  def create
    @questionary_choice = QuestionaryChoice.new(questionary_choice_params)

    respond_to do |format|
      if @questionary_choice.save
        format.html { redirect_to '/questionary_choices/new/' +
        @questionary_choice.questionary_item_id.to_s }
        format.json { render :show, status: :created, location:
        @questionary_choice }
      else
        format.html { render :new }
        format.json { render json: @questionary_choice.errors,
        status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @questionary_choice.update(questionary_choice_params)
        format.html { redirect_to @questionary_choice, notice: 'Questionary choice was successfully updated.' }
        format.json { render :show, status: :ok, location: @questionary_choice }
      else
        format.html { render :edit }
        format.json { render json: @questionary_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @questionary_choice.destroy
    respond_to do |format|
      format.html { redirect_to questionary_choices_url, notice: 'Questionary choice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_questionary_choice
      @questionary_choice = QuestionaryChoice.find(params[:id])
    end

    def questionary_choice_params
      params.require(:questionary_choice).permit(:content, :value, :questionary_item_id)
    end
end
