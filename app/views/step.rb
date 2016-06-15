class Step < PM::TableViewCell

  attr_accessor :step_idx

  def on_load
    apply_style :step

    content = find(self.contentView)
    20.times.map do |idx|
      label =
        content
          .append(UILabel, :led)
          .tag(tag_name)
          .get
      label.style do |st|
        st.frame = {l: idx * StepStylesheet::STEP_HEIGHT}
      end
      label
    end
    @leds = find(tag_name)
  end

  def on
    animate_enlighten
  end

private

  def tag_name
    :"step_idx_#{step_idx}"
  end

  def animate_random_opacity
    find(tag_name).animate(
      duration: 2,
      animations: -> (q) {
          q.style do |st|
            st.opacity = (0..10).to_a.sample * 0.1
          end
        }
    )
  end

  def animate_enlighten
    leds_from_middle_outward.each_with_index do |leds, idx|
      leds.each do |led|
        led.animate(
          duration: 0.5,
          delay: 0.03 * idx,
          animations: -> (q) {
            q.style do |st|
              st.opacity = 1
            end
          },
        )
      end
    end
  end

  def leds_from_middle_outward
    half = @leds.size / 2
    middle = @leds.size.even? ? [] : [[@leds[half]]]
    middle +
      half.times.map do |idx|
        [
          @leds[half - idx - 1],
          @leds[-(half - idx)],
        ]
      end
  end

end



__END__

You can use this like so in your table_screen:

  def table_data
    [
      {
        title: "Section",
        cells: [
          { cell_class: BarCell, height: stylesheet.bar_cell_height, title: "Foo"},
          { cell_class: BarCell, height: stylesheet.bar_cell_height, title: "Bar"}
        ]
      }
    ]
  end


To style this view include its stylesheet at the top of each controller's
stylesheet that is going to use it:

  class SomeStylesheet < ApplicationStylesheet
    include StepStylesheet

Another option is to use your controller's stylesheet to style this view. This
works well if only one controller uses it. If you do that, delete the
view's stylesheet with:

  rm app/stylesheets/step_stylesheet.rb
