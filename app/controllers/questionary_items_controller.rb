class QuestionaryItemsController < ApplicationController
  before_action :set_questionary_item, only: [:show, :edit, :update, :destroy]

  def index
    @questionary_items = QuestionaryItem.all
  end

  def show
  end

def new
    @questionary_item = QuestionaryItem.new
       @questionary_item.questionary_id = params[:id]
            @questionary = Questionary.find params[:id]
  end

  def edit
  end

  def create
    @questionary_item = QuestionaryItem.new(questionary_item_params)

    respond_to do |format|
      if @questionary_item.save
        format.html { redirect_to '/questionary_choices/new/' + @questionary_item.id.to_s }
        format.json { render :show, status: :created, location: @questionary_item }
      else
        format.html { render :new }
        format.json { render json: @questionary_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @questionary_item.update(questionary_item_params)
        format.html { redirect_to @questionary_item, notice: 'Questionary item was successfully updated.' }
        format.json { render :show, status: :ok, location: @questionary_item }
      else
        format.html { render :edit }
        format.json { render json: @questionary_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @questionary_item.destroy
    respond_to do |format|
      format.html { redirect_to questionary_items_url, notice: 'Questionary item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_questionary_item
      @questionary_item = QuestionaryItem.find(params[:id])
    end

 
    def questionary_item_params
      params.require(:questionary_item).permit(:content, :questionary_id)
    end
end
