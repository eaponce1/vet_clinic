class VetsController < ApplicationController
  before_action :set_vet, only: [:show, :edit, :update, :destroy]

  # INDEX
  def index
    @vets = policy_scope(Vet.includes(:appointments))
  end

  # SHOW
  def show
    authorize @vet
  end

  # NEW
  def new
    @vet = Vet.new
    authorize @vet
  end

  # CREATE
  def create
    @vet = Vet.new(vet_params)
    authorize @vet

    if @vet.save
      redirect_to @vet, notice: "Vet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # EDIT
  def edit
    authorize @vet
  end

  # UPDATE
  def update
    authorize @vet

    if @vet.update(vet_params)
      redirect_to @vet, notice: "Vet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DESTROY
  def destroy
    authorize @vet

    @vet.destroy
    redirect_to vets_path, notice: "Vet was successfully deleted."
  end

  private

  def set_vet
    @vet = Vet.find(params[:id])
  end

  def vet_params
    params.require(:vet).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :specialization,
      :user_id
    )
  end
end