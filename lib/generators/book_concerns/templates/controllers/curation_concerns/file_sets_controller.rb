module CurationConcerns
  class FileSetsController < ApplicationController
    include CurationConcerns::FileSetsControllerBehavior
    include BookConcerns::FileSetsControllerBehavior
  end
end
