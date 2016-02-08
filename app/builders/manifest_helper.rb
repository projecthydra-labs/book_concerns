class ManifestHelper
  include Rails.application.routes.url_helpers
  include BookConcerns::Engine.routes.url_helpers
  include ActionDispatch::Routing::PolymorphicRoutes

  def polymorphic_url(record, opts={})
    opts ||= {}
    opts[:host] ||= host
    super(record, opts)
  end

  private

    def host
      Rails.application.config.action_mailer.default_url_options[:host]
    end
end
