module BookConcerns
  module Forms
    class FileSetEditForm < CurationConcerns::Forms::FileSetEditForm
      self.terms += [:viewing_hint]

      def self.model_attributes(attrs)
        attrs[:viewing_hint] = Array(attrs[:viewing_hint]) if attrs[:viewing_hint]
        super(attrs)
      end

      def viewing_hint
        self[:viewing_hint].first
      end
    end
  end
end
