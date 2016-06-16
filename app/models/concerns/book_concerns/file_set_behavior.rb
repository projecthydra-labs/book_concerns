module BookConcerns
  module FileSetBehavior
    extend ActiveSupport::Concern
    included do
      include ::BookConcerns::Metadata
    end
  end
end
