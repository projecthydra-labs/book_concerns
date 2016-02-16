module BookConcerns
  module Ability
    def everyone_can_manifest_curation_concerns
      return unless registered_user?
      can :manifest, [::FileSet, ::Collection]
      can :manifest, [CurationConcerns.config.curation_concerns]
    end
  end
end
