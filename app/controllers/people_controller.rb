class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update]

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    respond_to do |format|
      if @person.save
        cookies[:guess] = @person.run_predictor
        format.html { redirect_to edit_person_path(@person), notice: "Are you a #{cookies[:guess]}?" }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update_attributes(person_params)
        @person.add_person_to_aggregate
        verify = @person.verify
        if verify[cookies[:guess]] == person_params["gender"].to_i
          notice = "Interesting, it looks like we were correct! Play again?"
        else
          notice = "Ah, we guessed wrong. Play again?"
        end
        cookies.delete(:guess)
        format.html { redirect_to new_person_path, notice: notice }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:weight, :height, :gender)
    end
end
