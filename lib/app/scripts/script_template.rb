module MyApp
  class Script_Template

    def my_method()

    end

  end

  def self.script
    @__b_instance ||= Script_Template.new
  end

end