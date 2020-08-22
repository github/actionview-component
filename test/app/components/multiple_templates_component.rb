# frozen_string_literal: true

class MultipleTemplatesComponent < ViewComponent::Base
  def initialize(mode:)
    @mode = mode

    @items = ["Apple", "Banana", "Pear"]
  end

  template_arguments :list, :number
  template_arguments :summary, :string

  def call
    case @mode
    when :list
      call_list number: 1
    when :summary
      call_summary string: "foo"
    end
  end
end
