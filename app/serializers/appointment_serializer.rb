class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :email, :title, :location, :start_datetime, :end_datetime, :status, :created_at, :updated_at

  attribute :service do
    object.service
  end
end
