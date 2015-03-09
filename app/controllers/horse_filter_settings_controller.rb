class HorseFilterSettingsController < ApplicationController
  before_action :set_horse_filter_setting, only: [:show, :edit, :update, :destroy]

  def index
    @horse_filter_settings = HorseFilterSetting.all
    respond_with(@horse_filter_settings)
  end

  def show
    respond_with(@horse_filter_setting)
  end

  def new
    @horse_filter_setting = HorseFilterSetting.new
    respond_with(@horse_filter_setting)
  end

  def edit
  end

  def create
    @horse_filter_setting = HorseFilterSetting.new(horse_filter_setting_params)
    @horse_filter_setting.save
    respond_with(@horse_filter_setting)
  end

  def update
    @horse_filter_setting.update(horse_filter_setting_params)
    respond_with(@horse_filter_setting)
  end

  def destroy
    @horse_filter_setting.destroy
    respond_with(@horse_filter_setting)
  end

  private
    def set_horse_filter_setting
      @horse_filter_setting = HorseFilterSetting.find(params[:id])
    end

    def horse_filter_setting_params
      params[:horse_filter_setting]
    end
end
