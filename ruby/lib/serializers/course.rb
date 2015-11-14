module Serializers
  class Course < Base
    structure(:default) do |arg|
      {
        code:        arg.code,
        created_at:  arg.created_at.try(:iso8601),
        description: arg.description,
        id:          arg.id,
        name:        arg.name,
        updated_at:  arg.updated_at.try(:iso8601)
      }
    end
  end
end
