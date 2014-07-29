class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy, :approve]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new

  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  def approve
    if @notification.action == "Add"
      HorseCondition.find_or_create_by!(:horse_id => @notification.send_id, :condition_id => @notification.recv_id)
    elsif @notification.action == "Nominate"
      horserace = Horserace.new
      horserace.horse_id = @notification.recv_id
      horserace.race_id = @notification.send_id
      horserace.status = 'Confirmed'
      horserace.save
    else
      HorseCondition.where(:horse_id => @notification.send_id, :condition_id => @notification.recv_id).delete_all
    end

    @notification.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Approval was successful' }
    end
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to :back, notice: 'Notification Sent' }
      else
        format.html { render :back }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    if @notification.action == "Add"
      HorseCondition.where(:horse_id => @notification.send_id, :condition_id => @notification.recv_id).delete_all
    elsif @notification.action == "Remove"
      HorseCondition.find_or_create_by!(:horse_id => @notification.send_id, :condition_id => @notification.recv_id)
    elsif @notification.action == "Nominate"
      horserace = Horserace.new
      horserace.horse_id = @notification.recv_id
      horserace.race_id = @notification.send_id
      horserace.status = 'Denied'
      horserace.save
    else
    end

    @notification.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Notification was successful' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params[:notification].permit(:send_id, :recv_id, :action)
    end
end