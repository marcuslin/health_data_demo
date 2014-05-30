class HealthHistoriesController < ApplicationController
  def new
    @health_data = HealthHistory.new
  end

  def create
    @health_data = HealthHistory.new(health_params)
    if @health_data.valid?
      @health_data.recorded_month = Time.now.strftime('%m')
      @health_data.recorded_year = Time.now.strftime('%Y')
      @health_data.save
      flash.now.notice = "successfully insert data"
      redirect_to root_path
    else
      flash.now.alert = "plaese make sure the data you insert is valid"
      render action: 'new'
    end
  end

  def show
    gon.weight = []
    gon.height = []
    gon.blood_pressure = []
    gon.blood_sugar = []
    gon.pulse_rate = []
    gon.sbp = []
    gon.dbp = []
    gon.mbp = []
    gon.spo2 = []
    gon.ac = []
    gon.pc =[]

    params[:weight].each do |w|
      gon.weight << w.to_f
    end

    params[:height].each do |h|
      gon.height << h.to_f
    end

    params[:blood_pressure].each do |bp|
      gon.blood_pressure << bp.to_f
    end

    params[:blood_sugar].each do |bs|
      if !bs.blank?
        gon.blood_sugar << bs.to_f
      else
        gon.blood_sugar << 0
      end
    end

    params[:pulse_rate].each do |pr|
      gon.pulse_rate << pr.to_f
    end

    params[:sbp].each do |sbp|
      gon.sbp << sbp.to_f
    end

    params[:dbp].each do |dbp|
      gon.dbp << dbp.to_f
    end

    params[:mbp].each do |mbp|
      gon.mbp << mbp.to_f
    end

    params[:spo2].each do |spo2|
      gon.spo2 << spo2.to_f
    end

    params[:ac].each do |ac|
      gon.ac << ac.to_f
    end

    params[:pc].each do |pc|
      gon.pc << pc.to_f
    end
    # binding.pry
  end

  def search_history
    patient_id = params["health_histories"]["patient_id"]
    year = params["health_histories"]["year"]
    @data = HealthHistory.where(patient_id: patient_id, recorded_year: year, recorded_month: 1..12).order('created_at ASC')
    months= (1..12)
    weight = []
    height = []
    blood_pressure = []
    blood_sugar = []
    pulse_rate = []
    sbp = []
    dbp = []
    mbp = []
    spo2 = []
    ac = []
    pc =[]

    months.each do |m|
      if !@data.where(recorded_month: m).blank?
        weight << @data.where(recorded_month: m)[0].body_weight
        height << @data.where(recorded_month: m)[0].body_height
        pulse_rate << @data.where(recorded_month: m)[0].pulse_rate
        sbp << @data.where(recorded_month: m)[0].SBP
        dbp << @data.where(recorded_month: m)[0].DBP
        mbp << @data.where(recorded_month: m)[0].MBP
        spo2 << @data.where(recorded_month: m)[0].SpO2
        ac << @data.where(recorded_month: m)[0].AC
        pc << @data.where(recorded_month: m)[0].PC
        if !@data.where(recorded_month: m)[0].blood_pressure.blank?
          blood_pressure << @data.where(recorded_month: m)[0].blood_pressure
        else
          blood_pressure << 0
        end
        if !@data.where(recorded_month: m)[0].blood_sugar.blank?
          blood_sugar << @data.where(recorded_month: m)[0].blood_sugar
        else
          blood_sugar << 0
        end
      else
        weight << 0
        height << 0
        blood_pressure << 0
        blood_sugar << 0
        pulse_rate << 0
        sbp << 0
        dbp << 0
        mbp << 0
        spo2 << 0
        ac << 0
        pc << 0
      end
    end
    redirect_to generate_url("/health_histories/show", :weight => weight, :height => height,
                             :blood_pressure => blood_pressure, :blood_sugar => blood_sugar,
                             :pulse_rate => pulse_rate, :sbp => sbp, :dbp => dbp, :mbp => mbp,
                              :spo2 => spo2, :ac => ac, :pc => pc
    )
  end

  def generate_url(url, params = {})
    uri = URI(url)
    uri.query = params.to_query
    uri.to_s
  end

  def find_patient_id_by_name
    patient_id = Patient.where(patient_name: params[:patient_name])[0].id
    render json: {data: patient_id}
  end

  def find_patient_chart

  end

  def destroy_by_month
    demo_data = HealthHistory.where(recorded_month: '4')

    demo_data.each do |d|
      d.destroy
    end
    redirect_to root_path
  end
private
  def health_params
    params.require(:health_history).permit(:patient_id, :body_weight, :body_height, :blood_pressure, :pulse_rate, :SBP, :DBP, :MBP, :SpO2, :AC, :PC)
  end
end
