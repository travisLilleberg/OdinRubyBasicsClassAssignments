# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

# Contains binary methods for determining depth and height
module DepthAndHeightMethods
  def depth(value)
    return nil if @root.nil?

    depth = 0
    queue = [@root]

    until queue.empty?
      nodes_on_this_level = queue.length
      i = 0

      while i < nodes_on_this_level
        node = queue.shift

        return depth if node.data == value

        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?

        i += 1
      end

      depth += 1
    end

    nil
  end

  def height
    return nil if @root.nil?

    height_recur(@root)
  end

  def height_loop
    return nil if @root.nil?

    stack = []
    current = @root
    max_stack = 0
    prev_right = nil

    until current.nil? && stack.empty?
      if current
        stack << current
        max_stack = stack.length if stack.length > max_stack
        current = current.left
      else
        top = stack.last
        if top.right && (prev_right.nil? || top.right != prev_right)
          current = top.right
        else
          prev_right = stack.pop
        end
      end
    end

    (max_stack - 1)
  end

  private

  def height_recur(node)
    return -1 if node.nil?

    l_height = height_recur(node.left)
    r_height = height_recur(node.right)

    [l_height, r_height].max + 1
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
