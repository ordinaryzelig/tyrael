class StairsScreen < PM::TableScreen
  title "Your title here"
  stylesheet StairsScreenStylesheet

  def on_load
  end

  def table_data
    [{
      cells: 23.times.map do |idx|
        {
          cell_class: Step,
          height: StepStylesheet::STEP_HEIGHT,
          action: :step_on,
          arguments: {step_idx: idx}
        }
      end
    }]
  end

  def on_cell_created(new_cell, data_cell)
    new_cell.step_idx = data_cell.fetch(:arguments).fetch(:step_idx)
    super
  end

  def step_on(args, index_path)
    step = tableView(nil, cellForRowAtIndexPath: index_path)
    step.on
  end

  # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
  # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
  #   def logo(st)
  #     st.frame = {t: 10, w: 200, h: 96}
  #     st.centered = :horizontal
  #     st.image = image.resource('logo')
  #     st.tag(:reapply_style)
  #   end
  #
  # Then in will_animate_rotate
  #   find(:reapply_style).reapply_styles#

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
