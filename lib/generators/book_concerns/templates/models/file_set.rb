class FileSet < ActiveFedora::Base
  include ::CurationConcerns::FileSetBehavior
  include ::BookConcerns::FileSetBehavior
end
