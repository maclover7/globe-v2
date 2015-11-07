module Serializers
  class User < Base
    structure(:default) do |arg|
      {
        created_at: arg.created_at.try(:iso8601),
        email:      arg.email,
        id:         arg.id,
        name:       arg.name,
        updated_at: arg.updated_at.try(:iso8601)
      }
    end
  end
end
