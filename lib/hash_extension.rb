class Hash
  def value_at_chain(chain)
    current = self
    chain.each do |key|
      if current.is_a? Hash and current.has_key? key
        current = current[key]
        if current.is_a? Array
          current = current.last
        end
      else
        current = nil
        break
      end
    end
    return current
  end

  def pair_at_chain(chain)
    chain = chain.dup
    chain.pop
    return self.value_at_chain(chain)
  end

  def recurse(include_root=false, depth=[], &block)
    self.each_pair { |k,v|
      if v.is_a? Hash
        if include_root
          block.call(depth + [k], v)
        end
        depth.push k
        v.recurse(include_root, depth, &block)
      else
        block.call(depth + [k], v)
        #return "#{depth + [k]}: #{v.inspect}"
      end
    }
    depth.pop
  end
end
