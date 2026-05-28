class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # INDEX
  def index
    @appointments = policy_scope(
      Appointment.upcoming.includes(:pet, :vet)
    )
  end

  # PAST
  def past
    @appointments = policy_scope(
      Appointment.past.includes(:pet, :vet)
    )

    render :index
  end

  # SHOW
  def show
    @appointment = Appointment
      .includes(:pet, :vet, treatments: [:rich_text_clinical_notes])
      .find(params[:id])

    authorize @appointment
  end

  # NEW
  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  # CREATE
  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment

    if @appointment.save
      redirect_to @appointment, notice: "Appointment created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # EDIT
  def edit
    authorize @appointment
  end

  # UPDATE
  def update
    authorize @appointment

    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: "Appointment updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DESTROY
  def destroy
    authorize @appointment

    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted."
  end

  private

  def set_appointment
    @appointment = Appointment
      .includes(:pet, :vet)
      .find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(
      :date,
      :reason,
      :status,
      :pet_id,
      :vet_id
    )
  end
end