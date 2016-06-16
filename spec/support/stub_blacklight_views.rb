module BlacklightStubbing
  def stub_blacklight_views
    allow(view).to receive(:dom_class) { '' }
    allow(view).to receive(:can?).and_return(true)
    allow(view).to receive(:blacklight_config).and_return(CatalogController.new.blacklight_config)
    allow(view).to receive(:blacklight_configuration_context).and_return(Blacklight::Configuration::Context.new(controller))
    allow(view).to receive(:search_session).and_return({})
    allow(view).to receive(:current_search_session).and_return(nil)
    allow(view).to receive(:contextual_path).with(anything, anything) do |x, y|
      CurationConcerns::ContextualPath.new(x, y).show
    end
  end
end

RSpec.configure do |config|
  config.include BlacklightStubbing
end
