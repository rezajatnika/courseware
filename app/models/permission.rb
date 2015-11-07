class Permission
  def initialize(user)
    allow(:users, [:new, :create])
    allow(:courses, [:index])

    if user
      allow(:courses, [:show])

      if user.lecturer?
        allow(:courses, [:new, :create])
        allow(:courses, [:edit, :update, :destroy]) do |course|
          course.lecturer_id == user.id
        end

        allow(:feeds, [:new, :create])
        allow(:feeds, [:edit, :update, :destroy]) do |feed|
          feed.lecturer_id == user.id
        end
      end
    end
  end

  # allow?(params[:controller], params[:action], current_resource)
  # if user.admin?
  # allowed = true
  # else
  # allowed = @allowed_actions
  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end

  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow_param(resources, attributes)
    @allowed_params ||= {}
    Array(resources).each do |resource|
      @allowed_params[:resource] = []
      @allowed_params[:resource] += Array(attributes)
    end
  end

  def allow_param?(resource, attribute)
    if @allow_all
      true
    elsif @allowed_params && @allowed_params[:resource]
      @allowed_params[:resource].include?(attribute)
    end
  end

  def permit_params!(params)
    if @allow_all
      params.permit!
    elsif @allowed_params
      @allowed_params.each do |resource, attributes|
        if params[resource].respond_to?(:permit)
          params[resource] = params[resource].permit(*attributes)
        end
      end
    end
  end
end
