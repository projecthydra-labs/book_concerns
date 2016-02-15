class ManifestFactory
  def self.new(work)
    if work.work_presenters.length > 0 && work.file_set_presenters.length == 0
      CollectionManifestBuilder.new(work)
    else
      ManifestBuilder.new(work)
    end
  end
end
