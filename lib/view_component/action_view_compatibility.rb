# frozen_string_literal: true

module ViewComponent
  module ActionViewCompatibility
    attr_accessor :top_level_parent

    def children
      @_children ||= []
    end

    def set_output_buffer(buf)
      @output_buffer = buf
    end

    def output_buffer=(buf)
      if top_level_parent
        top_level_parent.set_output_buffer_for_children(buf)
      else
        set_output_buffer_for_children(buf)
      end
    end

    def set_output_buffer_for_children(buf)
      set_output_buffer(buf)

      children.each do |child|
        child.set_output_buffer(buf)
      end
    end
  end
end
