# frozen_string_literal: true

require_relative '../node'

# rubocop:disable Metrics/MethodLength

# Contains methods for insertion in Tree.rb class (or any binary tree class).
module BinaryInsertMethods
  def insert(value)
    node = Node.new(value)

    if @root.nil?
      @root = node
      return true
    end

    insert_recur(node, @root)
  end

  private

  def insert_recur(new_node, reference_node)
    case new_node <=> reference_node
    when 1
      if reference_node.right.nil?
        reference_node.right = new_node
        true
      else
        insert_recur(new_node, reference_node.right)
      end
    when -1
      if reference_node.left.nil?
        reference_node.left = new_node
        true
      else
        insert_recur(new_node, reference_node.left)
      end
    else
      # Remove duplicates
      false
    end
  end
end

# rubocop:enable Metrics/MethodLength
