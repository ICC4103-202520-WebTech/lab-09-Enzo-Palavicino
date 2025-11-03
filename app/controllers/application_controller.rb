class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  after_action :verify_authorized, unless: :skip_pundit_verification?, if: :pundit_verify_authorized?
  after_action :verify_policy_scoped, unless: :skip_pundit_verification?, if: :pundit_verify_policy_scoped?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def skip_pundit_verification?
    devise_controller? || request.format.turbo_stream?
  end

  def pundit_verify_authorized?
    !%w[index show].include?(action_name)
  end

  def pundit_verify_policy_scoped?
    action_name == "index"
  end

  def user_not_authorized
    redirect_to(request.referer || root_path, alert: "You are not authorized to perform this action.")
  end
end
