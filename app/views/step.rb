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
    animate_enlighten(completion: fade_out)
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

  def animate_enlighten(opts)
    leds_from_middle_outward.each_with_index do |leds, idx|
      leds.each do |led|
        led.animate(
          duration: 0.3,
          delay: 0.1 * idx,
          animations: -> (q) {
            q.style do |st|
              st.opacity = 1
            end
          },
          completion: opts.fetch(:completion),
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

  def fade_out
    -> (_, led) {
      led.animate(
        duration: 1.5,
        delay: 2,
        animations: -> (q) {
          q.style do |st|
            st.opacity = 0
          end
        },
      )
    }
  end

end
