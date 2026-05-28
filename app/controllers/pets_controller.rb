class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  # INDEX
  def index
    @pets = policy_scope(Pet.includes(:owner))
  end

  # SHOW
  def show
    authorize @pet
  end

  # NEW
  def new
    @pet = Pet.new
    authorize @pet
  end

  # CREATE
  def create
    @pet = Pet.new(pet_params)
    authorize @pet

    if @pet.save
      redirect_to @pet, notice: "Pet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # EDIT
  def edit
    authorize @pet
  end

  # UPDATE
  def update
    authorize @pet

    if @pet.update(pet_params)
      redirect_to @pet, notice: "Pet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DESTROY
  def destroy
    authorize @pet

    @pet.destroy
    redirect_to pets_path, notice: "Pet was successfully deleted."
  end

  private

  def set_pet
    @pet = Pet.includes(:owner).find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(
      :name,
      :species,
      :breed,
      :date_of_birth,
      :weight,
      :owner_id,
      :photo
    )
  end
end