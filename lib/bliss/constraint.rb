module Bliss
  class Constraint
    attr_reader :depth, :setting, :state

    def initialize(depth, setting, params={})
      @depth = depth
      @setting = setting

      @state = :not_checked
    end

    # TODO should exist another method passed! for tag_name_required ?
    def run!(hash=nil)
      @state = :not_checked
      #@field.each do |field|
        #if @state == :passed
        #  break
        #end
        case @setting
          when :tag_name_required
            if hash
              if !hash.keys.include?(@depth.last)
                @state = :not_passed
              else
                @state = :passed
              end
            else
              @state = :passed
            end
          #when :not_blank
          #  if hash.has_key?(field) and !hash[field].to_s.empty?
          #    @state = :passed
          #  else
          #    @state = :not_passed
          #  end
          #when :possible_values
          #  if hash.has_key?(field) and @possible_values.include?(hash[field])
          #    @state = :passed
          #  else
          #    @state = :not_passed
          #  end
        end
      #end
      @state
    end

    def ended!
      case @setting
        when :tag_name_required
          if @state == :not_checked
            @state = :not_passed
          end
      end
    end

    def detail
      self.ended!

      case @state
        when :not_passed
          case @setting
            when :tag_name_required
              [@depth.join("/"), "missing"]
            #when :not_blank
            #  [@field.join(" or "), "blank"]
            #when :possible_values
            #  [@field.join(" or "), "invalid"]
          end
        when :passed
          case @setting
            when :tag_name_required
              [@depth.join('/'), "exists"]
          end
      end
    end

    #def self.build_constraint(depth, setting, params={})#, field, type, possible_values=nil)
    #  constraints = []
      #constraints.push Bliss::Constraint.new(field, :exist) if types.include?(:exist)
      #constraints.push Bliss::Constraint.new(field, :not_blank) if types.include?(:not_blank)
      #constraints.push BlissConstraint.new(field, :possible_values, possible_values) if types.include?(:possible_values)
    #  constraints
    #end
  end
end
