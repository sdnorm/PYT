class Current < ActiveSupport::CurrentAttributes
  attribute :session

  def user
    session&.user
  end

  def session=(value)
    super
    # Ensure we're setting a valid session
    unless value.nil? || (value.is_a?(Session) && value.user.present?)
      Rails.logger.warn "Attempted to set invalid session: #{value.inspect}"
      super(nil)
    end
  end
end
