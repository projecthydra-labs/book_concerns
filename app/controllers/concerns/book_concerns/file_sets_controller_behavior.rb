module BookConcerns
  module FileSetsControllerBehavior
    extend ActiveSupport::Concern
    included do
      self.form_class = BookConcerns::Forms::FileSetEditForm
    end
  end
end
