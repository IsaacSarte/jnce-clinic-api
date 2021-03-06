module Api
  module V1
    class Admins::RegistrationsController < Devise::RegistrationsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        resource.persisted? ? register_success : register_failed
      end

      def register_success
        render json: { status: 201, message: 'Admin successfully added.' }, status: :created
      end

      def register_failed
        render json: { status: 401, message: resource.errors.full_messages }, status: :unauthorized
      end
    end
  end
end
