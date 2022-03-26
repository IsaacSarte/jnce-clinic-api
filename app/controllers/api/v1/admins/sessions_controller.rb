module Api
  module V1
    class Admins::SessionsController < Devise::SessionsController
      respond_to :json

      private

      def respond_with(_resource, _opts = {})
        render json: { message: 'Logged.' }, status: :created
      end

      def respond_to_on_destroy
        current_admin ? log_out_success : log_out_failure
      end

      def log_out_success
        render json: { message: 'Logged out.' }, status: :ok
      end

      def log_out_failure
        render json: { message: 'Logged out failure.' }, status: :unauthorized
      end
    end
  end
end