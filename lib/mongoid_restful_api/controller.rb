class MongoidRestfulApiController < ActionController::Base

  before_filter :set_key, :set_model, :set_document

  def index
    render :json => { @key.pluralize => @model.all }
  end

  def create
    @document = @model.create attributes
    respond
  end

  def show
    respond
  end

  def update
    @document.update_attributes attributes
    respond
  end

  def destroy
    @document.destroy
    head :no_content
  end

  protected

  def respond
    attributes = @document.attributes.select do |k|
      k.to_sym != :versions
    end
    render :json => { @key => attributes }
  end

  private

  def set_key
    if params[:model].blank?
      if controller_name.to_sym == :mongoid_restful_api
        msg = 'MongoidRestfulApiController may not be routed to directly'
        raise MongoidRestfulApi::RoutingError, msg
      else
        @key = controller_name.singularize
      end
    else
      @key = params[:model].singularize
    end
  end

  def set_model
    begin
      model = @key.camelize.constantize
    rescue
      Object.const_set(
        @key.camelize,
        Class.new do
          def self.include_mongoid
            class_eval do
              include Mongoid::Document
              include Mongoid::Timestamps
            end
            self.singleton_class
          end
        end
      )
      model = @key.camelize.constantize
      model.include_mongoid.send :remove_method, :include_mongoid
    end
    @model = model.without :versions
  end

  def set_document
    unless params[:id].blank?
      @document = @model.find params[:id]
    end
  end

  def attributes
    if params[@key].is_a? Hash
      params[@key].select { |k| k.to_sym != :_id }
    end
  end

end
