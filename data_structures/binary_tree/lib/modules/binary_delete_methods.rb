# frozen_string_literal: true

require_relative '../node'

# rubocop:disable Metrics/MethodLength

# Contains methods for deletion in Tree.rb class (or any binary tree class).
module BinaryDeleteMethods
  def delete(value)
    return false if @root.nil?

    delete_recur(value, Node.new(-10_000_000_000_000, nil, @root))
  end

  private

  def delete_recur(value, reference_node)
    direction = case value <=> reference_node.data
                when 1
                  'right'
                when -1
                  'left'
                else
                  throw StandardError.new('Search value should not match reference_node, it should match a child node.')
                end

    target_node = reference_node.send(direction)

    # We hit the end of the tree without finding the value.
    return false if target_node.nil?

    # We found the value.
    if value == target_node.data
      delete_node(reference_node, direction)
      return true
    end

    # We need to keep searching the tree.
    delete_recur(value, target_node)
  end

  # Direction should be "left" or "right".
  def delete_node(reference_node, direction)
    return if check_empty_branches?(reference_node, direction)

    # Node-to-delete has both right and left child nodes, so we have to swap some values around.
    target = reference_node.send(direction)
    swap_nodes(target)
  end

  # Checks if one or both of a node's branches are empty.
  def check_empty_branches?(reference_node, direction)
    target = reference_node.send(direction)

    left_is_nil = target.left.nil?
    right_is_nil = target.right.nil?

    return false unless left_is_nil || right_is_nil

    # Either left or right is nil (or both), so figure out what to set reference_node."@directon" to.
    if left_is_nil
      # Double nil means leaf node, which can be deleted without moving anything.
      if right_is_nil
        reference_node.instance_variable_set("@#{direction}", nil)
      # Only right exists, so swap with right.
      else
        reference_node.instance_variable_set("@#{direction}", target.right)
      end
    # Only left exists, so swap with left.
    else
      reference_node.instance_variable_set("@#{direction}", target.left)
    end

    true
  end

  # rubocop:disable Metrics/AbcSize
  def swap_nodes(target)
    # Get right node first.
    swap = target.right
    # If there's no target.right.left, swap with target.right
    if swap.left.nil?
      target.data = swap.data
      target.right = swap.right
      return
    end

    # Follow target.right.left all the way down.
    while swap.left
      # Once at parent of the last left node, swap values and delete last left node.
      if swap.left.left.nil?
        target.data = swap.left.data
        swap.left = nil
      else
        swap = swap.left
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end

# rubocop:enable Metrics/MethodLength
