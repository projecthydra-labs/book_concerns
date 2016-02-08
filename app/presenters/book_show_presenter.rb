class BookShowPresenter < CurationConcerns::WorkShowPresenter
  def manifest_url
    manifest_helper.polymorphic_url([:manifest, self])
  end

  def file_set_presenters
    file_presenters.select do |presenter|
      presenter.model_name.singular == "file_set"
    end
  end

  private

    def manifest_helper
      @manifest_helper ||= ManifestHelper.new
    end
end
