# frozen_string_literal: true

require "test_helper"

class ViewComponent::Base::UnitTest < Minitest::Test
  def test_templates_parses_all_types_of_paths
    file_path = [
      "/Users/fake.user/path/to.templates/component/test_component.html+phone.erb",
      "/_underscore-dash./component/test_component.html+desktop.slim",
      "/tilda~/component/test_component.html.haml"
    ]
    expected = [
      {variant: :phone, handler: "erb"},
      {variant: :desktop, handler: "slim"},
      {variant: nil, handler: "haml"}
    ]

    ViewComponent::Base.stub(:matching_views_in_source_location, file_path) do
      templates = ViewComponent::Base.send(:templates)

      templates.each_with_index do |template, index|
        assert_equal(template[:path], file_path[index])
        assert_equal(template[:variant], expected[index][:variant])
        assert_equal(template[:handler], expected[index][:handler])
      end
    end
  end

  def test_template_arguments_validates_existence
    error = assert_raises ArgumentError do
      Class.new(ViewComponent::Base) do
        def self.matching_views_in_source_location
          [
            "/Users/fake.user/path/to.templates/component/test_component/test_component.html.erb",
            "/Users/fake.user/path/to.templates/component/test_component/sidecar.html.erb",
          ]
        end
        template_arguments :non_existing, [:foo]
      end
    end
    assert_equal "Template does not exist: non_existing", error.message
  end

  def test_template_arguments_validates_duplicates
    error = assert_raises ArgumentError do
      Class.new(ViewComponent::Base) do
        def self.matching_views_in_source_location
          [
            "/Users/fake.user/path/to.templates/component/test_component/test_component.html.erb",
            "/Users/fake.user/path/to.templates/component/test_component/sidecar.html.erb",
          ]
        end
        template_arguments :sidecar, [:foo]
        template_arguments :sidecar, [:bar]
      end
    end
    assert_equal "Arguments already defined for template sidecar", error.message
  end
end
