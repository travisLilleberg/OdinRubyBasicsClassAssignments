# frozen_string_literal: true

require_relative 'node'
require_relative 'modules/binary_insert_methods'
require_relative 'modules/binary_delete_methods'
require_relative 'modules/binary_traversal_methods'
require_relative 'modules/depth_and_height_methods'

# A binary tree implemented in ruby.
class Tree
  include BinaryTraversalMethods
  include BinaryInsertMethods
  include BinaryDeleteMethods
  include DepthAndHeightMethods

  attr_accessor :root

  def initialize
    @root = nil
  end

  def build_tree(array)
    array.uniq!
    array.sort!
    p array

    @root = build_tree_recur(array, 0, array.length - 1)
    @root
  end

  # rubocop:disable Metrics/MethodLength
  def include?(value)
    current = @root
    while current
      case value <=> current.data
      when 0
        return true
      when 1
        current = current.right
      when -1
        current = current.left
      end
    end

    false
  end
  # rubocop:enable Metrics/MethodLength

  def balanced?
    return true if @root.nil?

    balanced_recur(@root) != -1
  end

  def rebalance
    build_tree(inorder.to_a)
  end

  # rubocop:disable Style/OptionalBooleanParameter
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  # rubocop:enable Style/OptionalBooleanParameter

  private

  def build_tree_recur(array, first, last)
    return nil if first > last

    mid = first + ((last - first) / 2)

    Node.new(
      array[mid],
      build_tree_recur(array, first, mid - 1),
      build_tree_recur(array, mid + 1, last)
    )
  end

  def balanced_recur(node)
    return 0 if node.nil?

    l_height = balanced_recur(node.left)
    return -1 if l_height == -1

    r_height = balanced_recur(node.right)
    return -1 if r_height == -1 || (l_height - r_height).abs > 1

    [l_height, r_height].max + 1
  end
end
