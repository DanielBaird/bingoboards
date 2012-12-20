
class ProgressIndicator
    # -----------------------------------------------------
    def initialize(indicator_list = ['\\', '|', '/', '-'])
        @indicators = indicator_list
        @indicator_count = @indicators.length
        @indicator_width = @indicators[0].to_s.length
        @back = "\033[#{indicator_width}D"

        @progress = 0
    end
    # -----------------------------------------------------
    def start
        unless progress > 0
            print @indicators[@progress % @indicator_count]
            @progress += 1
        end
        self
    end
    # -----------------------------------------------------
    def again
        print @back + @indicators[@progress % @indicator_count]
        @progress += 1
        self
    end
    # -----------------------------------------------------
    def advance
        print @back + '.' + @indicators[@progress % @indicator_count]
        self
    end
    # -----------------------------------------------------
    def end
        self
    end
    # -----------------------------------------------------
end
